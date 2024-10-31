<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="125px">
      <el-form-item label="申报状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择申报状态" clearable>
          <el-option
            v-for="dict in dict.type.wh_claim_status"
            :key="dict.value"
            :label="dict.label"
            :value="parseInt(dict.value)"
          />
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
      <el-form-item label="被分配人" prop="staffNoQuery">
          <span slot="label">
            <el-tooltip placement="top">
              <div slot="content">
                只有参与方式为“开发人员”的才能申报工时、领新分配
              </div>
              <i class="el-icon-question"></i>
            </el-tooltip>
            被分配人
          </span>
        <el-select v-model="queryParams.staffNoQuery" placeholder="请选择被分配人" clearable filterable :disabled="staffDisabled">
          <el-option
            v-for="item in staffNameOptions"
            :key="item.staffNo"
            :label="item.staffName"
            :value="item.staffNo"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="被分配人参与方式" prop="participationMethods">
        <el-select v-model="queryParams.participationMethods" placeholder="被分配人参与方式" clearable disabled>
          <el-option
            v-for="dict in participationMethodsOptions"
            :key="dict.dictValue"
            :label="dict.dictLabel"
            :value="parseInt(dict.dictValue)"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="主项目名称" prop="mainProjectName">
        <el-input
          v-model="queryParams.mainProjectName"
          placeholder="请输入主项目名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="子项目名称" prop="projectId">
        <el-select v-model="queryParams.projectId" placeholder="请选择子项目名称" clearable filterable>
          <el-option
            v-for="item in projectOptions"
            :key="item.id"
            :label="`${item.projectName}`+ (!item.summaryNo ? '' : '/' + item.summaryNo)"
            :value="item.id"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="项目类型" prop="projectType">
        <el-select v-model="queryParams.projectType" placeholder="请选择项目类型" clearable>
          <el-option
            v-for="dict in dict.type.wh_pro_type"
            :key="dict.value"
            :label="dict.label"
            :value="parseInt(dict.value)"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="领薪人" prop="salaryStaffName">
        <el-select v-model="queryParams.salaryStaffName" placeholder="请选择领薪人" clearable filterable>
          <el-option
            v-for="item in salaryNameOptions"
            :key="item.staffName"
            :label="item.staffName"
            :value="item.staffName"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="分配年月" prop="distributeMonth" >
        <el-date-picker
          v-model="queryParams.distributeMonth"
          type="month"
          placeholder="选择年月"
          format="yyyy 年 MM 月"
          value-format="yyyy-MM">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="申报所属年月" prop="month" >
        <el-date-picker
          v-model="queryParams.month"
          type="month"
          placeholder="选择年月"
          format="yyyy 年 MM 月"
          value-format="yyyy-MM">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="发布类型" prop="releaseFlag">
        <el-select v-model="queryParams.releaseFlag" placeholder="请选择发布类型" clearable>
          <el-option
            v-for="dict in dict.type.wh_full_release"
            :key="dict.value"
            :label="dict.label"
            :value="parseInt(dict.value)"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="分支号" prop="branchName">
        <el-select v-model="queryParams.branchName" placeholder="请选择分支号" clearable>
          <el-option
            v-for="dict in dict.type.wh_branch_type"
            :key="dict.value"
            :label="`${dict.label}/${dict.value}`"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <!-- <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          :disabled="single"
          @click="handleAdd"
          v-hasPermi="['work:taskClaim:distribute']"
        >领薪分配</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-tooltip placement="bottom">
          <div slot="content">
            主表中，只显示出当前登陆人作为开发人员所接受的任务内容（未指明<br/>
            参与方式的用户会列出全部开发人员的数据），只有登陆人作为开发人<br/>
            员的，才能操作领薪分配功能。
          </div>
          <svg-icon icon-class="question"/>
        </el-tooltip>
      </el-col> -->
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-view"
          size="mini"
          :disabled="single"
          @click="handleDetail"
          v-hasPermi="['work:taskInquire:query']"
        >详情</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="singleAdjust"
          @click="handleAdjust"
          v-if="staffFlag == 0 || checkRole(['team']) "
        >调整</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-tooltip placement="bottom">
          <div slot="content">
            只有登录人为分配人才能调整
          </div>
          <svg-icon icon-class="question"/>
        </el-tooltip>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="info"
          plain
          icon="el-icon-s-order"
          size="mini"
          @click="handleDescription"
          v-hasPermi="['work:taskInquire:query']"
        >任务描述</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table 
      v-loading="loading" 
      :data="taskList" 
      @selection-change="handleSelectionChange"
      @sort-change="sortChange"
      ref="taskTable">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="任务编号" align="center" prop="taskNo" width="180"/>
      <el-table-column label="父级任务编号" align="center" prop="parentTaskNo" width="180"/>
      <el-table-column label="主项目名称" align="center" prop="mainProjectName" :show-overflow-tooltip="true"/>
      <el-table-column label="子项目名称" align="center" prop="projectName" :show-overflow-tooltip="true" />
      <el-table-column label="项目类型" align="center" prop="projectType">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_pro_type" :value="scope.row.projectType"/>
        </template>
      </el-table-column>
      <el-table-column label="任务名称" align="center" prop="appName" :show-overflow-tooltip="true"/>
      <el-table-column label="分配人" align="center" prop="createByName" />
      <el-table-column label="分配人参与方式" align="center" prop="createParticipationMethods">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_participation_methods" :value="scope.row.createParticipationMethods"/>
        </template>
      </el-table-column>
      <el-table-column label="被分配人" align="center" prop="staffName" />
      <el-table-column label="任务分配时间" align="center" prop="distributionTime" width="150" sortable="custom">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.distributionTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="工时申报时间" align="center" prop="submitTime" width="150" sortable="custom">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.submitTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="交互用时（天）" align="center" prop="spendTime" width="150" sortable="custom"/>
      <el-table-column label="申报工时" align="center" prop="workingHours" sortable="custom">
        <template slot-scope="scope">
          <span>{{ scope.row.workingHours.toFixed(1) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="领薪累计工时" align="center" prop="paidHours" width="130" sortable="custom">
        <template slot-scope="scope">
          <span v-if="!scope.row.subPaidHours">{{ scope.row.paidHours.toFixed(1) }}</span>
          <span v-else>{{ scope.row.subPaidHours.toFixed(1) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="申报所属年月" align="center" prop="month"  width="130" sortable="custom"/>
      <el-table-column label="tag标签编号" align="center" prop="tagNo" :show-overflow-tooltip="true"/>
      <el-table-column label="发布类型" align="center" prop="releaseFlag">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_full_release" :value="scope.row.releaseFlag"/>
        </template>
      </el-table-column>
      <el-table-column label="分支号" align="center" prop="branchName">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_branch_type" :value="scope.row.branchName"/>
        </template>
      </el-table-column>
      <el-table-column label="内部分支" align="center" prop="innerBranch"/>
      <el-table-column label="申报状态" align="center" prop="status">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.wh_claim_status" :value="scope.row.status"/>
        </template>
      </el-table-column>
    </el-table>

    <el-row :gutter="20" style="margin-top:20px">
      <el-col :span="4">
        <div>
          <el-statistic :value="totalWorkingHours" group-separator="," :precision="1">
            <template slot="prefix"> 项目总工时数 &ensp;&ensp;</template>
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

    <!-- 添加或修改任务对话框 -->
    <el-dialog v-dialogDrag :title="title" :visible.sync="open" width="1250px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="190px">
        <el-collapse v-model="addActiveNames">
          <el-collapse-item title="基本信息" name="1">
            <el-form-item label="申报所属年月" prop="month" >
              <el-date-picker
                v-model="form.month"
                type="month"
                placeholder="选择年月"
                format="yyyy 年 MM 月"
                value-format="yyyy-MM"
                :picker-options="pickerOptions">
              </el-date-picker>
            </el-form-item>
            <el-form-item prop="projectType" >
              <span slot="label">
                项目类型
                <el-tooltip placement="top">
                  <div slot="content">
                    不同的项目类型显示不同的输入内容
                  </div>
                  <i class="el-icon-question"></i>
                </el-tooltip>
              </span>
              <el-select v-model="form.projectType" placeholder="请选择项目类型" disabled>
                <el-option
                  v-for="dict in dict.type.wh_pro_type"
                  :key="dict.value"
                  :label="dict.label"
                  :value="parseInt(dict.value)"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item v-show="form.projectType === 1" label="内部分支" prop="innerBranch">
              {{ form.innerBranch }}
            </el-form-item>
          </el-collapse-item>

          <el-collapse-item title="完成概要" name="2">
            <el-form-item label="是否确认完成本次工时任务" prop="uploadStatus">
              <el-radio v-model="form.uploadStatus" :label="0">否</el-radio>
              <el-radio v-model="form.uploadStatus" :label="1">是</el-radio>
            </el-form-item>
            <el-form-item label="完成说明" prop="completeInstructions">
              <el-input type="textarea" v-model="form.completeInstructions" placeholder="请输入完成说明" :rows="3" maxlength="200" show-word-limit/>
            </el-form-item>
            <el-form-item label="交互用时" prop="spendTime" >
              {{ form.spendTime }} （天）
            </el-form-item>
            <el-form-item v-if="form.projectType === 1" prop="fileUrl">
              <span slot="label">
                代码仓库地址
                <el-tooltip placement="top">
                  <div slot="content">
                   地址只需精确到项目级别，例如：https://gits.sinoaopt.com/群组名/项目名.git
                  </div>
                  <i class="el-icon-question"></i>
                </el-tooltip>
              </span>
              <el-input v-model="form.fileUrl" placeholder="请输入代码仓库地址" />
            </el-form-item>
            <el-form-item v-if="form.releaseFlag === 1" label="发布文件" prop="releaseAttachment" :rules="form.releaseFlag == 1 ? rules.releaseAttachment : [{ required: false }]">
              <el-upload
                ref="upload"
                :limit="1"
                accept=".xlsx, .xls"
                :headers="upload.headers"
                :action="upload.url"
                :disabled="upload.isUploading"
                :on-progress="handleFileUploadProgress"
                :on-success="handleFileSuccess"
              >
                <el-button plain icon="el-icon-upload" size="mini" type="info">上传</el-button>
                <div class="el-upload__tip" slot="tip">
                  <span>仅允许导入xls、xlsx格式文件。</span>
                  <el-link type="primary" :underline="false" style="font-size:12px;vertical-align: baseline;"  :href="templateUrl" target="_blank">下载模板</el-link>
                </div>
              </el-upload>
            </el-form-item>
            <el-form-item v-if="form.releaseFlag === 1" label="发布版注意事项">
              {{this.attentionInfo}}
            </el-form-item>
            <el-form-item v-if="form.projectType === 1" prop="tagNo">
              <span slot="label">
                tag标签编号
                <el-tooltip placement="top">
                  <div slot="content">
                    <br/>1）前后端项目tag标签必须相同， <br/>2）均务必保持与本次提交的代码标签一致
                  </div>
                  <i class="el-icon-question"></i>
                </el-tooltip>
              </span>
              <el-input v-model="form.tagNo" placeholder="请输入tag标签编号" />
            </el-form-item>
            <el-form-item v-if="form.projectType === 1" label="提交确认项">
              <div>1、与工时任务分配人完成确认</div>
              <div>2、代码仓库地址准确无误</div>
              <div>3、根据gits仓库代码提交规范，提交源码、SQL文件、配置文件到代码仓库</div>
            </el-form-item>
          </el-collapse-item>

          <el-collapse-item title="申报明细" name="3">
            <el-form-item prop="workingHours">
              <span slot="label">
                申报工时
                <el-tooltip placement="top">
                  <div slot="content">
                    每次申报工时数量不得超过{{ maxThreshold }}
                  </div>
                  <i class="el-icon-question"></i>
                </el-tooltip>
              </span>
              <el-input-number v-model="form.workingHours" placeholder="请输入工时" :min="0" :max="maxThreshold" :precision="1" :step="0.1" :disabled="form.configStatus == 1" controls-position="right"/>
            </el-form-item>
            <el-form-item label="工时申报明细" v-if="form.configStatus == 1">
              <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAddClaimDetail">新增</el-button>
            </el-form-item>

            <el-table :data="form.claimDetailList" border v-if="form.configStatus == 1" @row-click="handleClaimDetailClick">
              <el-table-column label="序号" align="center" type="index" />
              <el-table-column type="expand">
                <template slot-scope="props">
                    <el-table 
                    :data="props.row.claimDetailItemList" 
                    size="mini" 
                    border 
                    style="width: 96%; margin-left: 1%;">
                      <el-table-column label="视频名称" align="center" prop="videoUrl">
                        <template slot-scope="scope">
                          <el-link type="primary" :href="scope.row.videoUrl" target="_blank">{{ scope.row.videoUrl }}</el-link>
                        </template>
                      </el-table-column>
                      <el-table-column label="开始时间" align="center" prop="startTime" width="150" >
                        <template slot-scope="scope">
                          <span>{{ parseTime(scope.row.startTime)}}</span>
                        </template>
                      </el-table-column>
                      <el-table-column label="结束时间" align="center" prop="endTime" width="150">
                        <template slot-scope="scope">
                          <span>{{ parseTime(scope.row.endTime) }}</span>
                        </template>
                      </el-table-column>
                      <el-table-column label="时长" align="center" prop="duration" width="80" >
                        <template slot-scope="scope">
                          <span>{{ parseTime(scope.row.duration, '{h}:{i}:{s}') }}</span>
                        </template>
                      </el-table-column>
                      <el-table-column label="操作" align="center" width="110" >
                        <template slot-scope="scope">
                          <el-button
                            size="mini"
                            type="text"
                            icon="el-icon-lock"
                            v-if="!scope.row.lockStatus"
                            @click="handleLockClaimDetailItem(scope.$index, props.$index, props.row.claimDetailItemList)"
                          >锁定</el-button>
                          <el-button
                            size="mini"
                            type="text"
                            icon="el-icon-delete"
                            v-if="scope.row.lockStatus == 1"
                            @click="handleDeleteClaimDetailItem(scope.$index, props.$index, props.row.claimDetailItemList)"
                          >删除</el-button>
                        </template>
                      </el-table-column>
                    </el-table>
                </template>
              </el-table-column>
              <el-table-column label="工时类型" align="center" prop="claimType" width="250">
                <template slot-scope="scope">
                  <el-row :gutter="5">
                    <el-col :span="18">
                      <el-select v-model="scope.row.claimType" placeholder="请选择工时类型" clearable>
                        <el-option
                          v-for="dict in claimTypeOptions"
                          :key="dict.dictValue"
                          :label="dict.dictLabel"
                          :value="parseInt(dict.dictValue)"
                        />
                      </el-select>
                    </el-col>
                    <el-col :span="6">
                      <el-button type="primary" plain size="mini" v-if="scope.row.claimType==1" @click="handleSelectRecord(scope.$index)" :disabled="!scope.row.claimType||scope.row.lockStatus==1">选择</el-button>
                      <el-button type="primary" plain size="mini" v-else @click="handleSelectTime(scope.$index)" :disabled="!scope.row.claimType||scope.row.lockStatus==1">选择</el-button>
                    </el-col>
                  </el-row>
                </template>
              </el-table-column>
              <el-table-column label="说明" align="center" prop="description">
                <template slot-scope="scope">
                  <el-input v-model="scope.row.description" placeholder="请输入说明"></el-input>
                </template>
              </el-table-column>
              <el-table-column label="累计时长" align="center" prop="totalHours" width="230">
                <template slot-scope="scope">
                  <el-input-number v-model="scope.row.totalHours" placeholder="请输入累计时长" :min="0" :max="maxThreshold" :precision="1" :step="0.1" controls-position="right" disabled></el-input-number>
                </template>
              </el-table-column>
              <el-table-column label="申报时长" align="center" prop="workingHours" width="230">
                <template slot-scope="scope">
                  <el-input-number v-model="scope.row.workingHours" placeholder="请输入申报时长" :min="0" :max="maxThreshold" :precision="1" :step="0.1" controls-position="right" @change="detailHoursChange"></el-input-number>
                </template>
              </el-table-column>
              <el-table-column label="操作" align="center" width="110" >
                <template slot-scope="scope">
                  <el-button
                    size="mini"
                    type="text"
                    icon="el-icon-lock"
                    v-if= "scope.row.lockStatus == 0"
                    @click="handleLockClaimDetail(scope.$index,form.claimDetailList)"
                  >锁定</el-button>
                  <el-button
                    size="mini"
                    type="text"
                    icon="el-icon-delete"
                    v-if= "scope.row.lockStatus == 1"
                    @click="handleDeleteClaimDetail(scope.$index,form.claimDetailList)"
                  >删除</el-button>
                </template>
              </el-table-column>
            </el-table>
            <el-form-item label="工时分配明细" v-if="form.humanCompanyRelation == 2">
              <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAddSalary">新增</el-button>
            </el-form-item>
            <el-table :data="form.distributionList" border v-if="form.humanCompanyRelation == 2">
              <el-table-column label="序号" align="center" type="index" />
              <el-table-column label="领薪人员" align="center" prop="staffId">
                <template slot-scope="scope">
                  <el-select v-model="scope.row.staffId" placeholder="请选择领薪人员" @change="selectSalaryChange">
                  <el-option
                    v-for="item in salaryStaffOptions"
                    :key="item.id"
                    :label="item.staffName"
                    :value="item.id"
                  ></el-option>
                  </el-select>
                </template>
              </el-table-column>
              <el-table-column label="工时" align="center" prop="workingHours">
                <template slot-scope="scope">
                  <el-input-number v-model="scope.row.workingHours" placeholder="请输入工时" :min="0" :max="maxThreshold" :precision="1" :step="0.1" controls-position="right"></el-input-number>
              </template>
              </el-table-column>
              <el-table-column label="操作" align="center" width="80" >
                <template slot-scope="scope">
                  <el-button
                    size="mini"
                    type="text"
                    icon="el-icon-delete"
                    @click="handleDeleteSalary(scope.$index,form.distributionList)"
                  >删除</el-button>
                </template>
              </el-table-column>
            </el-table>
          </el-collapse-item>
        </el-collapse>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="danger" @click="tempSaveForm">暂 存</el-button>
        <el-button type="primary" @click="submitForm">提 交</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 详情任务对话框 -->
    <el-dialog v-dialogDrag :title="detailTitle" :visible.sync="openDetail" width="1250px" append-to-body>
      <el-form ref="form" :model="detailForm" label-width="190px">
        <el-collapse v-model="activeNames">
          <el-collapse-item title="基本信息" name="1">
            <el-form-item label="任务说明" prop="description">
              {{ detailForm.description }}
            </el-form-item>
            <el-form-item label="任务链接地址" prop="linkUrl">
              <el-link type="primary" :href="(`${detailForm.linkUrl}`.indexOf('http://') !== -1 || `${detailForm.linkUrl}`.indexOf('https://') !== -1) ? detailForm.linkUrl : 'http://'+detailForm.linkUrl" target="_blank">{{ detailForm.linkUrl }}</el-link>
            </el-form-item>
            <el-form-item label="链接二维码" prop="qrCode">
              <imagePreview :src="detailForm.qrCode" :width="120" :height="120" v-if="!!detailForm.qrCode"/>
            </el-form-item>
            <el-form-item label="申报所属年月" prop="month" >
              {{ detailForm.month }} 
            </el-form-item>
            <el-form-item label="项目类型" prop="projectType" >
              <el-select v-model="detailForm.projectType" placeholder="请选择项目类型" disabled>
                <el-option
                  v-for="dict in dict.type.wh_pro_type"
                  :key="dict.value"
                  :label="dict.label"
                  :value="parseInt(dict.value)"
                />
              </el-select>
            </el-form-item>
            <el-form-item v-show="detailForm.projectType === 1" label="内部分支" prop="innerBranch">
              {{ detailForm.innerBranch }}
            </el-form-item>
          </el-collapse-item>

          <el-collapse-item title="完成概要" name="2">
            <el-form-item label="是否确认完成本次工时任务" prop="uploadStatus">
              <el-radio v-model="detailForm.uploadStatus" :label="0" disabled>否</el-radio>
              <el-radio v-model="detailForm.uploadStatus" :label="1" disabled>是</el-radio>
            </el-form-item>
            <el-form-item label="完成说明" prop="completeInstructions" >
              {{ detailForm.completeInstructions }} 
            </el-form-item>
            <el-form-item label="交互用时" prop="spendTime" >
              {{ detailForm.spendTime }} （天）
            </el-form-item>
            <el-form-item v-if="detailForm.projectType === 1" label="代码仓库地址" prop="fileUrl" >
              <el-link type="primary" :href="(`${detailForm.fileUrl}`.indexOf('http://') !== -1 || `${detailForm.fileUrl}`.indexOf('https://') !== -1) ? detailForm.fileUrl : 'http://'+detailForm.fileUrl" target="_blank">{{ detailForm.fileUrl }}</el-link>
            </el-form-item>

            <el-form-item v-if="detailForm.releaseFlag === 1" label="发布文件" prop="releaseAttachment">
              <el-link type="primary" :href="detailForm.releaseAttachment" target="_blank">{{ `${detailForm.releaseAttachment}`.substr(`${detailForm.releaseAttachment}`.lastIndexOf('/')+1) }}</el-link>
            </el-form-item>
            <el-form-item v-if="detailForm.releaseFlag === 1" label="发布版注意事项">
              {{this.attentionInfo}}
            </el-form-item>

            <el-form-item v-if="detailForm.projectType === 1" label="tag标签编号" prop="tagNo" >
              {{ detailForm.tagNo }} 
            </el-form-item>

            <el-form-item v-if="detailForm.projectType === 1" label="提交确认项" >
              <div>1、与工时任务分配人完成确认</div>
              <div>2、代码仓库地址准确无误</div>
              <div>3、根据gits仓库代码提交规范，提交源码、SQL文件、配置文件到代码仓库</div>
            </el-form-item>
          </el-collapse-item>

          <el-collapse-item title="申报明细" name="3">
            <el-form-item label="申报工时" prop="workingHours">
              {{ detailForm.workingHours }}
            </el-form-item>

            <el-form-item label="工时申报明细" v-if="detailForm.configStatus == 1">
            </el-form-item>
            <el-table :data="detailForm.claimDetailList" border v-if="detailForm.configStatus == 1">
              <el-table-column label="序号" align="center" type="index" />
              <el-table-column type="expand" >
                <template slot-scope="props">
                    <el-table
                    :data="props.row.claimDetailItemList" 
                    size="mini" 
                    border 
                    style="width: 96%; margin-left: 1%;">
                      <el-table-column label="视频名称" align="center" prop="videoUrl">
                        <template slot-scope="scope">
                          <el-link type="primary" :href="scope.row.videoUrl" target="_blank">{{ scope.row.videoUrl }}</el-link>
                        </template>
                      </el-table-column>
                      <el-table-column label="开始时间" align="center" prop="startTime" width="150" >
                        <template slot-scope="scope">
                          <span>{{ parseTime(scope.row.startTime)}}</span>
                        </template>
                      </el-table-column>
                      <el-table-column label="结束时间" align="center" prop="endTime" width="150">
                        <template slot-scope="scope">
                          <span>{{ parseTime(scope.row.endTime) }}</span>
                        </template>
                      </el-table-column>
                      <el-table-column label="时长" align="center" prop="duration" width="80" >
                        <template slot-scope="scope">
                          <span>{{ parseTime(scope.row.duration, '{h}:{i}:{s}') }}</span>
                        </template>
                      </el-table-column>
                    </el-table>
                </template>
              </el-table-column>
              <el-table-column label="工时类型" align="center" prop="claimType">
                <template slot-scope="scope">
                  <dict-tag :options="dict.type.wh_claim_type" :value="scope.row.claimType"/>
                </template>
              </el-table-column>
             
              <el-table-column label="说明" align="center" prop="description">
              </el-table-column>
              <el-table-column label="累计时长" align="center" prop="totalHours" width="230">
                <template slot-scope="scope">
                  <span>{{ scope.row.totalHours.toFixed(1) }}</span>
                </template>
              </el-table-column>
              <el-table-column label="工时数" align="center" prop="workingHours" width="230">
                <template slot-scope="scope">
                  <span>{{ scope.row.workingHours.toFixed(1) }}</span>
                </template>
              </el-table-column>
            </el-table>

            <el-form-item label="工时分配明细" v-if="detailForm.humanCompanyRelation == 2">
            </el-form-item>
            <el-table :data="detailForm.distributionList" border v-if="detailForm.humanCompanyRelation == 2">
              <el-table-column label="序号" align="center" type="index" />
              <el-table-column label="领薪人员" align="center" prop="staffName" />
              <el-table-column label="工时" align="center" prop="workingHours" width="230">
                <template slot-scope="scope">
                  <span>{{ scope.row.workingHours.toFixed(1) }}</span>
                </template>
              </el-table-column>
              <el-table-column label="工时单价（元/小时）" align="center" prop="workingPrice">
                <template slot-scope="scope">
                  <span>{{ scope.row.workingPrice.toFixed(1) }}</span>
                </template>
              </el-table-column>
              <el-table-column label="小计（元）" align="center" prop="subTotal">
                <template slot-scope="scope">
                  <span>{{ scope.row.subTotal.toFixed(1) }}</span>
                </template>
              </el-table-column>
            </el-table>
          </el-collapse-item>
        </el-collapse>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="cancelDetail">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 调整对话框 -->
    <el-dialog v-dialogDrag title="调整发布类型" :visible.sync="openAdjust" width="600px" append-to-body>
      <el-form ref="adjustForm" :model="adjustForm" :rules="adjustRules" label-width="110px" >
        <el-form-item label="发布类型" prop="releaseFlag">
          <el-select v-model="adjustForm.releaseFlag" placeholder="请选择发布类型">
            <el-option label="全量失败" :value="2" />
            <el-option label="全量成功" :value="3" />
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitAdjust">确 定</el-button>
        <el-button @click="cancelAdjust">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 选择记录对话框 -->
    <el-dialog v-dialogDrag :visible.sync="openRecord" width="1050px" append-to-body>
      <template slot="title">
        选择视频记录
        <el-tooltip placement="top">
          <div slot="content">
            <p>1、视频记录五分钟同步一次，如暂无记录，请五分钟后重试</p>
            <p>2、不足一分钟视频将会被过滤，没有包含大于一分钟的主表也会被过滤</p>
          </div>
          <i class="el-icon-question"></i>
        </el-tooltip>
      </template>
      <el-table 
        v-loading="loadingRecord" 
        :data="recordList"
        >
        <el-table-column type="expand" >
          <template slot-scope="props">
              <el-table 
              :data="props.row.recordDetailList" 
              size="mini" 
              border 
              style="width: 96%; margin-left: 1%;"
              @selection-change="handleSelectionRecordDetailChange">
                <el-table-column type="selection" width="55" align="center" />
                <el-table-column label="视频名称" align="center" prop="videoUrl">
                  <template slot-scope="scope">
                    <el-link type="primary" :href="scope.row.videoUrl" target="_blank">{{ scope.row.videoUrl }}</el-link>
                  </template>
                </el-table-column>
                <el-table-column label="开始时间" align="center" prop="startTime" width="150" >
                  <template slot-scope="scope">
                    <span>{{ parseTime(scope.row.startTime)}}</span>
                  </template>
                </el-table-column>
                <el-table-column label="结束时间" align="center" prop="endTime" width="150">
                  <template slot-scope="scope">
                    <span>{{ parseTime(scope.row.endTime) }}</span>
                  </template>
                </el-table-column>
                <el-table-column label="时长" align="center" prop="duration" width="100" >
                  <template slot-scope="scope">
                    <span>{{ parseTime(scope.row.duration, '{h}:{i}:{s}') }}</span>
                  </template>
                </el-table-column>
              </el-table>
          </template>
        </el-table-column>
        <el-table-column label="用户名" align="center" prop="userName" width="100"/>
        <el-table-column label="开始时间" align="center" prop="startTime" width="150" >
          <template slot-scope="scope">
            <span>{{ parseTime(scope.row.startTime)}}</span>
          </template>
        </el-table-column>
        <el-table-column label="结束时间" align="center" prop="endTime" width="150">
          <template slot-scope="scope">
            <span>{{ parseTime(scope.row.endTime) }}</span>
          </template>
        </el-table-column>
        <el-table-column label="时长" align="center" prop="duration" width="80" >
          <template slot-scope="scope">
            <span>{{ parseTime(scope.row.duration, '{h}:{i}:{s}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="视频链接" align="center" prop="videoUrl">
          <template slot-scope="scope">
            <el-link type="primary" :href="scope.row.videoUrl" target="_blank">{{ scope.row.videoUrl }}</el-link>
          </template>
        </el-table-column>
        
      </el-table>           

      <pagination
        v-show="totalRecord>0"
        :total="totalRecord"
        :page.sync="queryRecordParams.pageNum"
        :limit.sync="queryRecordParams.pageSize"
        @pagination="getRecordList"
      />

       <div slot="footer" class="dialog-footer">
         <el-button type="primary" @click="submitRecord">确 定</el-button>
         <el-button @click="cancelRecord">取 消</el-button>
       </div>
    </el-dialog>

    <!-- 选择时间对话框 -->
    <el-dialog v-dialogDrag :visible.sync="openTime" width="950px" title="选择时间记录" append-to-body>
      <div>
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAddTimeRecord">新增</el-button>
      </div>
      
      <el-table 
        :data="timeList"
        >
        <el-table-column label="序号" align="center" type="index" />
        <el-table-column label="开始时间" align="center" prop="startTime">
          <template slot-scope="scope">
            <el-date-picker v-model="scope.row.startTime" type="datetime" placeholder="选择开始时间" :picker-options="pickerTimeRecordOptions"> </el-date-picker>
          </template>
        </el-table-column>
        <el-table-column label="结束时间" align="center" prop="endTime" >
          <template slot-scope="scope">
            <el-date-picker v-model="scope.row.endTime" type="datetime" placeholder="选择结束时间" @change="timeEndTimeChange(scope.$index, scope.row.endTime)" :picker-options="pickerTimeRecordOptions"> </el-date-picker>
          </template>
        </el-table-column>
        <el-table-column label="时长" align="center" prop="duration" width="80" >
          <template slot-scope="scope">
            <span>{{ parseTime(scope.row.duration, '{h}:{i}:{s}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="80" >
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="text"
              icon="el-icon-delete"
              @click="handleDeleteTimeRecord(scope.$index)"
            >删除</el-button>
          </template>
        </el-table-column>
      </el-table>           

      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitTimeRecord">确 定</el-button>
        <el-button @click="cancelTimeRecord">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 任务描述对话框 -->
    <el-dialog v-dialogDrag :visible.sync="openDescription" width="950px" title="任务描述" append-to-body>
      <el-table 
        v-loading="loadingDescription" 
        :data="descriptionList"
        >
        <el-table-column label="序号" align="center" type="index" />
        <el-table-column label="任务名称" align="center" prop="appName"/>
        <el-table-column label="任务提交时间" align="center" prop="submitTime" width="150">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.submitTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
        <el-table-column label="任务说明" align="center" prop="description"/>
      </el-table>           

      <div slot="footer" class="dialog-footer">
        <el-button @click="cancelDescription">取 消</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
import { listDevPageTask, getTask, distribute, listAppNames, listStaffNames, listProjectNames, 
  updateTask, listDistributeNames} from "@/api/work/task";
import { listStaff, listSalaryNames, listStaffByParent } from "@/api/work/staff";
import { listProject, getProject } from "@/api/work/project";
import { listVideoRecord, checkVideoAddress} from "@/api/work/videoRecord";
import Treeselect from "@riophae/vue-treeselect";
import "@riophae/vue-treeselect/dist/vue-treeselect.css";
import store from "@/store";
import {checkRole} from "@/utils/permission";
import { getToken } from "@/utils/auth";

export default {
  name: "TaskInquire",
  dicts: ['wh_participation_methods','wh_claim_status','wh_deploy_url', 'wh_pro_type', 'wh_full_release', 'wh_branch_type', 'wh_claim_type'],
  components: { Treeselect },
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
      // 任务表格数据
      taskList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 是否展开，默认全部展开
      isExpandAll: true,
      // 重新渲染表格状态
      refreshTable: true,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 100,
        status: null,
        createByName: null,
        createParticipationMethods: null,
        //被分配人
        staffNoQuery: null,
        participationMethods: 3,
        projectId: null,
        projectType: null,
        //领薪人
        salaryStaffName: null,
        distributeMonth: null,
        month: null,
        releaseFlag: null,
        branchName: null,
        columnOrder: 0,
        // orderByColumn: 'spendTime desc, submitTime',
        // isAsc: 'descending',
      },
      // 表单参数
      form: {
        distributionTime: null,
        distributionList:[],
        claimDetailList: [], 
        month: null
      },
      // 表单校验
      rules: {
        month: [
          { required: true, message: "所属年月不能为空", trigger: "change" }
        ],
        uploadStatus: [
          { required: true, message: "代码上传状态不能为空", trigger: "change" }
        ],
        completeInstructions: [
          { required: true, message: "完成说明不能为空", trigger: "blur" }
        ],
        fileUrl: [
          { required: true, message: "交付文件地址不能为空", trigger: "blur" }
        ],
        tagNo: [
          { required: true, message: "tag标签编号不能为空", trigger: "blur" }
        ],
        confirmStatus: [
          { required: true, message: "完成待确认项不能为空", trigger: "change" }
        ],
        workingHours: [
          { required: true, message: "工时不能为空", trigger: "blur" }
        ],
      },
      //员工树
      staffTreeOptions:[],
      staffId: null,
      //领薪人员
      salaryStaffOptions:[],
      // 弹出层标题
      detailTitle: "",
      // 是否显示弹出层
      openDetail: false,
      detailForm:{},
      singleSelectRow:{},
      pickerOptions:{
        disabledDate(time) {
          return time.getTime() < Date.now() - 8.64e7;  //如果没有后面的-8.64e7就是不可以选择今天的 
        }
      },
      appNameOptions:[],
      staffNameOptions:[],
      salaryNameOptions:[],
      //是否开发人员
      isDevlop: false,
      // 是否员工标识
      staffFlag: null,
      projectOptions: [],
      singleProject: {},
      maxThreshold: null,
      staffDisabled: false,
      // 发布模板参数
      upload: {
        // 弹出层标题
        title: "",
        // 是否禁用上传
        isUploading: false,
        // 设置上传的请求头部
        headers: { Authorization: "Bearer " + getToken() },
        // 上传的地址
        url: process.env.VUE_APP_BASE_API + "/common/uploadMinio",
      },
      attentionInfo: '',
      templateUrl: '',
      videoAddress: '',
      showAdjust: false,
      openAdjust: false,
      adjustForm:{},
      // 表单校验
      adjustRules: {
        releaseFlag: [
          { required: true, message: "全量发布不能为空", trigger: "change" }
        ],
      },
      singleAdjust: true,
      activeNames: ['1'],
      addActiveNames: ['1'],
      claimDetailRow: {},
      openRecord: false,
      loadingRecord: true,
      // 总条数
      totalRecord: 0,
      // 视频记录表格数据
      recordList: [],
      // 查询记录参数
      queryRecordParams: {
        pageNum: 1,
        pageSize: 30,
        claimStatus: 0,
        userName: store.getters.name,
        timeLimit: 1,
        orderByColumn: 'startTime',
        isAsc: 'descending',
      },
      selectClaimIndex: 0,
      claimTypeOptions: [],
      claimDetailItemList: [],
      selectRecordDetailRows: [],

      openTime:false,
      timeList: [],
      pickerTimeRecordOptions:{},
      // 全局已选时间记录
      existClaimItemList: [],

      participationMethodsOptions:[],
      distributeNameOptions: [],
      totalWorkingHours: 0.0,

      openDescription: false,
      descriptionList: [],
      loadingDescription: false,
    };
  },
  created() {
    this.getStaffList();
    this.getProjectList();
    this.getAttention();
    this.getTemplate();
    this.getVideoAddress();
    this.initParticipationMethods();
    this.initDistributeNames();
  },

  watch:{
    
    //监听被分配人
    'queryParams.staffNoQuery'(val){
      if(!!val){
        this.watchStaffNo(val);
      }else{
        this.queryParams.projectId = null;
        this.queryParams.salaryStaffName = null;
        this.salaryNameOptions = [];
        if(this.staffFlag == 1){
          this.projectOptions = [];
        } else {
          this.getProjectList();
        }
      }
    },

  },
  methods: {
    checkRole,

     /** 初始化参与方式 */
     initParticipationMethods(){
      this.getDicts("wh_participation_methods").then(response => {
        let methods = response.data;
        // 领薪人员不显示
        this.participationMethodsOptions = methods.filter(method =>method.dictValue != 4);
      })
    },

     /** 初始化分配人名称列表 */
     initDistributeNames() {
      let param ={}
      listDistributeNames(param).then(response => {
        this.distributeNameOptions = response.data;
      });
    },

    initTimeRecordDate(date){
      this.pickerTimeRecordOptions = {
        disabledDate(time) {
          return time.getTime() < new Date(date).getTime() -8.64e7;  //如果没有后面的-8.64e7就是不可以选择当天的 
        }
      }
    },

    getAttention(){
      this.getConfigKey("sys.release.attention").then(response => {
        this.attentionInfo = response.msg;
      });
    },

    getTemplate(){
      this.getConfigKey("sys.release.template").then(response => {
        this.templateUrl = response.msg;
      });
    },

    /** 视频录制地址 */
    getVideoAddress(){
      this.getConfigKey("sys.video.address").then(response => {
        this.videoAddress = response.msg;
      });
    },

    initClaimType(){
      this.getDicts("wh_claim_type").then(response => {
        let claimTypes = response.data;
        if(!this.videoAddress || this.videoAddress.trim().length == 0){
          // 桌面作业不显示
          this.claimTypeOptions = claimTypes.filter(claimType =>claimType.dictValue != 1);
        }else{
          this.claimTypeOptions = claimTypes;
        }
      })
    },

    /** 查询当前登录人 */
    getStaffList(){
      let param = {
        staffNo : store.getters.name,
        delFlag : 0
      }
      listStaff(param).then(response => {
        this.staffList = response.data;
        //判断当前登录人
        if(this.staffList.length > 0){ //组队人员
          this.staffFlag = 1;
          // this.staffDisabled = true;
          let staff = this.staffList.find(item => item.participationMethods == 3);
          if(!!staff){
            this.isDevlop = true;
            this.staffId = staff.id;
             // 综合查询角色
            if(!checkRole(['check'])){
              this.queryParams.staffId = staff.id;
              this.queryParams.staffNoQuery = store.getters.name;
              this.getStaffNames(store.getters.name);
            }else{
              this.staffFlag = 0;
              this.staffDisabled = false;
              this.getStaffNames();
            }
          }
        }else{
          this.staffFlag = 0;
          this.staffDisabled = false;
          this.getStaffNames();
        }
        this.getList();
      });
    },

    /** 查询任务列表 */
    getList() {
      this.loading = true;
      this.queryParams.staffNo = store.getters.name;
      this.queryParams.staffFlag = this.staffFlag;
      //查询全部
      listDevPageTask(this.queryParams).then(response => {
        this.taskList = response.rows;
        this.total = response.total;
        //计算总工时
        this.totalWorkingHours = this.taskList.reduce((sum,key)=>{
          return sum + key.workingHours;
        },0.0)
        this.loading = false;
      });
       
    },

    /** 表格排序 */
    sortChange(column){
      this.queryParams.orderByColumn = column.prop;
      this.queryParams.isAsc = column.order;
      this.queryParams.columnOrder = 1;
      this.getList();
    },

     /** 查询领薪人员下拉列表 */
    getSalaryStaffList(staffId){
      let salaryParam = {
        parentId: staffId
      }
      listStaffByParent(salaryParam).then(response => {
        this.salaryStaffOptions = response.data;
      });
    },

    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.activeNames = ['1'];
      this.addActiveNames = ['1'];
      this.form = {
        taskId: null,
        submitTime: null,
        workingHours: 0.0,
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
      if(this.staffFlag == 1){
        this.queryParams.staffNoQuery = store.getters.name;
      }
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length !== 1
      this.singleSelectRow = selection[0];
      if(!!this.singleSelectRow ){
        this.singleAdjust = this.single || this.singleSelectRow.releaseFlag !== 1 || this.singleSelectRow.createBy !== store.getters.name 
          || this.singleSelectRow.status !== 1 || this.singleSelectRow.projectType !== 1;
      }else{
        this.singleAdjust = true
      }
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
    /** 领薪分配按钮操作 */
    async handleAdd() {
      this.existClaimItemList = [];
      if(this.singleSelectRow.status == 1 || this.singleSelectRow.status == 1){
        this.$message.error('任务工时已分配，请勿重复操作')
        return;
      }
      if(!this.isDevlop){
        this.$message.error('非开发人员，无法操作领薪分配功能')
        return;
      }
      // 判断登录人是否和被分配人相同
      if(this.staffId != this.singleSelectRow.staffId){
        this.$message.error('不是分配给本人任务，无法操作领薪分配功能')
        return;
      }
      this.reset();
      this.open = true;
      this.title = "工时申报";
      this.initClaimType();
      // 获取详情
      const id = this.singleSelectRow.id;
      await getTask(id).then(response => {
        this.form = response.data;
        // 遍历获取全局
        this.form.claimDetailList.forEach(item => {
          this.existClaimItemList.push(...item.claimDetailItemList);
        })
        
      });

      // this.form = deepClone(this.singleSelectRow);
      this.form.submitTime = new Date();
      //初始tag标签编号
      if(this.form.projectType == 1){
        let tagNoStr = this.parseTime(new Date(), '{y}{m}{d}{h}{i}').slice(2) +'_' + this.form.branchName;
        if(this.form.releaseFlag == 1){
          tagNoStr = this.form.releaseTag + '_all'; 
        }
        this.$set(this.form, 'tagNo', tagNoStr);
      }else {
        this.$set(this.form, 'tagNo', '空');
      }
      
      //初始月份
      this.$set(this.form, 'month', this.parseTime(new Date(), '{y}-{m}'))
      let spendTime = this.getDaysBetween(this.singleSelectRow.distributionTime, this.form.submitTime);
      this.form.spendTime = !this.singleSelectRow.spendTime ? spendTime : this.singleSelectRow.spendTime;
      this.getSalaryStaffList(this.singleSelectRow.staffId);
      if(this.form.status == 0){
        this.form.distributionList = [];
        this.form.claimDetailList = [];
      }
      // 工时最大值
      this.getProjectDetail(this.singleSelectRow.projectId);
      
    },

    // 获取项目详情
    getProjectDetail(projectId){
      getProject(projectId).then(response=>{
        this.singleProject = response.data;
        //项目类型
        this.maxThreshold = this.singleProject.workHoursThreshold;
        // this.$set(this.form, 'projectType', this.singleProject.projectType);
      })
    },
     
     /** 详情按钮操作 */
    handleDetail() {
      const id = this.singleSelectRow.id;
      getTask(id).then(response => {
        this.detailForm = response.data;
        if(!!this.queryParams.salaryStaffName){
          this.detailForm.distributionList = this.detailForm.distributionList.filter(item=>item.staffName == this.queryParams.salaryStaffName);
        }
        this.openDetail = true;
        this.detailTitle = "工时详情";
      });
    },
     // 取消详情
     cancelDetail() {
      this.openDetail = false;
      this.reset();
    },

    /** 暂存按钮 */
    tempSaveForm() {
      this.form.status = 10;//暂存

      // 判断是否开启详情配置
      if(this.form.configStatus == 1){
        if( this.form.claimDetailList.length > 0){
          try {
            this.form.claimDetailList.forEach(item=>{
            if(!item.claimType){
              throw new Error("工时类型不能为空");
            }
            if(!item.workingHours){
              throw new Error("申报时长不能为空");
            }
          
          })
          } catch (error) {
            this.$message.error(error.message);
            return;
          }
        }
      }
      
      distribute(this.form).then(response => {
        this.$modal.msgSuccess("暂存成功");
        this.open = false;
        this.getList();
      });
      
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.form.status = 1;//已申报
          let totalHours = 0;
          // 代码必须提交才能保存
          if(this.form.uploadStatus == 0){
            this.$message.error('请确认已完成本次工时任务，才能进行申报')
              return;
          }

          // 判断是否开启详情配置
          if(this.form.configStatus == 1){
            if(!this.form.claimDetailList || this.form.claimDetailList.length == 0){
              this.$message.error('工时申报明细不能为空，请逐条进行申报')
              return;
            }
            try {
              this.form.claimDetailList.forEach(item=>{
              if(!item.claimType){
                throw new Error("工时类型不能为空");
              }
              if(!item.workingHours){
                throw new Error("申报时长不能为空");
              }
              if(!item.lockStatus){
                throw new Error("申报条目尚未锁定");
              }
             
            })
            } catch (error) {
              this.$message.error(error.message);
              return;
            }
          }

          if(this.form.humanCompanyRelation == 2){
            if(!this.form.distributionList || this.form.distributionList.length == 0){
              this.$message.error('工时分配明细不能为空，请分配领薪人员')
              return;
            }
            try {
              this.form.distributionList.forEach(item=>{
              if(!item.staffId){
                throw new Error("领薪人员不能为空");
              }
              if(!item.workingHours){
                throw new Error("领薪人员工时不能为空");
              }
              item.taskId = this.form.id;
              item.taskNo = this.form.taskNo;
              item.taskName = this.form.description;
              //员工名称
              let salary = this.salaryStaffOptions.find(s=>s.id == item.staffId);
              item.staffName = salary.staffName;
              item.staffNo = salary.staffNo;
              totalHours = totalHours + item.workingHours;
            })
            } catch (error) {
              this.$message.error(error.message);
              return;
            }
            
            this.form.paidHours = totalHours;
          }else{
            totalHours = this.form.workingHours;
          }
          
          //判断和大小
          if(this.form.workingHours < totalHours){
            this.$message.error('分配工时总和不能大于原工时')
            return;
          }else if(this.form.workingHours>totalHours){
            let that = this;
            this.$modal.confirm('分配工时总和小于原工时，是否确认分配').then(function() {
              distribute(that.form);
            }).then(() => {
              this.getList();
              this.$modal.msgSuccess("分配成功");
              this.open = false;
            }).catch((error) => {
              console.log(error)
            });
          }else{
            distribute(this.form).then(response => {
            this.$modal.msgSuccess("分配成功");
            this.open = false;
            this.getList();
          });
          }
        
        }
      });
    },

     /** 工时申报详情添加 */
     handleAddClaimDetail(){
      let detail = {
        claimType: null,
        startTime: null,
        endTime: null,
        workingHours: 0.0,
        lockStatus: 0,
        claimDetailItemList: [],
      }
      this.form.claimDetailList.push(detail);
      this.initClaimType();
    },

    /** 工时申报详情删除 */
    handleDeleteClaimDetail(index, rows){
      let oldValue = rows[index].workingHours;
      this.$modal.confirm('删除任何一条记录，工时分配明细都会同步删除，需要重新添加，是否继续？').then(function() {
        rows.splice(index,1);
      }).then(() => {
        this.detailHoursChange(0, oldValue);
        this.form.distributionList = [];
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },

    /** 工时申报详情锁定 */
    handleLockClaimDetail(index, rows){
      //锁定判断是否为空
      if(!rows[index].claimType){
        this.$message.error('工时类型能为空，请先选择');
        return;
      }
      if(!rows[index].workingHours){
        this.$message.error('申报时长不能为空');
        return;
      }
      //判断列表下是否全锁定
      let lockStatusList = rows[index].claimDetailItemList.filter(item=>item.lockStatus==0);
      if(lockStatusList.length > 0){
        this.$message.error('申报明细列表存在未锁定数据');
        return;
      }
      rows[index].lockStatus = 1;
      rows[index].lockTime = new Date();
      this.$set(this.form.claimDetailList, index, rows[index]);
    },

    /** 详情结束时间调整 */
    detailEndTimeChange(value){
      //判断开始时间是否为空
      if (!this.claimDetailRow.startTime) {
        this.$message.error('开始时间不能为空，请先选择');
        this.claimDetailRow.endTime = null;
        return;
      }
      let oldValue = this.claimDetailRow.workingHours;
      // 计算当前行的工时数
      let start = this.claimDetailRow.startTime;
      let timeDiffInMs = Math.abs(value - this.claimDetailRow.startTime); // 获取时间差（单位为毫秒）
      this.claimDetailRow.workingHours = (timeDiffInMs / (1000 * 3600)).toFixed(1); // 将毫秒转换成小时并向
      this.detailHoursChange(this.claimDetailRow.workingHours, oldValue);
    },

    handleClaimDetailClick(row, column, event){
      this.claimDetailRow = row;
    },

    /** 详情工时数调整 */
    detailHoursChange(currentValue, oldValue){
      // 计算总工时数
      // 遍历计算准确
      this.form.workingHours = Number(this.form.workingHours - oldValue) + Number(currentValue);
    },

    /** 选择记录 */
    handleSelectRecord(index){
      this.openRecord = true;
      this.selectRecordDetailRows = [];
      // 调用接口判断地址是否正确
      checkVideoAddress().then(response => {
        if(response.code == 200){
          this.getRecordList();
        }
      }).catch(error => {
        console.log(error)
      });
      this.selectClaimIndex = index;
    },

    /** 记录分页列表 */
    getRecordList(){
      this.loadingRecord = true;
      listVideoRecord(this.queryRecordParams).then(response => {
        this.recordList = response.rows;
        this.totalRecord = response.total;
        this.loadingRecord = false;
      });
    },

     // 多选框选中数据
     handleSelectionRecordDetailChange(selection) {
      this.selectRecordDetailRows = [];
      selection.forEach(item=>{
        let existArray = this.selectRecordDetailRows.filter(row=>row.id == item.id);
        if(!existArray || existArray.length == 0){
          let detailRow = Object.assign({lockStatus: 0, recordDetailId: item.id}, item);
          this.selectRecordDetailRows.push(detailRow);
        }
      })

    },

    /** 工时申报详情条目删除 */
    handleDeleteClaimDetailItem(index, formIndex, rows){
      // 删除条目
      rows.splice(index,1);
      if(rows.length == 0){
        // 更新详情
        let oldValue = this.form.claimDetailList[formIndex].workingHours;
        this.form.claimDetailList[formIndex].claimDetailItemList = [];
        // 更新值
        this.form.claimDetailList[formIndex].recordId = null;
        this.form.claimDetailList[formIndex].totalHours = 0.0; 
        this.form.claimDetailList[formIndex].workingHours = 0.0; 
        this.detailHoursChange(0, oldValue);
      }else{
        let durationList = rows.map(item =>item.duration);
        let totalHours = 0;
        durationList.forEach(item =>{
          let parts = this.parseTime(item, '{h}:{i}:{s}').split(':');
          let hours = parseInt(parts[0], 10);
          let minutes = parseInt(parts[1], 10);
          let seconds = parseInt(parts[2], 10);
          let workingHours = hours*3600 + minutes*60 + seconds;
          totalHours = totalHours + workingHours;
        });
        
        let oldValue = this.form.claimDetailList[formIndex].workingHours;
        this.form.claimDetailList[formIndex].claimDetailItemList = rows;
        // 更新值
        this.form.claimDetailList[formIndex].recordId = rows[0].recordId;
        let workingHours = (totalHours/3600).toFixed(1) == 0.0 ? 0.1 : (totalHours/3600).toFixed(1);
        // 累计时长
        this.form.claimDetailList[formIndex].totalHours = workingHours; 
        // 申报工时
        this.form.claimDetailList[formIndex].workingHours = workingHours; 
        this.detailHoursChange(workingHours, oldValue);
      }
    },

    /** 工时申报详情条目锁定 */
    handleLockClaimDetailItem(index, formIndex, rows){
      // 锁定条目
      rows[index].lockStatus = 1;
      rows[index].lockTime = new Date();
      this.$set(this.form.claimDetailList[formIndex], 'claimDetailItemList', rows);
    },

    // 取消记录确认按钮
    cancelRecord() {
      this.openRecord = false;
      this.resetAdjust();
    },

    /** 提交按钮 */
    submitRecord() {
      if(!this.selectRecordDetailRows || this.selectRecordDetailRows.length == 0 ){
        this.$message.error('记录不能为空，请选择');
        return;
      }

      try {
        this.selectRecordDetailRows.forEach(item=>{
          item.id = null;
          // 全局校验时间段是否重复
          let existTimeArray = this.existClaimItemList.filter(row=>new Date(row.startTime).getTime() <= new Date(item.endTime).getTime() && new Date(row.endTime).getTime() >= new Date(item.startTime).getTime());
          if(existTimeArray.length == 0){
            if(!this.form.claimDetailList[this.selectClaimIndex].claimDetailItemList || this.form.claimDetailList[this.selectClaimIndex].claimDetailItemList.length == 0){
              this.form.claimDetailList[this.selectClaimIndex].claimDetailItemList.push(item);
            }else{
              let existItemArray = this.form.claimDetailList[this.selectClaimIndex].claimDetailItemList.filter(row=>row.videoUrl == item.videoUrl);
              if(!existItemArray || existItemArray.length == 0){
                this.form.claimDetailList[this.selectClaimIndex].claimDetailItemList.push(item);
              }else{
                throw new Error("视频记录中存在已选择项，请勿重复选择");
              }
            }
          }else{
            throw new Error("工时申报明细中存在重叠时长，请重新选择");
          }
        })
      } catch (error) {
        this.$message.error(error.message);
        return;
      }

      let selectRecordDetailRows = this.form.claimDetailList[this.selectClaimIndex].claimDetailItemList;
      let selectRecordRow = selectRecordDetailRows[0];
      let durationList = selectRecordDetailRows.map(item =>item.duration);

      let totalHours = 0;
      durationList.forEach(item =>{
        let parts = this.parseTime(item, '{h}:{i}:{s}').split(':');
        let hours = parseInt(parts[0], 10);
        let minutes = parseInt(parts[1], 10);
        let seconds = parseInt(parts[2], 10);
        let workingHours = hours*3600 + minutes*60 + seconds;
        totalHours = totalHours + workingHours;
      });
      
      let oldValue = this.form.claimDetailList[this.selectClaimIndex].workingHours;
      this.form.claimDetailList[this.selectClaimIndex].recordId = selectRecordRow.recordId;
      // 申报工时
      let workingHours = (totalHours/3600).toFixed(1) == 0.0 ? 0.1 : (totalHours/3600).toFixed(1);
      // 累计时长
      this.form.claimDetailList[this.selectClaimIndex].totalHours = workingHours; 
      // 申报工时
      this.form.claimDetailList[this.selectClaimIndex].workingHours = workingHours; 

      this.detailHoursChange(workingHours, oldValue);
      this.openRecord = false;
    },

    /** 选择时间 */
    handleSelectTime(index){
      this.openTime = true;
      this.timeList = [];
      this.selectClaimIndex = index;
      this.initTimeRecordDate(this.form.distributionTime);
    },

     /** 工时申报详情添加 */
     handleAddTimeRecord(){
      let detail = {
        startTime: null,
        endTime: null,
        duration: null,
        lockStatus: 0,
      }
      this.timeList.push(detail);
    },

    /** 时间详情结束时间调整 */
    timeEndTimeChange(index, value){
      let totalHours = (value - this.timeList[index].startTime)/1000;
      // 超出24小时提醒
      if(totalHours > 24*60*60){
        this.$message.error('时长不能超出24小时，请重新选择');
        return;
      }
      // 计算时长
      let hourString= Math.floor(totalHours/3600).toString().padStart(2, '0');
      let minutesString= Math.floor((totalHours%3600)/60).toString().padStart(2, '0');
      let secondsString= Math.floor(((totalHours%3600)%60)).toString().padStart(2, '0');
      let totalDuration = hourString + ':' + minutesString + ':' + secondsString;
      const date = new Date();
      date.setHours(hourString, minutesString, secondsString, 0);
      this.timeList[index].duration = date;
    },

     /** 提交时间按钮 */
     submitTimeRecord() {
      
      if(this.timeList.length == 0 ){
        this.$message.error('数据不能为空，请添加一条');
        return;
      }

      try{
        this.timeList.forEach(item=>{
           // 全局校验时间段是否重复
          let existTimeArray = this.existClaimItemList.filter(row=>new Date(row.startTime).getTime() <= new Date(item.endTime).getTime() && new Date(row.endTime).getTime() >= new Date(item.startTime).getTime());
          if(existTimeArray.length == 0){
            if(!this.form.claimDetailList[this.selectClaimIndex].claimDetailItemList || this.form.claimDetailList[this.selectClaimIndex].claimDetailItemList.length == 0){
              this.form.claimDetailList[this.selectClaimIndex].claimDetailItemList.push(item);
            }else{
              let existItemArray = this.form.claimDetailList[this.selectClaimIndex].claimDetailItemList.filter(row=>new Date(row.startTime).getTime() <= new Date(item.endTime).getTime() && new Date(row.endTime).getTime() >= new Date(item.startTime).getTime());
              if(!existItemArray || existItemArray.length == 0){
                this.form.claimDetailList[this.selectClaimIndex].claimDetailItemList.push(item);
              }else{
                throw new Error("时间填报记录中存在重叠时长，请重新选择");
              }
            }
          }else{
            throw new Error("工时申报明细中存在重叠时长，请重新选择");
          }
        })
      } catch (error) {
        this.$message.error(error.message);
        return;
      }
      

      let selectRecordDetailRows = this.form.claimDetailList[this.selectClaimIndex].claimDetailItemList;
      let durationList = selectRecordDetailRows.map(item =>item.duration);

      let totalHours = 0;
      durationList.forEach(item =>{
        let parts = this.parseTime(item, '{h}:{i}:{s}').split(':');
        let hours = parseInt(parts[0], 10);
        let minutes = parseInt(parts[1], 10);
        let seconds = parseInt(parts[2], 10);
        let workingHours = hours*3600 + minutes*60 + seconds;
        totalHours = totalHours + workingHours;
      });
      
      let oldValue = this.form.claimDetailList[this.selectClaimIndex].workingHours;
      let workingHours = (totalHours/3600).toFixed(1) == 0.0 ? 0.1 : (totalHours/3600).toFixed(1);
      // 累计时长
      this.form.claimDetailList[this.selectClaimIndex].totalHours = workingHours; 
      // 申报工时
      this.form.claimDetailList[this.selectClaimIndex].workingHours = workingHours; 

      this.detailHoursChange(workingHours, oldValue);
      this.openTime = false;
    },

     /** 时间选择取消 */
    cancelTimeRecord(){
      this.openTime = false;
    },

     /** 时间选择删除 */
    handleDeleteTimeRecord(index){
      this.timeList.splice(index, 1);
    },
    
    /** 领薪人员不能重复选择*/
    selectSalaryChange(staffId){
      let that = this;
      let staffIds = that.form.distributionList.filter(item=>item.staffId == staffId);
      if(staffIds.length>1){
        this.$message.error('领薪人员不能重复选择')
        return;
      }
    },

    /** 领薪人员添加 */
    handleAddSalary(){
      let maxHour = this.form.workingHours;
      if(this.form.distributionList.length>0){
        this.form.distributionList.forEach(item=>{
          maxHour = maxHour - item.workingHours
        })
      }
      this.form.distributionList.push({workingHours:maxHour})
    },

     /** 领薪人员删除 */
     handleDeleteSalary(index,rows){
      rows.splice(index,1);
    },

    /** 计算天数差 */
    getDaysBetween(startString, endString){
      let  startDate = Date.parse(startString);
      let  endDate = Date.parse(endString);
      
      if (startDate>endDate){
          return 0;
      }
      if (startDate==endDate){
          return 1;
      }
      return  Math.ceil((endDate - startDate)/(1*24*60*60*1000));
    },

    /** 查询应用名称列表 */
    getAppList() {
      let param ={}
      listAppNames(param).then(response => {
        this.appNameOptions = response.data;
      });
    },

    /** 查询员工名称列表 */
    getStaffNames(staffNo) {
      let param ={}
      if(!!staffNo){
        param.staffNo = staffNo
      }

      listStaffNames(param).then(response => {
        this.staffNameOptions = response.data;
      });
    },

    /** 被分配人选择查询变化 */
    watchStaffNo(devStaffNo){
      if(!!devStaffNo){
        this.getProjectListByStaff(devStaffNo);
        this.getSalaryNames(devStaffNo);
      }
      
    },

    /** 查询领薪员工名称列表 */
    getSalaryNames(devStaffNo) {
      let param ={
        staffNo : devStaffNo
      }
      listSalaryNames(param).then(response => {
        this.salaryNameOptions = response.data;
      });
    },

    /** 查询项目列表 */
    getProjectList(){
      let param ={
        status : 1
      }
      listProject(param).then(response => {
        this.projectOptions = response.data;
      });
    },

    /** 查询项目列表 */
    getProjectListByStaff(staffNo){
      listProjectNames(staffNo).then(response => {
        this.projectOptions = response.data;
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

    // 文件上传中处理
    handleFileUploadProgress(event, file, fileList) {
      this.upload.isUploading = true;
    },
    // 文件上传成功处理
    handleFileSuccess(response, file, fileList) {
      this.upload.isUploading = false;
      this.form.releaseAttachment = response.url;
    },

    /** 调整按钮操作 */
    handleAdjust() {
      this.openAdjust = true;
      this.adjustForm = {
        id : this.singleSelectRow.id,
        releaseFlag : 2,
      }
    },

    // 取消调整确认按钮
    cancelAdjust() {
      this.openAdjust = false;
      this.resetAdjust();
    },

    
    // 确认表单重置
    resetAdjust() {
      this.adjustForm = {       
        releaseFlag: null,
      };
      this.resetForm("adjustForm");
    },
    /** 提交按钮 */
    submitAdjust() {
      this.$refs["adjustForm"].validate(valid => {
        if (valid) {
          updateTask(this.adjustForm).then(response => {
            this.$modal.msgSuccess("修改成功");
            this.openAdjust = false;
            this.getList();
          });
        }
      });
    },


    /** 描述按钮操作 */
    handleDescription() {
      this.openDescription = true;
      this.loadingDescription = true;
      this.queryParams.staffNo = store.getters.name;
      this.queryParams.staffFlag = this.staffFlag;
      this.queryParams.createBy = store.getters.name;
      this.queryParams.pageSize = 1000;
      //查询全部
      listDevPageTask(this.queryParams).then(response => {
        this.descriptionList = response.rows;
        this.loadingDescription = false;
      });
    },

     // 取消描述按钮
     cancelDescription() {
      this.openDescription = false;
    },

   

  }
};
</script>
