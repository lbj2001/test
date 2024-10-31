<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="130px">
      <el-form-item label="所属年月" prop="distributeMonth" >
        <el-date-picker
          v-model="queryParams.distributeMonth"
          type="month"
          placeholder="选择年月"
          format="yyyy 年 MM 月"
          value-format="yyyy-MM">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="项目名称" prop="projectId">
        <el-select v-model="queryParams.projectId" placeholder="请选择项目名称" clearable filterable>
          <el-option
            v-for="item in projectOptions"
            :key="item.id"
            :label="item.projectName"
            :value="item.id"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="任务名称" prop="appName">
        <el-select v-model="queryParams.appName" placeholder="请选择任务名称" clearable filterable>
            <el-option
              v-for="item in appNameOptions"
              :key="item.appName"
              :label="item.appName"
              :value="item.appName"
            ></el-option>
          </el-select>
      </el-form-item>
      <el-form-item label="分配人" prop="createByName">
        <el-select v-model="queryParams.createByName" placeholder="请选择分配人" clearable filterable>
          <el-option
            v-for="item in distributeNameOptions"
            :key="item.createByName"
            :label="item.createByName"
            :value="item.createByName"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="被分配人" prop="staffName">
        <el-select v-model="queryParams.staffName" placeholder="请选择被分配人" clearable filterable>
          <el-option
            v-for="item in staffNameOptions"
            :key="item.staffName"
            :label="item.staffName"
            :value="item.staffName"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="被分配人参与方式" prop="participationMethods">
        <el-select v-model="queryParams.participationMethods" placeholder="被分配人参与方式" clearable>
          <el-option
            v-for="dict in participationMethodsOptions"
            :key="dict.dictValue"
            :label="dict.dictLabel"
            :value="dict.dictValue"
          />
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
      <el-form-item label="任务下发状态" prop="distributeStatus">
        <el-select v-model="queryParams.distributeStatus" placeholder="请选择任务下发状态" clearable>
          <el-option
            v-for="dict in dict.type.wh_distribute_status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="任务完成提交状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择任务完成提交状态" clearable>
          <el-option
            v-for="dict in dict.type.wh_is_completed"
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
          v-if="showAdd"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="singleUpdate"
          @click="handleUpdate"
          v-hasPermi="['work:task:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-view"
          size="mini"
          :disabled="single"
          @click="handleDetail"
          v-hasPermi="['work:task:query']"
        >任务说明</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleDistribute"
          :disabled = "singleDistribute"
          v-hasPermi="['work:task:distribute']"
        >再次分配</el-button>
      </el-col>

      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          @click="handleDelete"
          :disabled = "singleDelete"
          v-hasPermi="['work:task:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-finished"
          size="mini"
          @click="handleDivide"
          :disabled = "singleDivide"
          v-hasPermi="['work:task:distribute']"
        >下发</el-button>
      </el-col>
     
      <el-col :span="1.5">
        <el-button
          type="info"
          plain
          icon="el-icon-sort"
          size="mini"
          @click="toggleExpandAll"
        >展开/折叠</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table 
      v-if="refreshTable"
      v-loading="loading" 
      :data="taskList" 
      @selection-change="handleSelectionChange"
      :default-expand-all="isExpandAll"
      row-key="id"
      :tree-props="{children: 'children', hasChildren: 'hasChildren'}">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="任务编号" align="center" prop="taskNo" width="250"/>
      
      <el-table-column label="项目名称" align="center" prop="projectName" />
      <el-table-column label="项目类型" align="center" prop="projectType">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_pro_type" :value="scope.row.projectType"/>
        </template>
      </el-table-column>
      <el-table-column label="任务名称" align="center" prop="appName" />
      <el-table-column label="分配人" align="center" prop="createByName" />
      <el-table-column label="任务完成提交状态" align="center" prop="status" >
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_is_completed" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="被分配人" align="center" prop="staffName" />
      <el-table-column label="被分配人参与方式" align="center" prop="participationMethods">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_participation_methods" :value="scope.row.participationMethods"/>
        </template>
      </el-table-column>
      <el-table-column label="项目来源" align="center" prop="projectSource">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_pro_sou" :value="scope.row.projectSource"/>
        </template>
      </el-table-column>
      <el-table-column label="任务下发状态" align="center" prop="distributeStatus">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_distribute_status" :value="scope.row.distributeStatus"/>
        </template>
      </el-table-column>
      <el-table-column label="分配阶段" align="center" prop="stage">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_distribution_stage" :value="scope.row.stage"/>
        </template>
      </el-table-column>
      <el-table-column label="任务分配时间" align="center" prop="distributionTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.distributionTime) }}</span>
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

    <!-- 添加或修改任务对话框 -->
    <el-dialog v-dialogDrag :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="被分配人" prop="staffId">
          <treeselect v-if="isEdit" v-model="form.staffId" :options="staffTreeOptions" :normalizer="normalizer" :show-count="true" placeholder="选择被分配人" :disabled="disabled"/>
          <div v-else>
            {{ form.staffName }}
          </div>
        </el-form-item>
        <el-form-item label="项目名称" prop="projectId">
          <el-select v-model="form.projectId" placeholder="请选择项目名称" clearable filterable :disabled="disabled||projectDisabled">
            <el-option
              v-for="item in projectOptions"
              :key="item.id"
              :label="`${item.projectName}/${item.projectNo}`+ (!item.codeSourceNo ? '' : '/' + item.codeSourceNo)"
              :value="item.id"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="项目类型" prop="projectType" >
          <span slot="label">
            项目类型
            <el-tooltip placement="top">
              <div slot="content">
                项目类型默认项目创建中的配置，修改后会影响提交工时的提交信息，只有distribute角色码的登录用户才能修改
              </div>
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-select v-model="form.projectType" placeholder="请选择项目类型" :disabled="projectTypeDisabled">
            <el-option
              v-for="dict in dict.type.wh_pro_type"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="任务名称" prop="appName">
          <el-input v-model="form.appName" placeholder="请输入任务名称" :disabled="disabled"/>
        </el-form-item>
        <el-form-item v-show="form.projectType === 1" label="针对分支" prop="branchName" key="branchName" :rules="form.projectType === 1 ? rules.branchName : [{ required: false }]" >
          <el-select v-model="form.branchName" placeholder="请选择针对分支" :disabled="branchNameDisabled">
            <el-option
              v-for="dict in branchTypeOptions"
              :key="dict.dictValue"
              :label="dict.dictLabel"
              :value="dict.dictValue"
            />
          </el-select>
        </el-form-item>
        <el-form-item v-show="form.projectType === 1" label="内部分支" prop="innerBranch">
          <el-input v-model="form.innerBranch" placeholder="请输入内部分支" :disabled="disabled"/>
        </el-form-item>
        <el-form-item v-show="form.projectType === 1" label="发布类型" prop="releaseFlag" key="releaseFlag" :rules="form.projectType === 1 ? rules.releaseFlag : [{ required: false }]" >
          <el-select v-model="form.releaseFlag" placeholder="请选择发布类型" :disabled="releaseFlagDisabled">
            <el-option label="增量发布" :value="0" />
            <el-option label="全量发布" :value="1" />
          </el-select>
        </el-form-item>
       
        <el-form-item v-show="form.projectType === 1 && form.releaseFlag == 1" label="关联tag" prop="releaseTag" key="releaseTag" :rules="form.projectType === 1 && form.releaseFlag == 1 ? rules.releaseTag : [{ required: false }]">
          <el-select v-model="form.releaseTag" placeholder="请选择关联tag" clearable filterable :disabled="releaseTagDisabled">
            <el-option
              v-for="item in tagOptions"
              :key="item.tagNo"
              :label="item.tagNo"
              :value="item.tagNo"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="任务分配时间" prop="distributionTime" >
          {{parseTime(form.distributionTime)}}
        </el-form-item>
        <el-form-item label="任务说明" prop="description">
          <el-input type="textarea" v-model="form.description" placeholder="请输入任务说明" :rows="3" maxlength="300" show-word-limit :disabled="disabled"/>
        </el-form-item>
        <el-form-item label="任务链接地址" prop="linkUrl">
          <el-input v-model="form.linkUrl" placeholder="请输入任务链接地址" :disabled="disabled"/>
        </el-form-item>
        <el-form-item label="链接二维码" prop="qrCode">
          <imagePreview v-if="disabled" :src="form.qrCode" :width="120" :height="120" />
          <imageUpload v-else v-model="form.qrCode" :limit="1" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm('submit')" v-if="confirmShow">立即下发</el-button>
        <el-button type="primary" @click="submitForm('tempSubmit')">暂存待发</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 确认分配对话框 -->
    <el-dialog v-dialogDrag title="确认分配" :visible.sync="openConfirm" width="600px" append-to-body>
      <el-form ref="confirmForm" :model="confirmForm" :rules="confirmRules" label-width="110px" >
        <el-form-item label="操作选择" prop="isCompleted">
          <el-radio v-model="confirmForm.isCompleted" label="1">已完成本任务全部拆解分配（选择后本任务及子任务均不可改）</el-radio><br/>
          <el-radio v-model="confirmForm.isCompleted" label="0">需要继续分配</el-radio>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitDistribute">确 定</el-button>
        <el-button @click="cancelConfirm">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 任务说明对话框 -->
    <el-dialog v-dialogDrag :title="titleDetail" :visible.sync="openDetail" width="550px" append-to-body>
      <el-form ref="detailForm" :model="detailForm"  label-width="110px">
        <el-form-item label="被分配人" prop="staffId">
            {{ detailForm.staffName }}
        </el-form-item>
        <el-form-item label="项目名称" prop="projectName">
          {{ detailForm.projectName }}
        </el-form-item>
        <el-form-item label="任务名称" prop="appName">
          {{ detailForm.appName }}
        </el-form-item>
        <el-form-item v-show="detailForm.projectType === 1" label="针对分支" prop="branchName" key="branchName">
          <el-select v-model="detailForm.branchName" placeholder="请选择针对分支" :disabled="true">
            <el-option
              v-for="dict in dict.type.wh_branch_type"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            />
          </el-select>
        </el-form-item>
        <el-form-item v-show="detailForm.projectType === 1" label="内部分支" prop="innerBranch">
          {{ detailForm.innerBranch }}
        </el-form-item>
        <el-form-item v-show="detailForm.projectType === 1" label="发布类型" prop="releaseFlag" key="releaseFlag" >
          <el-select v-model="detailForm.releaseFlag" placeholder="请选择发布类型" :disabled="true">
            <el-option label="增量发布" :value="0" />
            <el-option label="全量发布" :value="1" />
          </el-select>
        </el-form-item>
       
        <el-form-item v-show="detailForm.projectType === 1 && detailForm.releaseFlag == 1" label="关联tag" prop="releaseTag" key="releaseTag">
          <el-select v-model="detailForm.releaseTag" placeholder="请选择关联tag" clearable filterable :disabled="true">
            <el-option
              v-for="item in tagOptions"
              :key="item.tagNo"
              :label="item.tagNo"
              :value="item.tagNo"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="任务分配时间" prop="distributionTime" >
          {{parseTime(detailForm.distributionTime)}}
        </el-form-item>
        <el-form-item label="任务说明" prop="description">
          {{ detailForm.description }}
        </el-form-item>
        <el-form-item label="任务链接地址" prop="linkUrl">
          <el-link type="primary" :href="(`${detailForm.linkUrl}`.indexOf('http://') !== -1 || `${detailForm.linkUrl}`.indexOf('https://') !== -1) ? detailForm.linkUrl : 'http://'+detailForm.linkUrl" target="_blank">{{ detailForm.linkUrl }}</el-link>
        </el-form-item>
        <el-form-item label="链接二维码" prop="qrCode">
          <imagePreview :src="detailForm.qrCode" :width="120" :height="120" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="cancelDetail">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listPageTask, singleListTask, getTask, delTask, addTask, updateTask, listTags, listAppNames,
   listStaffNames, listDistributeNames, getLastTask, judgeExistTask, getLatestTask, getBranchTask, updateDistributeStatus } from "@/api/work/task";
