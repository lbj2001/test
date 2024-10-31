package com.wh.work.domain.vo;

import com.wh.common.annotation.Excel;
import com.wh.common.core.domain.BaseEntity;
import com.wh.work.domain.WhTaskDistribution;
import lombok.Data;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 任务对象 wh_task
 * 
 * @author wxd
 * @date 2023-05-17
 */
@Data
public class WhTaskStatisticsRespVO
{
    private static final long serialVersionUID = 1L;

    /** 员工ID */
    private Long staffId;

    /** 员工编号 */
    private String staffNo;

    /** 员工名称 */
    private String staffName;

    /** 团队ID */
    private Long teamId;

    /** 申报工时 */
    private BigDecimal totalWorkingHours;

    /** 分配次数 */
    private Integer amount;

    /** 所属年月 */
    private String month;

}
