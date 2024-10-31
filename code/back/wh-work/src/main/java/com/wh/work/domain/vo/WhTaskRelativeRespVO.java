package com.wh.work.domain.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import java.math.BigDecimal;

/**
 * 任务对象 wh_task
 * 
 * @author wxd
 * @date 2023-05-17
 */
@Data
@EqualsAndHashCode
@ToString(callSuper = true)
public class WhTaskRelativeRespVO
{
    private static final long serialVersionUID = 1L;

    /** 员工参与方式 */
    private BigDecimal totalWorkingHours;

    /** 团队id */
    private Long teamId;

}
