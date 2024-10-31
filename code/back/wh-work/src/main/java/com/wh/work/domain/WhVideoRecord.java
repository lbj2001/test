package com.wh.work.domain;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import com.wh.common.annotation.Excel;
import com.wh.common.core.domain.BaseEntity;

/**
 * 工时视频记录对象 wh_video_record
 * 
 * @author wxd
 * @date 2024-03-09
 */
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class WhVideoRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 记录ID（同步） */
    @Excel(name = "池ID")
    private Long sessionId;

    /** 用户名（账号） */
    @Excel(name = "用户名")
    private String userName;

    /** 开始时间 */
    @Excel(name = "开始时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date startTime;

    /** 截止时间 */
    @Excel(name = "截止时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date endTime;

    /** 持续时长 */
    @Excel(name = "持续时长", width = 30, dateFormat = "yyyy-MM-dd")
    private Date duration;

    /** 视频分段数 */
    @Excel(name = "视频记录数")
    private Integer totalRecordings;

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

    List<WhVideoRecordDetail> recordDetailList;

}
