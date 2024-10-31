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
 * 工时申报明细对象 wh_claim_detail
 * 
 * @author wxd
 * @date 2024-03-04
 */
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class WhClaimDetail extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键id */
    private Long id;

    /** 任务id */
    @Excel(name = "任务id")
    private Long taskId;

    /** 工时类型 1桌面作业 2会议交流 3现场作业 4其他  */
    @Excel(name = "工时类型 1桌面作业 2会议交流 3现场作业 4其他 ")
    private Long claimType;

    /** 工时数 */
    @Excel(name = "工时数")
    private BigDecimal workingHours;

    /**
     * 说明
     */
    private String description;

    /**
     * 累计时长
     */
    private BigDecimal totalHours;

    /**
     * 锁定时间
     */
    private Date lockTime;

    /**
     * 锁定状态 0 否 1 是
     */
    private Integer lockStatus;

    /**
     * 暂存状态 0 否 1 是
     */
    private Integer temporaryStatus;

    /** 视频记录id */
    private Long recordId;

    /** 详情条目集合 */
    private List<WhClaimDetailItem> claimDetailItemList;

}
