<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="100px">
      <el-form-item label="组队状态" prop="delFlag">
        <el-select v-model="queryParams.delFlag" placeholder="请选择组队状态" clearable>
          <el-option
            v-for="dict in dict.type.wh_team_status"
            :key="dict.value"
            :label="dict.label"
            :value="parseInt(dict.value)"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="员工名称" prop="staffName">
        <el-input
          v-model="queryParams.staffName"
          placeholder="请输入员工名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="员工编号" prop="staffNo">
        <el-input
          v-model="queryParams.staffNo"
          placeholder="请输入员工编号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="参与方式" prop="participationMethods">
        <el-select v-model="queryParams.participationMethods" placeholder="请选择参与方式" clearable>
          <el-option
            v-for="dict in dict.type.wh_participation_methods"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="是否并行开发" prop="parallelFlag">
        <el-select v-model="queryParams.parallelFlag" placeholder="请选择是否并行开发" clearable>
          <el-option
            v-for="dict in dict.type.wh_is_parallel"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="架构编号" prop="teamNo">
        <el-input
          v-model="queryParams.teamNo"
          placeholder="请输入架构编号"
          clearable
          @keyup.enter.native="handleQuery"
        />
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
          v-hasRole="['admin','team', 'administrator']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="single"
          @click="handleDelete"
          v-hasPermi="['work:staff:remove']"
        >解除</el-button>
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
      :data="staffList" 
      @selection-change="handleSelectionChange"
      :default-expand-all="isExpandAll"
      row-key="id"
      :tree-props="{children: 'children', hasChildren: 'hasChildren'}">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="员工名称" prop="staffName" />
      <el-table-column label="员工编号" align="center" prop="staffNo" />
      <el-table-column label="团队人数" align="center" prop="teamAmount" />
      <el-table-column label="首次合作时间" align="center" prop="firstCooperationTime">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.firstCooperationTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="上次终止合作时间" align="center" prop="endCooperationTime">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.endCooperationTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="参与方式" align="center" prop="participationMethods">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_participation_methods" :value="scope.row.participationMethods"/>
        </template>
      </el-table-column>
      <el-table-column label="是否并行作业" align="center" prop="parallelFlag">
        <template slot-scope="scope">
          <dict-tag v-if="scope.row.participationMethods != 3" :options="dict.type.wh_is_parallel" :value="scope.row.parallelFlag"/>
          <el-switch v-else
                v-model="scope.row.parallelFlag"
                :active-value="1"
                :inactive-value="0"
                @change="handleParallelChange(scope.row)"
              ></el-switch>
        </template>
      </el-table-column>
      <el-table-column label="组队状态" align="center" prop="delFlag">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_team_status" :value="scope.row.delFlag"/>
        </template>
      </el-table-column>
      <el-table-column label="架构名称" align="center" prop="teamName">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_team_name" :value="scope.row.teamName"/>
        </template>
      </el-table-column>
      <el-table-column label="工作内容" align="center" prop="workContent" :show-overflow-tooltip="true">
      </el-table-column>
      <el-table-column label="架构编号" align="center" prop="teamNo">
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="更新人" align="center" prop="updateByName">
      </el-table-column>
      <el-table-column label="更新时间" align="center" prop="updateTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.updateTime) }}</span>
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

    <!-- 添加或修改员工信息对话框 -->
    <el-dialog v-dialogDrag :title="title" :visible.sync="open" width="550px" append-to-body>
      <div slot="title">
        {{ this.title }}
        <el-tooltip placement="bottom">
          <div slot="content">
            组队条件：<br/>1）一个团队中，人员不能跨级组队， <br/>2）同一个人员不能分属不同的团队或子团队，<br/>3）在同一个团队或子团队中，相同的参与方式不能出现两次或以上
          </div>
          <svg-icon icon-class="question"/>
        </el-tooltip>
      </div>
      <el-form ref="form" :model="form" :rules="rules" label-width="110px">
        <el-form-item label="员工" prop="staffNo">
          <el-select v-model="form.staffNo" placeholder="请选择员工" filterable @change="selectStaffChange" clearable >
            <el-option
              v-for="item in userOptions"
              :key="item.id"
              :label="`${item.userName}（${item.nickName}）`"
              :value="item.userName"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="参与方式" prop="participationMethods">
          <el-select v-model="form.participationMethods"  placeholder="请选择参与方式" clearable>
            <el-option
              v-for="dict in methodsOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="工作内容" prop="workContent">
          <el-input type="textarea" v-model="form.workContent" placeholder="请输入工作内容" :rows="3" maxlength="300" show-word-limit/>
        </el-form-item>
        <el-form-item label="是否并行作业" prop="parallelFlag" v-if="form.participationMethods == 3" :rules="form.participationMethods === 3 ? rules.parallelFlag : [{ required: false }]">
          <el-radio v-model="form.parallelFlag" :label="0">否</el-radio>
          <el-radio v-model="form.parallelFlag" :label="1">是</el-radio>
        </el-form-item>
        <el-form-item label="参与团队" prop="parentId" v-if="treeShow">
          <treeselect v-model="form.parentId" :options="staffTreeOptions" :normalizer="normalizer" placeholder="选择参与团队" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

        <!-- 解除对话框 -->
    <el-dialog v-dialogDrag title="解除组队" :visible.sync="openDismiss" width="550px" append-to-body>
      <el-form ref="dismissForm" :model="dismissForm" :rules="dismissRules" label-width="150px">
        <el-form-item label="是否终止与我司合作" prop="dismissFlag">
          <el-radio v-model="dismissForm.dismissFlag" label="0">否</el-radio>
          <el-radio v-model="dismissForm.dismissFlag" label="1">是</el-radio>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="handleDismiss">确 定</el-button>
        <el-button @click="cancelDismiss">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listStaff, listPageStaff, singleListStaff, listStaffParents, addStaff, updateStaff, dismiss, checkExist, changeParallelFlag } from "@/api/work/staff";
