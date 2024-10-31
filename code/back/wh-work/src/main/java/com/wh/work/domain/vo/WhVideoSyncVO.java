package com.wh.work.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

/**
 * 任务对象 wh_task
 * 
 * @author wxd
 * @date 2023-05-17
 */
@Data
@EqualsAndHashCode
@ToString(callSuper = true)
public class WhVideoSyncVO
{
    private static final long serialVersionUID = 1L;

    /** 主键id */
    private Integer id;

    /** 用户名 */
    private String userName;

    /** 开始时间 */
    private Date startTime;

    /** 结束时间 */
    private Date endTime;

    /** 持续时间 */
    private Date duration;

    /** 分段数 */
    private Integer totalRecordings;

    /**
     * 记录详情
     */
    private List<WhVideoDetailSyncVO> recordings;

}
