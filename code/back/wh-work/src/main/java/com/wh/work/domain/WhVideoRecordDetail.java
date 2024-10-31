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
 * 工时视频记录详情对象 wh_video_record_detail
 * 
 * @author wh
 * @date 2024-03-16
 */
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class WhVideoRecordDetail extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 记录ID */
    @Excel(name = "记录ID")
    private Long recordId;

    /** 同步记录ID */
    @Excel(name = "同步记录ID")
    private Long recordingId;

    /** 同步池ID */
    @Excel(name = "同步池ID")
    private Long sessionId;

    /** 片段ID */
    @Excel(name = "片段ID")
    private Long segmentId;

    /** 屏幕ID */
    @Excel(name = "屏幕ID")
    private Long screenId;

    /** 开始时间 */
    @Excel(name = "开始时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date startTime;

    /** 截止时间 */
    @Excel(name = "截止时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date endTime;

    /** 持续时长 */
    @Excel(name = "持续时长", width = 30, dateFormat = "yyyy-MM-dd")
    private Date duration;

    /** 视频链接地址 */
    @Excel(name = "视频链接地址")
    private String videoUrl;

    /** 申报状态 0 未申报 1已申报 */
    @Excel(name = "申报状态 0 未申报 1已申报")
    private Integer claimStatus;

    /**
     * 时长限制
     */
    private Integer timeLimit;

    /** 同步时间 */
    @Excel(name = "同步时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date syncTime;

    /** 删除标志（0代表存在 1代表删除） */
    private String delFlag;

    private List<Long> recordIds;

}
