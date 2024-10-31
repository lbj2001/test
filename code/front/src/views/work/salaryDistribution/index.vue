<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="100px">
      
      <el-form-item label="所属年月" prop="month">
        <el-date-picker
          v-model="queryParams.month"
          type="month"
          placeholder="选择年月"
          format="yyyy 年 MM 月"
          value-format="yyyy-MM">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="领薪人员" prop="staffName">
        <el-input
          v-model="queryParams.staffName"
          placeholder="请输入领薪人员名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="开发人员" prop="developName">
        <el-input
          v-model="queryParams.developName"
          placeholder="请输入开发人员名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="发放状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择发放状态" clearable>
          <el-option
            v-for="dict in dict.type.wh_salary_status"
            :key="dict.value"
            :label="dict.label"
            :value="parseInt(dict.value)"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="参与团队" prop="pathId">
        <treeselect class="treeselect-main" v-model="queryParams.pathId" :options="staffTreeOptions" :normalizer="normalizer" placeholder="选择参与团队"/>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          :disabled="multiple"
          @click="handleDistribute"
          v-hasPermi="['work:salaryDistribution:distribute']"
        >发放</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['work:salaryDistribution:export']"
        >导出</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-tooltip placement="bottom">
          <div slot="content">
            以下只列出领薪人员的明细
          </div>
          <svg-icon icon-class="question"/>
        </el-tooltip>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table 
      v-loading="loading" 
      :data="salaryDistributionList" 
      @selection-change="handleSelectionChange"
      >
      <el-table-column type="selection" width="55" align="center" :selectable="selectEnable"/>
      <el-table-column type="expand" >
        <template slot-scope="props">
            <el-table :data="props.row.taskDistributionList" size="mini" border style="width: 92%; margin-left: 2%;">
              <el-table-column label="工时申报与领薪分配时间" align="center" prop="distributeTime">
                <template slot-scope="scope">
                  <span>{{ parseTime(scope.row.distributeTime) }}</span>
                </template>
              </el-table-column>
              <el-table-column label="应用名称" align="center" prop="appName" />
              <el-table-column label="开发人员" align="center" prop="developName" />
              <el-table-column label="任务详情" align="center">
                <template slot-scope="scope">
                  <el-button
                    size="mini"
                    type="text"
                    icon="el-icon-view"
                    @click="handleTaskDetail(scope.row)"
                  >详情</el-button>
                </template>
              </el-table-column>
              <el-table-column label="工时单价（元/小时）" align="center" prop="workingPrice">
                <template slot-scope="scope">
                  {{ scope.row.workingPrice.toFixed(1) }}
                </template>
              </el-table-column>
              <el-table-column label="分配工时" align="center" prop="workingHours">
                <template slot-scope="scope">
                  {{ scope.row.workingHours.toFixed(1) }}
                </template>
              </el-table-column>
              <el-table-column label="分配比例（%）" align="center" prop="distributeRatio"/>
            </el-table>
        </template>
      </el-table-column>
      <el-table-column label="领薪人员" align="center" prop="staffName" />
      <el-table-column label="参与团队（团队/小组/开发）" align="center" prop="pathName" />
      <el-table-column label="员工编号" align="center" prop="staffNo" />
      <el-table-column label="账户" align="center" prop="account" :show-overflow-tooltip="true"  />
      <el-table-column label="开户银行" align="center" prop="bank" :show-overflow-tooltip="true" />
      <el-table-column label="本月工时" align="center" prop="workingHours" >
        <template slot-scope="scope">
          {{ scope.row.workingHours.toFixed(1) }}
        </template>
      </el-table-column>
      <el-table-column label="本月薪酬（元）" align="center" prop="salary" />
      <el-table-column label="所属年月" align="center" prop="month" />
      <el-table-column label="发放时间" align="center" prop="distributeTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.distributeTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="发放状态" align="center" prop="status">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_salary_status" :value="scope.row.status"/>
        </template>
      </el-table-column>
    </el-table>

    <el-row :gutter="20" style="margin-top:20px">
      <el-col :span="4">
        <div>
          <el-statistic :value="planAmount" group-separator=",">
            <template slot="prefix"> 计划发放总金额（元）&ensp;&ensp;</template>
          </el-statistic>
        </div>
      </el-col>
      <el-col :span="4">
        <div>
          <el-statistic :value="actualAmount" group-separator=",">
            <template slot="prefix"> 实际发放总金额（元）&ensp;&ensp;</template>
          </el-statistic>
        </div>
      </el-col>
    </el-row>
    
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

     <!-- 任务详情对话框 -->
     <el-dialog v-dialogDrag title="任务详情" :visible.sync="openDetail" width="550px" append-to-body>
      <el-form ref="detailForm" :model="detailForm"  label-width="110px">
        <el-form-item label="任务说明" prop="taskName">
          {{ detailForm.taskName }}
        </el-form-item>
        <el-form-item label="任务链接地址" prop="linkUrl">
          <el-link type="primary" :href="(`${detailForm.linkUrl}`.indexOf('http://') !== -1 || `${detailForm.linkUrl}`.indexOf('https://') !== -1) ? detailForm.linkUrl : 'http://'+detailForm.linkUrl" target="_blank">{{ detailForm.linkUrl }}</el-link>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="openDetail=false">取 消</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
