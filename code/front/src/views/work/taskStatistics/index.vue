<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="100px">
      <el-form-item label="统计维度" prop="dimension">
        <el-select v-model="queryParams.dimension" placeholder="请选择统计维度" clearable>
          <el-option
            v-for="dict in dict.type.wh_statistics_dimension"
            :key="dict.value"
            :label="dict.label"
            :value="parseInt(dict.value)"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="所属年月" prop="month">
        <el-date-picker
          v-model="queryParams.month"
          type="month"
          placeholder="选择年月"
          format="yyyy 年 MM 月"
          value-format="yyyy-MM"
          :disabled="monthDisabled"
          @change="yearDisabled=true"
          @input="yearDisabled=false">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="所属年份" prop="year">
        <el-date-picker
          v-model="queryParams.year"
          type="year"
          placeholder="选择年"
          format="yyyy 年"
          value-format="yyyy"
          :disabled="yearDisabled"
          @change="monthDisabled=true"
          @input="monthDisabled=false">
        </el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-table 
      v-loading="loading" 
      :data="statisticsList" 
      >
      <el-table-column label="员工名称" align="center" prop="staffName" />
      <el-table-column label="员工编号" align="center" prop="staffNo" />
      <el-table-column label="统计维度" align="center" prop="dimension">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_statistics_dimension" :value="scope.row.dimension"/>
        </template>
      </el-table-column>
      <el-table-column label="总工时" align="center" prop="totalWorkingHours" >
        <template slot-scope="scope">
          {{ scope.row.totalWorkingHours.toFixed(1) }}
        </template>
      </el-table-column>
      <el-table-column label="分配次数" align="center" prop="amount" />
      <el-table-column label="所属年月" align="center" prop="month" />
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />
  </div>
</template>

<script>
import { listPageTaskStatistics } from "@/api/work/taskStatistics";

export default {
  name: "TaskStatistics",
  dicts: ['wh_statistics_dimension'],
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 统计表格数据
      statisticsList: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 30,
        dismension: null,
        month: null,
        year: null,
        orderByColumn: 'createTime',
        isAsc: 'descending',
      },
      monthDisabled: false,
      yearDisabled: false
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询统计发放列表 */
    getList() {
      this.loading = true;
      listPageTaskStatistics(this.queryParams).then(response => {
        this.statisticsList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
   
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.monthDisabled = false;
      this.yearDisabled = false;
      this.handleQuery();
      
    },
  }
};
</script>
