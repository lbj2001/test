package com.wh.work.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.wh.common.annotation.Excel;
import com.wh.common.core.domain.BaseEntity;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 任务分配 wh_task_distribution
 * 
 * @author wxd
 * @date 2023-05-17
 */
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class WhTaskDistribution extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 任务id */
    private Long taskId;

    /** 薪酬id */
    private Long salaryId;

    /** 员工id */
    private Long staffId;

    /** 员工编号 */
    private String staffNo;

    /** 任务编号 */
    @Excel(name = "任务编号")
    private String taskNo;

    /** 任务名称 */
    @Excel(name = "任务名称")
    private String taskName;

    /** 员工名称 */
    @Excel(name = "员工名称")
    private String staffName;

    /** 工时 */
    @Excel(name = "工时")
    private BigDecimal workingHours;

    /** 工时单价 */
    private BigDecimal workingPrice;

    /** 小计 */
    private BigDecimal subTotal;

    /** 分配时间 */
    private Date distributeTime;

    /** 分配比例（%） */
    private BigDecimal distributeRatio;

    /** 应用名称 */
    private String appName;

    /** 开发人员 */
    private String developName;

    /** 链接地址 */
    private String linkUrl;

}
