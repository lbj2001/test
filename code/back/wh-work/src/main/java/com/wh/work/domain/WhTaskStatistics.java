package com.wh.work.domain;

import java.math.BigDecimal;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.wh.common.annotation.Excel;
import com.wh.common.core.domain.BaseEntity;

/**
 * 工时统计对象 wh_task_statistics
 * 
 * @author wxd
 * @date 2023-06-07
 */
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class WhTaskStatistics extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键id */
    private Long id;

    /** 员工id */
    @Excel(name = "员工id")
    private Long staffId;

    /** 员工编号 */
    @Excel(name = "员工编号")
    private String staffNo;

    /** 员工名称 */
    @Excel(name = "员工名称")
    private String staffName;

    /** 总工时 */
    @Excel(name = "总工时")
    private BigDecimal totalWorkingHours;

    /** 分配次数 */
    private Integer amount;

    /** 所属年月 */
    @Excel(name = "所属年月")
    private String month;

    /** 所属年 */
    private String year;

    /** 统计维度（1团队 2小组 3 开发） */
    @Excel(name = "统计维度", readConverterExp = "1=团队,2=小组,3=开发")
    private Integer dimension;

}