import { listStaff, listStaffChildren } from "@/api/work/staff";
import { listProject, listStaffProject, getProject } from "@/api/work/project";
import Treeselect from "@riophae/vue-treeselect";
import "@riophae/vue-treeselect/dist/vue-treeselect.css";
import store from "@/store";
import {checkRole} from "@/utils/permission";

export default {
  name: "Task",
  dicts: ['wh_pro_sou','wh_pro_type','wh_participation_methods','wh_distribution_stage',
  'wh_is_completed', 'wh_branch_type', 'wh_full_release', 'wh_distribute_status'],
  components: { Treeselect },
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非单个修改禁用
      singleUpdate: true,
      // 非单个分配禁用
      singleDistribute: true,
      // 非单个删除禁用
      singleDelete: true,
      // 非单个下发禁用
      singleDivide: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 添加按钮显隐
      showAdd: false,
      // 总条数
      total: 0,
      // 任务表格数据
      taskList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 是否展开，默认全部展开
      isExpandAll: false,
      // 重新渲染表格状态
      refreshTable: true,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 30,
        distributeMonth: this.parseTime(new Date(), '{y}-{m}'),
        projectId: null,
        appName: null,
        projectSource: null,
        staffName: null,
        status: 0,
        orderByColumn: 'createTime',
        isAsc: 'descending',
      },
      // 表单参数
      form: {
        distributionTime: null,
        participationMethods: null,
        isCompleted: null,
        releaseFlag : null,
      },
      // 表单校验
      rules: {
        projectId: [
          { required: true, message: "项目名称不能为空", trigger: "change" }
        ],
        projectType: [
          { required: true, message: "项目类型不能为空", trigger: "blur" }
        ],
        appName: [
          { required: true, message: "任务名称不能为空", trigger: "blur" }
        ],
        branchName: [
          { required: true, message: "针对分支不能为空", trigger: "change" }
        ],
        releaseFlag: [
          { required: true, message: "是否确认发布版不能为空", trigger: "blur" }
        ],
        releaseTag: [
          { required: true, message: "是否关联tag不能为空", trigger: "change" }
        ],
        staffId: [
          { required: true, message: "被分配人不能为空", trigger: "change" }
        ],
        description: [
          { required: true, message: "任务说明不能为空", trigger: "blur" }
        ],
      },
      // 弹出层标题
      titleDetail: "",
      // 是否显示弹出层
      openDetail: false,
      // 详情表单参数
      detailForm: {},
      // 选中单行
      singleSelectRow:{},
      // 是否显示弹出层
      openConfirm: false,
      // 确认表单参数
      confirmForm: {},
      confirmRules: {
        isCompleted: [
          { required: true, message: "操作选择不能为空", trigger: "change" }
        ],
      },
      //员工树
      staffTreeOptions:[],
      staffOptions:[],
      staffNo:null,
      appNameOptions:[],
      staffNameOptions:[],
      distributeNameOptions:[],
      disabled: false,
      isEdit: true,
      showCompleted: false,
      confirmShow: true,
      projectOptions: [],
      description: null,
      tagOptions: [],
      branchNameDisabled: false,
      releaseFlagDisabled: false,
      releaseTagDisabled: false,
      projectReleaseFlag: null,
      branchReleaseTag: null,
      projectDisabled: false,
      participationMethodsOptions:[],
      distributeFlag: false,
      projectTypeOptions: [],
      projectTypeDisabled: true,
      branchTypes: [],
      branchTypeOptions: [],
      existProjectType: null,
    };
  },
  created() {
    this.staffNo = store.getters.name;
    this.initParticipationMethods();
    this.getList();
    this.initTreeStaffOptions();
    this.getAppList();
    this.getStaffNames();
    this.getDistributeNames();
    this.getProjectList();
    
    this.initBranchTypes();
  },

  //监听任务名称属性
  watch:{
    
    //监听被分配人
    'form.staffId'(val){
      if(!this.form.id){
        this.watchStaffId(val);
      }
    },

    //监听项目
    'form.projectId'(val){
      if(!this.form.id){
        this.watchProjectId(val);
      }
    },

    //监听分支
    'form.branchName'(val){
      if(!this.form.id){
        this.watchBranchName(val);
      }
    },

     //监听项目
     'form.releaseFlag'(val){
      if(!this.form.id){
        this.watchReleaseFlag(val);
      }
    },

    'form.appName'(val){
      if(!!val && !this.description){
        this.$set(this.form, 'description', val);
      }
    }
  },

  methods: {
    /** 初始化参与方式 */
    initParticipationMethods(){
      this.getDicts("wh_participation_methods").then(response => {
        let methods = response.data;
        // 领薪人员不显示
        this.participationMethodsOptions = methods.filter(method =>method.dictValue != 4);
      })
    },

     /** 初始化项目类型 */
     initProjectTypes(proType){
      this.getDicts("wh_pro_type").then(response => {
        let proTypes = response.data;
        if(!proType){
          this.projectTypeOptions = proTypes;
        }else{
          this.projectTypeOptions = proTypes.filter(projectType =>projectType.dictValue == proType);
        }
      })
    },

      /** 初始化分支类型 */
    initBranchTypes(){
      this.getDicts("wh_branch_type").then(response => {
        this.branchTypes = response.data;
      })
    },

    initProjectTypeDisabled(){ 
      // 项目类型分配角色
      if(!checkRole(['distribute'])){
        this.projectTypeDisabled = true;
      }else{
        this.projectTypeDisabled = false;
      }
    },

    /** 查询任务列表 */
    getList() {
      this.loading = true;
      //判断当前登录人
      let staffList = []
      //查询当前登录人参与方式
      let param = {
        staffNo : this.staffNo,
        delFlag : 0
      }
      listStaff(param).then(response => {
        staffList = response.data;
        if(!staffList || staffList.length == 0){ //管理员
          this.showAdd = true;
          //查询全部
          listPageTask(this.queryParams).then(response => {
            this.taskList = this.handleTree(response.rows);
            this.total = response.total;
            this.loading = false;
          });
        }else{ 
          if(checkRole(['team'])){
            this.showAdd = true;
          }
          //团队或小组负责人
          let staffIds = staffList.map(item => item.id);
          this.queryParams.staffIds = staffIds;
          this.queryParams.staffNo = store.getters.name;
          singleListTask(this.queryParams).then(response =>{
            this.taskList = this.handleTree(response.rows);
            this.total = response.total;
            this.loading = false;
          })
        }
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
        taskNo: null,
        appName: null,
        distributionTime: null,
        projectId: null,
        projectType: null,
        staffId: null,
        description: null,
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
      this.singleSelectRow = selection[0];
      this.singleUpdate = this.single || this.singleSelectRow.stage == 4 || this.singleSelectRow.status == 1 || this.singleSelectRow.createBy != store.getters.name;
      this.singleDistribute = this.single || this.singleSelectRow.participationMethods == 3 || this.singleSelectRow.stage == 4
      this.singleDelete = this.single || (this.singleSelectRow.stage == 1 && this.singleSelectRow.distributeStatus==1)  || (this.singleSelectRow.stage == 4 && this.singleSelectRow.distributeStatus==1) || this.singleSelectRow.createBy != store.getters.name;
      this.singleDivide = this.single || this.singleSelectRow.distributeStatus == 1|| this.singleSelectRow.createBy != store.getters.name;
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.getAppList();
      this.initTreeStaffOptions();
      this.initProjectTypeDisabled();
      this.isEdit = true;
      this.distributeFlag = false;
      this.open = true;
      this.disabled = false;
      this.showCompleted = false;
      this.confirmShow = true;
      this.description = null;
      this.title = "添加任务";
      this.form = {
        parentId: 0,
        isCompleted : '0',
        distributionTime: new Date(),
        projectId: null,
        projectType: null,
        branchName: null,
        releaseFlag: null,
      };
      this.branchNameDisabled = false;
      this.releaseFlagDisabled = false;
      this.releaseTagDisabled = false;
      this.projectDisabled = false;

    },
    /** 再次分配按钮操作 */
    handleDistribute() {
      this.reset();
      this.distributeFlag = true;
      this.getProjectList();
      this.initProjectTypeDisabled();
      if(!!this.singleSelectRow.parentId){
        //查询父级是否分配完成
        getTask(this.singleSelectRow.parentId).then(response => {
          let parent = response.data;
          if(parent.stage != 4){
            this.$message.error('当前任务的父任务尚未分配完成，不能进行任务下发')
            return;
          }
          this.getAppList();
          this.isEdit = true;
          this.disabled = false;
          this.projectDisabled = true;
          this.showCompleted = true;
          this.confirmShow = true;
          this.form = {
            parentId: this.singleSelectRow.id,
            appName: this.singleSelectRow.appName,
            projectId: this.singleSelectRow.projectId,
            projectName: this.singleSelectRow.projectName,
            projectType: this.singleSelectRow.projectType,
            cycleType: this.singleSelectRow.cycleType,
            branchName: this.singleSelectRow.branchName,
            innerBranch: this.singleSelectRow.innerBranch,
            linkUrl: this.singleSelectRow.linkUrl,
            isCompleted : '0',
            distributionTime: new Date(),
          }
          
          //重新加载子级树
          this.reloadStaffTree(this.singleSelectRow.staffId);
          this.open = true;
          this.title = "下发任务";

        });
        
      }else{
        this.getAppList();
        this.isEdit = true;
        this.disabled = false;
        this.projectDisabled = true;
        this.showCompleted = true;
        this.confirmShow = true;
        this.form = {
          parentId: this.singleSelectRow.id,
          appName: this.singleSelectRow.appName,
          projectId: this.singleSelectRow.projectId,
          projectName: this.singleSelectRow.projectName,
          projectType: this.singleSelectRow.projectType,
          branchName: this.singleSelectRow.branchName,
          innerBranch: this.singleSelectRow.innerBranch,
          linkUrl: this.singleSelectRow.linkUrl,
          isCompleted : '0',
          distributionTime: new Date(),
        }

        // 项目类型为非开发任务不可改
        if(this.form.projectType !== 1){
          this.projectTypeDisabled = true;
        }
        
        //重新加载子级树
        this.reloadStaffTree(this.singleSelectRow.staffId);
        this.open = true;
        this.title = "下发任务";
      }
      
    },

    /** 重新加载子级树 */
    reloadStaffTree(id){
      let childParam= {
        id : id
      }
      listStaffChildren(childParam).then(response =>{
        //去除自己
        let children = response.data.filter(item=>item.id != id && item.participationMethods != 4);
        this.staffTreeOptions = this.handleTree(children);
      })
    },

     /** 展开/折叠操作 */
     toggleExpandAll() {
      this.refreshTable = false;
      this.isExpandAll = !this.isExpandAll;
      this.$nextTick(() => {
        this.refreshTable = true;
      });
    },
    /** 修改按钮操作 */
    handleUpdate() {
      this.reset();
      this.getAppList();
      this.isEdit = false;
      this.distributeFlag = false;
      const id = this.singleSelectRow.id;
      getTask(id).then(response => {
        this.form = response.data;
        this.existProjectType = this.form.projectType;
        this.description = response.data.description;
        //查询父任务状态
        let parent;
        if(this.form.parentId != 0){
          getTask(this.form.parentId).then(response =>{
            parent = response.data;
            //父任务已分配完成
            if(parent.stage == 4){
              this.disabled = true;
              if(this.form.stage == 1 ){
                this.confirmShow = false;
              }else{
                this.confirmShow = true;
              }
            }else{
              this.disabled = false;
            }
          })
        }else{
          // 非分配人
          if(this.form.createBy != this.staffNo){
            this.disabled = true;
            //等待分配不可以修改
            if(this.form.stage == 2){
              this.confirmShow = false;
            }else{
              this.confirmShow = true;
            }
          }else{
            this.disabled = false;
          }
        }
        this.open = true;
        this.title = "修改任务";
        this.watchProjectId(this.form.projectId);
      });
    },
    // 取消确认按钮
    cancelConfirm() {
      this.openConfirm = false;
      this.resetConfirm();
    },
    // 确认表单重置
    resetConfirm() {
      this.confirmForm = {       
        isCompleted: null,
      };
      this.resetForm("confirmForm");
    },
    /** 提交按钮 */
    submitDistribute() {
      this.$refs["confirmForm"].validate(valid => {
        if (valid) {
          this.form.isCompleted = this.confirmForm.isCompleted;
          if(this.form.id != null){
            updateTask(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.openConfirm = false;
              this.open = false;
              this.getList();
            });
          }else{
            addTask(this.form).then(response => {
              this.$modal.msgSuccess("下发成功");
              this.openConfirm = false;
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 详情按钮操作 */
    handleDetail() {
      this.reset();
      const id = this.singleSelectRow.id;
      getTask(id).then(response => {
        this.detailForm = response.data;
        this.openDetail = true;
        this.titleDetail = "任务说明详情";
      });
    },
     // 取消按钮
     cancelDetail() {
      this.openDetail = false;
      this.resetDetail();
    },
    // 表单重置
    resetDetail() {
      this.form = {       
        description: null,
        linkUrl:null
      };
      this.resetForm("detailForm");
    },
    /** 提交按钮 */
    submitForm(type) {
      debugger
      this.$refs["form"].validate(valid => {
        if (valid) {
          // 立即下发
          if(type == 'submit'){
            this.form.distributeStatus = 1;
          }else {
            this.form.distributeStatus = 0;
          }
          let staff = this.staffOptions.find(item=>item.id == this.form.staffId);
          this.form.participationMethods = staff.participationMethods;
          this.form.staffNo = staff.staffNo;
          //查询项目
          let project = this.projectOptions.find(item=>item.id == this.form.projectId);
          this.form.cycleType = project.cycleType;
          if(this.form.participationMethods == 3 && !this.form.description){
            this.$message.error('任务说明不能为空')
            return;
          }

          if (this.form.id != null) {//修改
            //判断任务阶段
            if(this.form.stage == 1 || this.form.stage == 2){//无需分配不弹窗
              updateTask(this.form).then(response => {
                this.$modal.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              });
            }else{
              this.openConfirm = true;
              this.resetConfirm();
            }
          } else {// 添加
           
            if(this.form.parentId == 0){
              addTask(this.form).then(response => {
                this.$modal.msgSuccess("新增成功");
                this.open = false;
                this.getList();
              });
            } else{// 下发
              this.openConfirm = true;
              this.resetConfirm();
            }
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete() {
      if(!!this.singleSelectRow.children){
        this.$message.error('任务含有子任务，不能删除');
        return;
      }
      const id = this.singleSelectRow.id;
      this.$modal.confirm('是否确认删除任务编号为"' + id + '"的数据项？').then(function() {
        return delTask(id);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('work/task/export', {
        ...this.queryParams 
      }, `task_${new Date().getTime()}.xlsx`)
    },

    /** 下发按钮操作 */
    handleDivide() {
      const id = this.singleSelectRow.id;
      let data = {
        id: this.singleSelectRow.id,
        staffId: this.singleSelectRow.staffId,
        projectId: this.singleSelectRow.projectId,
        participationMethods: this.singleSelectRow.participationMethods,
        distributeStatus: 1,
      }
      this.$modal.confirm('是否确认立即下发任务？').then(function() {
        return updateDistributeStatus(data);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("下发成功");
      }).catch(() => {});
    },

    /** 初始化员工树 */
    initTreeStaffOptions(){
      let staffList = []
      //查询当前登录人参与方式
      let staffNo = store.getters.name;
      let param = {
        staffNo : staffNo,
        delFlag : 0
      }
      
      listStaff(param).then(response => {
        staffList = response.data;
        let staffParams={
            maxMethod : 4,
            delFlag: 0
        }
        if(!staffList || staffList.length == 0){ //管理员
          //查询上级
          listStaff(staffParams).then(response => {
            this.staffTreeOptions = this.handleTree(response.data);
            this.staffOptions = response.data;
          });
        }else{ //团队或小组负责人
          let methods = staffList.map(item => item.participationMethods);
          methods.sort();
          //父级id 团队或小组负责人
          let parent = staffList.find(item => item.participationMethods == methods[0])
          staffParams.id = parent.id;
          listStaffChildren(staffParams).then(response =>{
            this.staffTreeOptions = this.handleTree(response.data);
            this.staffOptions = response.data;
          })
        }

      });
    },

    /** 转换员工数据结构 */
    normalizer(node) {
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

     /** 查询应用名称列表 */
     getAppList() {
      let param ={}
      listAppNames(param).then(response => {
        this.appNameOptions = response.data;
      });
    },

    /** 查询员工名称列表 */
    getStaffNames() {
      let param ={}
      listStaffNames(param).then(response => {
        this.staffNameOptions = response.data;
      });
    },

    /** 查询分配人名称列表 */
    getDistributeNames() {
      let param ={}
      listDistributeNames(param).then(response => {
        this.distributeNameOptions = response.data;
      });
    },

    /** 查询项目列表 */
    async getProjectList(){
      let param ={
        status : 1,
        projectTypeFlag : 1,
      }

      //查询当前登录人参与方式
      // let staffParam = {
      //   staffNo : store.getters.name,
      //   delFlag : 0
      // }
      
      // await listStaff(staffParam).then(response => {
      //   let staffList = response.data;
      //   if(!!staffList && staffList.length > 0 && !this.distributeFlag){ // 组队且非再次下发
      //     param.projectLeader = store.getters.name;
      //   }
      // });
      if(!checkRole(['administrator','admin']) && !this.distributeFlag){ // 非管理员且非再次下发
          param.projectLeader = store.getters.name;
      }

      listProject(param).then(response => {
        this.projectOptions = response.data;
      });
    },

    /**监听被分配人 */
    async watchStaffId(val){
      if (!!val){
        let staff = this.staffOptions.find(item=>item.id == val);
        // 开发人员，禁用分支及发布类型,再次下发
        if (this.distributeFlag && staff.participationMethods == 3) {
          this.branchNameDisabled = true;
          this.releaseFlagDisabled = true;
        }else{
          this.branchNameDisabled = false;
          this.releaseFlagDisabled = false;
        }

        let judgeParam = {
          staffId: val,
          participationMethods : staff.participationMethods
        }
        // 后台校验，弹窗提醒
         judgeExistTask(judgeParam).then(resp=>{
          if (!!resp.msg){
            this.$message({ message: resp.msg, type: 'warning' })
          }

          if(!this.distributeFlag){
            let staffParam = {
              staffId: val,
              status: 1,
              projectTypeFlag : 1,
            }

            listStaff(staffParam).then(response => {
              let staffList = response.data;
              if(!!staffList && staffList.length > 0){ // 组队
                staffParam.projectLeader = store.getters.name;
              }

               //查询分配人关联项目
              listStaffProject(staffParam).then(response=>{
                this.projectOptions = response.data;
                if(this.projectOptions.length > 0){
                  let project = this.projectOptions[0];
                  this.form.projectId = project.id;
                }
              })
            });
          }

        }).catch((error) => {
          console.log(error)
        })
      }else {
        this.getProjectList();
      }
    },

    /** 监听项目 */
   async watchProjectId(val){
   debugger
      this.branchNameDisabled = false;
      this.releaseFlagDisabled = false;
      this.releaseTagDisabled = false;

      if(!!val){
        if(!this.form.id || (!!this.form.id) && (val != this.form.projectId)){
           // 根据项目ID查询项目
         await getProject(val).then(response => {
            let project = response.data;
            if(!this.form.id){
              this.form.projectType = project.projectType;
            }else {
              if(this.existProjectType !== this.form.projectType){
                this.form.projectType = project.projectType;
              }
            }
           
            if(project.projectType == 1){
              let branchNames= project.branchType.split(',');
              // 过滤
              this.branchTypeOptions = this.branchTypes.filter(branchType => branchNames.includes(branchType.dictValue));
            }
          });
      
          // 判断项目下最近一次发布类型
          let projectParam={
            projectId: val
          }
          getLatestTask(projectParam).then(response=>{
            let lastTask = response.data;
            if(!lastTask){
              // 提示新项目
              this.form.releaseFlag = 0;
              this.releaseFlagDisabled = true;
            }else{
              this.projectReleaseFlag = lastTask.releaseFlag;
              //1、全量发布
              if(lastTask.releaseFlag == 1){
                this.$message.error('本项目正在全量发布中，需要在工时申报菜单中将上一条标记为全量成功或全量失败后，才能针对本项目继续发布任务');
                return;
                // 2、全量失败
              }else if(lastTask.releaseFlag == 2){
                this.branchNameDisabled = true;
                this.releaseFlagDisabled = true;
                this.releaseTagDisabled = true;
                this.form.branchName = lastTask.branchName;
                this.form.releaseFlag = 1;
                this.form.releaseTag = lastTask.releaseTag;
              }else{
                // 最新分支的发布类型
                this.branchNameDisabled = false;
                this.releaseFlagDisabled = false;
                this.releaseTagDisabled = false;
                this.form.releaseFlag = 0;
                this.form.releaseTag = null;
              }
            }
            if(this.form.projectType == 1){
              this.watchBranchName(this.form.branchName);
            }
          })
        } else {
          // 根据项目ID查询项目
          await getProject(val).then(response => {
            let project = response.data; 
            if(project.projectType == 1){
              let branchNames= project.branchType.split(',');
              // 过滤
              this.branchTypeOptions = this.branchTypes.filter(branchType => branchNames.includes(branchType.dictValue));
            }
          });
        }
      }
    },

    /** 监听分支 */
    async watchBranchName(val){
      if(!!val){
        if(!this.form.projectId){
          this.$message.error('请先选择项目再进行操作');
          return;
        }
        // 新创建项目
        let branchParam = {
          staffId: this.form.staffId,
          projectId: this.form.projectId,
          branchName: val,
        };
        await this.getBranchList(branchParam);

        if(this.projectReleaseFlag == null){
            this.form.releaseFlag = 0;
            this.releaseFlagDisabled = true;
            // 0 增量 1 全量发布 2 发布失败 3 发布成功
        }else if(this.projectReleaseFlag !==1 && this.projectReleaseFlag !==2){
          getLatestTask(branchParam).then(response=>{
          let lastTask = response.data;
          if(!lastTask){
            // 提示新项目
            this.form.releaseFlag = 0;
            this.releaseFlagDisabled = true;
          }else{
            //全量成功、增量发布
            if((this.projectReleaseFlag == 0 || this.projectReleaseFlag == 3 )){
              //全量成功
              if(lastTask.releaseFlag == 3){
                this.form.releaseFlag = 0;
                this.releaseFlagDisabled = true;
              }else{
                //增量发布
                this.releaseFlagDisabled = false;
                this.releaseTagDisabled = true;
                this.branchReleaseTag = lastTask.tagNo;
              }
            }
          }
        })
        }
      }
    },

    /** 查询分支任务 */
    getBranchList(param){
      getBranchTask(param).then(response=>{
        let branchTaskList = response.data;
        if(!!branchTaskList && branchTaskList.length>0){
          this.$message.error('该分支下尚有任务未完成工时申报，无法进行新任务下发');
          return;
        }
      })
    },

    /** 监听发布 */
    watchReleaseFlag(val){
      if(!!val){
        let param = {
          branchName : this.form.branchName,
          staffId: this.form.staffId,
        }
        listTags(param).then(response=>{
          this.tagOptions = response.data;
          if((this.projectReleaseFlag == 0 || this.projectReleaseFlag == 3 ) && val == 1){
            this.form.releaseTag = this.branchReleaseTag;
          }
        })
      }
    },

  }
};
</script>
