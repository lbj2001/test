package com.wh.work.domain.vo;

import com.wh.common.annotation.Excel;
import com.wh.common.core.domain.BaseEntity;
import com.wh.work.domain.WhTaskDistribution;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
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
@EqualsAndHashCode
@ToString(callSuper = true)
public class WhTaskStatisticsReqVO
{
    private static final long serialVersionUID = 1L;

    /** 员工参与方式 */
    private Integer participationMethods;

    /** 所属月份 */
    private String month;

    /** 所属年份 */
    private String year;

}
