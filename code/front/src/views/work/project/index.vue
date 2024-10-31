<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="100px">
      <el-form-item label="主资产编号" prop="projectNo">
        <el-input
          v-model="queryParams.projectNo"
          placeholder="请输入主资产编号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="主项目名称" prop="mainProjectName">
        <el-input
          v-model="queryParams.mainProjectName"
          placeholder="请输入主项目名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="子项目名称" prop="projectName">
        <el-input
          v-model="queryParams.projectName"
          placeholder="请输入子项目名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="项目类型" prop="projectType">
        <el-select v-model="queryParams.projectType" placeholder="请选择项目类型" clearable>
          <el-option
            v-for="dict in dict.type.wh_pro_type"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="项目负责人" prop="projectLeader">
        <el-select v-model="queryParams.projectLeader" placeholder="请选择项目负责人" filterable clearable>
          <el-option
            v-for="item in userOptions"
            :key="item.id"
            :label="`${item.userName}（${item.nickName}）`"
            :value="item.userName"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="项目来源" prop="projectSource">
        <el-select v-model="queryParams.projectSource" placeholder="请选择项目来源" clearable>
          <el-option
            v-for="dict in dict.type.wh_pro_sou"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="周期类型" prop="cycleType">
        <el-select v-model="queryParams.cycleType" placeholder="请选择周期类型" clearable>
          <el-option
            v-for="dict in dict.type.wh_cycle_type"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="是否启用" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择是否启用" clearable>
          <el-option
            v-for="dict in dict.type.wh_pro_status"
            :key="dict.value"
            :label="dict.label"
            :value="parseInt(dict.value)"
          />
        </el-select>
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
          @click="handleAdd"
          v-hasPermi="['work:project:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['work:project:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['work:project:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="projectList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主资产编号" align="center" prop="projectNo" />
      <el-table-column label="主项目名称" align="center" prop="mainProjectName" />
      <el-table-column label="子项目编号" align="center" prop="summaryNo" />
      <el-table-column label="子项目名称" align="center" prop="projectName" />
      <el-table-column label="代码与源编号" align="center" prop="codeSourceNo" />
      <el-table-column label="项目类型" align="center" prop="projectType">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_pro_type" :value="scope.row.projectType"/>
        </template>
      </el-table-column>
      <el-table-column label="项目负责人" align="center" prop="projectLeaders">
        <template slot-scope='scope'>
          <span class='item' v-if="!!scope.row.projectLeaders && scope.row.projectLeaders.length>0" v-for='item in scope.row.projectLeaders'>{{item}}&nbsp;&nbsp;</span>
        </template>
      </el-table-column>
      <el-table-column label="项目来源" align="center" prop="projectSource">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_pro_sou" :value="scope.row.projectSource"/>
        </template>
      </el-table-column>
      <el-table-column label="周期类型" align="center" prop="cycleType">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_cycle_type" :value="scope.row.cycleType"/>
        </template>
      </el-table-column>
      <el-table-column label="分支类型" align="center" prop="branchTypes">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_branch_type" :value="scope.row.branchTypes"/>
        </template>
      </el-table-column>
      <el-table-column label="限定任务工时量" align="center" prop="workHoursThreshold">
        <template slot-scope="scope">
          <span>{{ !scope.row.workHoursThreshold ? '' : scope.row.workHoursThreshold.toFixed(1) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="是否启用" align="center" prop="status">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_pro_status" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="创建人" align="center" prop="createByName" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改项目对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="550px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="125px">
        <el-form-item label="主项目名称" prop="mainProjectName">
          <el-input v-model="form.mainProjectName" placeholder="请输入主项目名称" />
        </el-form-item>
        <el-form-item label="子项目编号" prop="summaryNo">
          <el-input v-model="form.summaryNo" placeholder="请输入子项目编号" />
        </el-form-item>
        <el-form-item label="子项目名称" prop="projectName">
          <el-input v-model="form.projectName" placeholder="请输入子项目名称" />
        </el-form-item>
        <el-form-item label="代码与源编号" prop="codeSourceNo">
          <el-select v-if="form.projectSource==1" v-model="form.codeSourceNo" placeholder="请选择代码与源编号" clearable>
            <el-option
            v-for="item in sourceNoOptions"
            :key="item.codeSourceNo"
            :label="item.codeSourceNo"
            :value="item.codeSourceNo"
            ></el-option>
          </el-select>
          <el-input v-else="form.projectSource==2" v-model="form.codeSourceNo" placeholder="请输入代码与源编号"/>
          
        </el-form-item>
        <el-form-item prop="projectType">
          <span slot="label">
            项目类型
            <el-tooltip placement="top">
              <div slot="content">
                不同项目类型决定工时申报时字段不同
              </div>
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-select v-model="form.projectType" placeholder="请选择项目类型" clearable>
            <el-option
              v-for="dict in dict.type.wh_pro_type"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="项目负责人" prop="projectLeaders">
          <el-select v-model="form.projectLeaders" placeholder="请选择项目负责人" multiple filterable clearable>
            <el-option
              v-for="item in userOptions"
              :key="item.id"
              :label="`${item.userName}（${item.nickName}）`"
              :value="item.userName"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="项目来源" prop="projectSource">
          <el-select v-model="form.projectSource" placeholder="请选择项目来源" clearable disabled>
            <el-option
              v-for="dict in dict.type.wh_pro_sou"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="周期类型" prop="cycleType">
          <el-select v-model="form.cycleType" placeholder="请选择周期类型" clearable>
            <el-option
              v-for="dict in dict.type.wh_cycle_type"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="分支类型" prop="branchTypes" v-if="form.projectType === 1" :rules="form.projectType === 1 ? rules.branchTypes : [{ required: false }]">
          <el-select v-model="form.branchTypes" placeholder="请选择分支类型" multiple clearable>
            <el-option
              v-for="dict in dict.type.wh_branch_type"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="限定任务工时量" prop="workHoursThreshold">
          <el-input-number v-model="form.workHoursThreshold" placeholder="限定任务工时量" :min="0" :precision="1" :step="1" controls-position="right"/>
        </el-form-item>
        <el-form-item label="是否启用" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio :label="0">否</el-radio>
            <el-radio :label="1">是</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listPageProject, getProject, delProject, addProject, updateProject } from "@/api/work/project";
import { listSourceNos } from "@/api/work/projectOrigin";
import { listUser } from "@/api/system/user";

export default {
  name: "Project",
  dicts: ['wh_pro_sou', 'wh_cycle_type', 'wh_pro_status', 'wh_pro_type', 'wh_branch_type'],
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 项目表格数据
      projectList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 30,
        mainProjectName: null,
        projectName: null,
        projectType: null,
        projectSource: null,
        cycleType: null,
        status: 1,
        orderByColumn: 'createTime',
        isAsc: 'descending',
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        mainProjectName: [
          { required: true, message: "主项目名称不能为空", trigger: "blur" }
        ],
        projectName: [
          { required: true, message: "项目名称不能为空", trigger: "blur" }
        ],
        projectLeaders: [
          { required: true, message: "项目负责人不能为空", trigger: "change" }
        ],
        projectSource: [
          { required: true, message: "项目来源不能为空", trigger: "change" }
        ],
        cycleType: [
          { required: true, message: "周期类型不能为空", trigger: "change" }
        ],
        branchTypes: [
          { required: true, message: "分支类型不能为空", trigger: "change" }
        ],
        workHoursThreshold: [
          { required: true, message: "限定任务工时数量不能为空", trigger: "blur" }
        ],
        status: [
          { required: true, message: "启用状态不能为空", trigger: "change" }
        ],
      },
      initThreshold: null,
      sourceNoOptions: [],
      userOptions: [],
    };
  },
  created() {
    this.getList();
    // 获取限定任务工时
    this.getConfigKey("sys.workhours.threshold").then(response => {
      this.initThreshold = response.msg;
    });
    // 初始化用户信息
    this.getUserList();
  },
  methods: {
    /** 查询用户信息列表 */
    getUserList(){
      let userParams = {
        status: 0,
        orderByColumn: 'createTime',
        isAsc: 'descending'
      }
      listUser(userParams).then(response => {
        this.userOptions = response.data
      });
    },
    /** 查询项目列表 */
    getList() {
      this.loading = true;
      listPageProject(this.queryParams).then(response => {
        this.projectList = response.rows;

        this.projectList.forEach(item=>{
          if(!!item.branchType){
            item.branchTypes = item.branchType.split(',')
          }
        });
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        projectName: null,
        projectType: null,
        projectSource: null,
        cycleType: null,
        workHoursThreshold: null,
        status: null,
      };
      this.resetForm("form");
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
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加项目";
      this.form.projectSource = 2;
      this.form.workHoursThreshold = this.initThreshold;
      this.form.status = 0;
    },
    /** 修改按钮操作 */
    handleUpdate() {
      this.reset();
      const id = this.ids
      getProject(id).then(response => {
        this.form = response.data;

        //获取项目代码与源
        if(this.form.projectSource == 1){
          this.initSourceNoData(this.form.projectNo, this.form.summaryNo);
        }

        if(!!this.form.branchType){
          this.form.branchTypes = this.form.branchType.split(',')
        }
        if(!!this.form.projectLeader){
          this.form.projectLeaders = this.form.projectLeader.split(',')
        }
        this.open = true;
        this.title = "修改项目";
      });
    },

    /** 初始化*/ 
    initSourceNoData(projectNo, summaryNo){
      listSourceNos(projectNo, summaryNo).then(response => {
        this.sourceNoOptions = response.data;
      })
    },

    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateProject(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addProject(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete() {
      const ids = this.ids;
      this.$modal.confirm('是否确认删除项目编号为"' + ids + '"的数据项？').then(function() {
        return delProject(ids);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    }
   
  }
};
</script>
