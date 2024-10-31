package com.wh.work.domain;

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
 * 工时申报明细条目对象 wh_claim_detail_item
 * 
 * @author wxd
 * @date 2024-03-16
 */
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class WhClaimDetailItem extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键id */
    private Long id;

    /** 申报明细id */
    @Excel(name = "申报明细id")
    private Long claimId;

    /** 视频名称（链接） */
    @Excel(name = "视频名称", readConverterExp = "链=接")
    private String videoUrl;

    /** 开始时间 */
    @Excel(name = "开始时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date startTime;

    /** 截止时间 */
    @Excel(name = "截止时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date endTime;

    /** 持续时长 */
    @Excel(name = "持续时长", width = 30, dateFormat = "yyyy-MM-dd")
    private Date duration;

    /**
     * 锁定时间
     */
    private Date lockTime;

    /**
     * 锁定状态 0 否 1 是
     */
    private Integer lockStatus;


    /** 删除标志（0代表存在 1代表删除） */
    private String delFlag;

    /** 视频记录详情id */
    private Long recordDetailId;

    /** 申明明细id集合 */
    private List<Long> claimIds;

    /** 视频记录id */
    private Long recordId;

}
