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
 * 薪酬发放对象 wh_salary_distribution
 * 
 * @author wxd
 * @date 2023-06-05
 */
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class WhSalaryDistribution extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键id */
    private Long id;

    /** 员工id */

    private Long staffId;

    /** 员工名称 */
    @Excel(name = "员工名称")
    private String staffName;

    /** 员工编号 */
    @Excel(name = "员工编号")
    private String staffNo;

    /** 开户银行 */
    @Excel(name = "开户银行")
    private String bank;

    /** 账户 */
    @Excel(name = "账户")
    private String account;


    /** 本月工时 */
    @Excel(name = "本月工时")
    private BigDecimal workingHours;

    /** 本月薪酬 */
    @Excel(name = "本月薪酬")
    private BigDecimal salary;

    /** 所属年月 */
    @Excel(name = "所属年月")
    private String month;

    @Excel(name = "发放时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date distributeTime;

    /** 发放状态（0 未发放 1 已发放） */
    @Excel(name = "发放状态", readConverterExp = "0=未发放,1=已发放")
    private Integer status;

    /** 薪酬分配列表 */
    private List<WhTaskDistribution> taskDistributionList;

    /**
     * 开发人员名称
     */
    private String developName;

    /**
     * 参与团队员工ID
     */
    private String pathId;

    /**
     * 参与团队员工名称
     */
    private String pathName;

}
