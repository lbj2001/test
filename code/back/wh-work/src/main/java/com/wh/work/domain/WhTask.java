package com.wh.work.domain;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.wh.common.annotation.Excel;
import com.wh.common.core.domain.BaseEntity;

/**
 * 任务对象 wh_task
 * 
 * @author wxd
 * @date 2023-05-17
 */
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class WhTask extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 父级ID */
    private Long parentId;

    /** 项目ID */
    private Long projectId;

    /** 主项目名称 */
    private String mainProjectName;

    /** 子项目名称 */
    private String projectName;

    /** 项目来源 */
    private Integer projectSource;

    /** 项目类型 */
    private Integer projectType;

    /** 任务编号 */
    @Excel(name = "任务编号")
    private String taskNo;

    /** 父级任务编号 */
    private String parentTaskNo;

    /** 任务名称 */
    @Excel(name = "任务名称")
    private String taskName;

    /** 应用名称 */
    @Excel(name = "应用名称")
    private String appName;

    /** 任务分配时间 */
    @Excel(name = "任务分配时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date distributionTime;

    /** 员工ID */
    private Long staffId;

    /** 员工编号 */
    private String staffNo;

    /** 员工编号 */
    private String staffNoQuery;

    /** 员工名称 */
    private String staffName;

    /** 员工参与方式 */
    private Integer participationMethods;

    /** 任务说明 */
    private String description;

    /** 任务链接地址 */
    private String linkUrl;

    /** 任务链接二维码 */
    private String qrCode;

    List<Long> staffIds;

    /** 任务提交时间 */
    private Date submitTime;

    /** 耗时 */
    private Integer spendTime;

    /** 申报工时 */
    private BigDecimal workingHours;

    /** 领薪工时 */
    private BigDecimal paidHours;

    /** 领薪工时子级 */
    private BigDecimal subPaidHours;

    /** 所属年月 */
    private String month;

    /** 标签编号 */
    private String tagNo;

    /** 分支 */
    private String branchName;

    /** 内部分支 */
    private String innerBranch;

    /** 发布类型 0 增量 1 全量 2 全量失败 3 全量成功 */
    private Integer releaseFlag;

    /** 发布标签 */
    private String releaseTag;

    /** 发布附件 */
    private String releaseAttachment;

    /** 部署路径 */
    private Integer deployUrl;

    /** 交付文件地址 */
    private String fileUrl;

    /** 代码上传状态 0 未上传 1 已上传 */
    private Integer uploadStatus;

    /** 完成说明 */
    private String completeInstructions;

    /** 是否分配完成 0 否 1 是 */
    private String isCompleted;

    /** 任务分配阶段 （1 无需分配 2 等待分配 3 正在分配 4 分配完成）*/
    private Integer stage;

    /** 任务状态 0 未申报 1 已申报 9 超时关闭*/
    private Integer status;

    /** 周期类型（1 单次 2 每日 3 每月） */
    private Integer cycleType;

    /** 任务下发状态 0 暂存待发 1 完成下发*/
    private Integer distributeStatus;

    /** 分配人 */
    private String createByName;

    /** 分配人参与方式 */
    private Integer createParticipationMethods;

    /** 删除标志（0代表存在 1代表删除） */
    private String delFlag;

    /** 领薪人名称 */
    private String salaryStaffName;

    /**
     * 工时申报明细
     */
    private List<WhClaimDetail> claimDetailList;

    /**
     * 工时分配明细
     */
    private List<WhTaskDistribution> distributionList;

    /** 分配年月 */
    private String distributeMonth;

    /** 人司关系*/
    private Integer humanCompanyRelation;

    /** 工时详细配置开关 0 关闭 1 打开*/
    private Integer configStatus;

    /** 是否员工标识 0 否 1是*/
    private Integer staffFlag;

    /** 是否列排序标识 0 否 1是*/
    private Integer columnOrder;

    /** 下级员工编号 **/
    List<String> staffNos;
}
