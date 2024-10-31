package com.wh.work.domain.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import java.util.Date;

/**
 * 任务对象 wh_task
 * 
 * @author wxd
 * @date 2023-05-17
 */
@Data
@EqualsAndHashCode
@ToString(callSuper = true)
public class WhVideoDetailSyncVO
{
    private static final long serialVersionUID = 1L;

    /** 主键id */
    private Integer id;

    /** 主键id */
    private Integer sessionID;

    /** 主键id */
    private Integer segmentID;

    /** 主键id */
    private Integer screenID;

    /** 开始时间 */
    private Date startTime;

    /** 结束时间 */
    private Date endTime;

    /** 持续时间 */
    private Date duration;

}