import { pageListSalaryDistribution, updateSalaryStatus } from "@/api/work/salaryDistribution";
import { listStaff } from "@/api/work/staff";
import Treeselect from "@riophae/vue-treeselect";
import "@riophae/vue-treeselect/dist/vue-treeselect.css";

export default {
  name: "SalaryDistribution",
  dicts: ['wh_salary_status','wh_distribution_nature','wh_participation_methods',],
  components: { Treeselect },
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
      // 薪酬发放表格数据
      salaryDistributionList: [],
      // 查询参数 this.parseTime(new Date().setMonth(new Date().getMonth() - 1), '{y}-{m}'),
      queryParams: {
        pageNum: 1,
        pageSize: 30,
        month: this.parseTime(new Date(), '{y}-{m}'),
        staffName: null,
        developName: null,
        status: null,
        orderByColumn: 'createTime',
        isAsc: 'descending',
      },
      planAmount: 0,
      actualAmount: 0,
      openDetail: false,
      detailForm:{},
      //员工树
      staffTreeOptions:[],
    };
  },
  created() {
    this.getList();
    this.initStaffTree();
  },
  methods: {
    /** 查询薪酬发放列表 */
    getList() {
      this.loading = true;
      pageListSalaryDistribution(this.queryParams).then(response => {
        this.salaryDistributionList = response.rows;
        this.total = response.total;
        //计算金额
        this.planAmount = this.salaryDistributionList.reduce((sum,key)=>{
          return sum + key.salary;
        },0)
        this.actualAmount = this.salaryDistributionList.reduce((sum,key)=>{
          if(key.status == 1){
            return sum + key.salary;
          }else{
            return sum;
          }
        },0)
        this.loading = false;
      });
    },

    /** 初始化员工树 */
    initStaffTree(){
      debugger
      let staffParams={
        maxMethod: 4,
        status: 0,
        delFlag: 0,
      }
      //查询上级
      listStaff(staffParams).then(response => {
        this.staffTreeOptions = this.handleTree(response.data);
        console.log(this.staffTreeOption)
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
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.multiple = !selection.length
    },
    /** 禁用多选框函数 */
    selectEnable(row, index){
      if (row.status == 0) {
        return true; //可勾选
      } else {
        return false; //不可勾选
      }
    },
    /** 修改按钮操作 */
    handleDistribute() {
      const ids = this.ids
      this.$modal.confirm('是否确认发放？').then(function() {
        return updateSalaryStatus(ids);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("发放成功");
      }).catch(() => {});

    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('work/salaryDistribution/export', {
        ...this.queryParams
      }, `salaryDistribution_${new Date().getTime()}.xlsx`)
    },

     /** 详情按钮操作 */
     handleTaskDetail(row) {
      this.detailForm = row;
      this.openDetail = true;
    },

    /** 转换员工数据结构 */
    normalizer(node) {
      debugger
      if (node.children && !node.children.length) {
        delete node.children;
      }

      //数据字典
      let methodLabel = this.selectDictLabel(this.dict.type.wh_participation_methods, node.participationMethods);
      
      return {
        id: node.id,
        label: node.staffName +'（'+ methodLabel +'）',
        children: node.children
      };
    },
  }
};
</script>


<style lang='scss'>
  .treeselect-main{
    width: 210px;
    line-height: 32px;

    .vue-treeselectt__placeholder{
      line-height: 32px;
    }
    .vue-treeselect__control{
      height: 32px !important;
    }
    
  }
</style>