import { listUser } from "@/api/system/user";
import Treeselect from "@riophae/vue-treeselect";
import "@riophae/vue-treeselect/dist/vue-treeselect.css";
import { deepClone } from '@/utils/index'
import store from "@/store";

export default {
  name: "Staff",
  dicts: ['wh_participation_methods', 'wh_team_name', 'wh_team_status', 'wh_is_parallel'],
  components: { Treeselect },
  data() {
    return {
      // 遮罩层
      loading: true,
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 员工信息表格数据
      staffList: [],
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
        delFlag: 0,
        staffNo: null,
        staffName: null,
        participationMethods: null,
        teamNo: null,
        orderByColumn: 'createTime',
        isAsc: 'descending',
      },
      // 表单参数
      form: {
        workContent: null
      },
      // 表单校验
      rules: {
        staffNo: [
          { required: true, message: "员工编号不能为空", trigger: "change" }
        ],
        participationMethods: [
          { required: true, message: "参与方式不能为空", trigger: "change" }
        ],
        parallelFlag: [
          { required: true, message: "是否并行开发不能为空", trigger: "change" }
        ],
        workContent: [
          { required: true, message: "工作内容不能为空", trigger: "blur" }
        ],
      },
      //员工树
      staffTreeOptions:[],
      staffOptions:[],
      treeShow: false,
      //用户列表
      userOptions:[],
      methodsOptions:[],
      parentId: null,
      singleSelectRow:{},

      // 是否显示解除弹出层
      openDismiss: false,
      dismissForm:{},
      dismissRules: {
        dismissFlag: [
          { required: true, message: "是否终止合作不能为空", trigger: "blur" }
        ],
      },

    };
  },
  created() {
    this.getList();
  },
  watch: {
    'form.participationMethods': function(val) {
      this.participationMethodsChange(val);
    }
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
    
    /** 查询员工信息列表 */
    getList() {
      this.loading = true;
      //判断当前登录人
      let staffList = []
      //查询当前登录人参与方式
      let param = {
        staffNo : store.getters.name,
        delFlag : 0
      }
      listStaff(param).then(response => {
        staffList = response.data;
        if(!staffList || staffList.length == 0){ //管理员
          //查询全部
          listPageStaff(this.queryParams).then(response => {
            this.staffList = this.handleTree(response.rows)
            this.total = response.total;
            this.loading = false;
          });
        }else{ 
          let minMethod = Math.min.apply(null, staffList.map(item => item.participationMethods));
          //父级id 团队或小组负责人
          let staff = staffList.find(item => item.participationMethods == minMethod)
          this.queryParams.id = staff.id;
          singleListStaff(this.queryParams).then(response =>{
            this.staffList = this.handleTree(response.rows);
            this.total = response.total;
            this.loading = false;
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

    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
      this.treeShow = false;
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        parentId: null,
        staffNo: null,
        staffName: null,
        workContent: null,
        participationMethods: null,
        
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
      this.single = selection.length!==1
      this.singleSelectRow = selection[0];
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.getUserList();
      this.open = true;
      this.title = "添加组队配置";
      this.form.workContent = '默认';
    },
    /** 展开/折叠操作 */
    toggleExpandAll() {
      this.refreshTable = false;
      this.isExpandAll = !this.isExpandAll;
      this.$nextTick(() => {
        this.refreshTable = true;
      });
    },

    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          //检验是否跨级选择
          if(this.form.participationMethods != 1){
            if(!this.form.parentId){
              this.$message.error('参与团队不能为空')
              return;
            }
            let parent= this.staffOptions.find(item=>item.id == this.form.parentId);
            this.form.teamId = parent.teamId;
            if(parent.participationMethods != this.form.participationMethods-1){
              this.$message.error('参与团队不能跨级，请重新选择')
              return;
            }
          }

          //用户名称
          let user = this.userOptions.find(item=>item.userName == this.form.staffNo);
          this.form.staffName = user.nickName;
          
          if (this.form.id != null) {
            updateStaff(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addStaff(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },

    /** 解除按钮操作 */
    handleDelete() {
      this.resetDismiss();
      //判断是否已解除
      if(this.singleSelectRow.delFlag == 1){
        this.$message.error('已解除组队，请勿重复操作');
        return;
      }
      //判断所辖任务均完成申报和发放
      let exist = false;
      let existParam={
        id : this.singleSelectRow.id,
        participationMethods: this.singleSelectRow.participationMethods
      }
      checkExist(existParam).then(response => {
        exist = response.data;

        //过滤子节点中未解除
        let childrenArr = [];
        if (!!this.singleSelectRow.children && this.singleSelectRow.children.length > 0){
          childrenArr = this.singleSelectRow.children.filter(obj=>obj.delFlag == 0);
        }
         
        if((!!childrenArr && childrenArr.length > 0) || exist){
          this.$message.error('不满足解除条件，请检查以下内容：1）是否完成了任务申报；2）是否存在子级');
          return;
        }
        this.openDismiss = true;
      });

      
    },

    /** 处理解除操作 */
    handleDismiss(){
      this.$refs["dismissForm"].validate(valid => {
        if (valid) {
          this.dismissForm.id = this.singleSelectRow.id;
          this.dismissForm.staffNo = this.singleSelectRow.staffNo;
          this.dismissForm.participationMethods = this.singleSelectRow.participationMethods;

          dismiss(this.dismissForm).then(response => {
            this.$modal.msgSuccess("解除成功");
            this.openDismiss = false;
            this.getList();
          });
        }
      });
    },

    /** 导出按钮操作 */
    handleExport() {
      this.download('work/staff/export', {
        ...this.queryParams
      }, `staff_${new Date().getTime()}.xlsx`)
    },

    /** 员工修改 */
    selectStaffChange(element){
      this.form.participationMethods = null;
      this.methodsOptions = deepClone(this.dict.type.wh_participation_methods);
      //判断员工是否已存在
      let param = {
        staffNo : element
      }
      let staffArray = [];
      listStaff(param).then(response => {
        staffArray = response.data;
        //排除逻辑删（已解除）
        let newArr =  staffArray.filter(obj=>obj.delFlag == 0)
        if(!!newArr && newArr.length > 0){
          //过滤数据字典
          let methodsArray = newArr.map(item => item.participationMethods);
          methodsArray.sort();
          for(let i=0;i<methodsArray[methodsArray.length-1];i++){
            this.updateDictList(i+1, this.methodsOptions);
          }
          //过滤参与团队
          this.form.teamId = newArr[0].teamId;
          let parent= newArr.find(item=>item.participationMethods == methodsArray[methodsArray.length-1]);
          this.parentId = parent.id;

        }
      });

    },

    /** 删除数据字典选项 */
    updateDictList(value, dictList) {
      const index = dictList.findIndex(item => item.value == value)
      if (index > -1) {
        dictList.splice(index, 1);
      }
    },

    //参与方式修改
    participationMethodsChange(item){
      debugger
      if(!item || item == 1){
        this.treeShow = false;
      }else{
        this.treeShow = true;
        //判断是否已添加过
        if(!this.parentId){
          let staffParams={
            maxMethod: item,
            teamId: this.form.teamId,
            status: 0,
            delFlag: 0,
          }
          //查询上级
          listStaff(staffParams).then(response => {
            this.staffOptions = response.data;
            this.staffTreeOptions = this.handleTree(response.data);
            this.parentId = null;
          });
        }else{
          //递归查询父节点
          let staffParams={
            id: this.parentId
          }
          listStaffParents(staffParams).then(response => {
            this.staffOptions = response.data;
            this.staffTreeOptions = this.handleTree(response.data);
            this.parentId = null;
          });
        }
      }
    },

    // 取消按钮
    cancelDismiss() {
      this.openDismiss = false;
      this.resetDismiss();
    },

    // 表单重置
    resetDismiss() {
      this.dismissForm = {
        id: null,
        dismissFlag: '0',
        staffNo: null,
        participationMethods: null,
        
      };
      this.resetForm("dismissForm");
    },

     // 用户状态修改
     handleParallelChange(row) {
      let text = row.parallelFlag === 0 ? "关闭" : "开启";
      let data = {
        id: row.id,
        parallelFlag: row.parallelFlag
      }
      this.$modal.confirm('确认要"' + text + '"并行开发吗？').then(function() {
        return changeParallelFlag(data);
      }).then(() => {
        this.$modal.msgSuccess(text + "成功");
      }).catch(function() {
        row.parallelFlag = row.parallelFlag === 0 ? 1 : 0;
      });
    },
  }
};
</script>
