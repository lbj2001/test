package com.wh.work.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.wh.common.annotation.Excel;
import com.wh.common.core.domain.BaseEntity;

import java.math.BigDecimal;
import java.util.List;

/**
 * 项目对象 wh_project
 * 
 * @author wxd
 * @date 2023-07-26
 */
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class WhProject extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 项目编号 */
    @Excel(name = "主资产编号")
    private String projectNo;

    /** 主项目名称 */
    @Excel(name = "主项目名称")
    private String mainProjectName;

    /** 摘要编号（子项目编号） */
    @Excel(name = "子项目编号")
    private String summaryNo;

    /** 子项目名称 */
    @Excel(name = "子项目名称")
    private String projectName;

    /** 项目类型 1、IT开发任务 2、IT设计任务 3、非IT类任务 */
    @Excel(name = "项目类型", readConverterExp = "1=IT开发任务,2=IT设计任务,3=非IT类任务")
    private Integer projectType;

    /** 项目来源（1 同步 2创建） */
    @Excel(name = "项目来源", readConverterExp = "1=同步,2=创建")
    private Integer projectSource;

    /** 项目负责人 */
    private String projectLeader;

    /** 项目负责人数组 */
    private List<String> projectLeaders;

    /** 代码与源编号 */
    @Excel(name = "代码与源编号")
    private String codeSourceNo;

    /** 周期类型（1 单次 2 每日 3 每月） */
    @Excel(name = "周期类型", readConverterExp = "1=单次,2=每日,3=每月")
    private Integer cycleType;

    /** 分支类型 */
    private String branchType;

    /** 分支类型数组 */
    private List<String> branchTypes;

    /** 限定任务工时数量 */
    @Excel(name = "项目名称")
    private BigDecimal workHoursThreshold;

    /** 是否启用状态（0 否 1 是） */
    @Excel(name = "是否启用状态", readConverterExp = "0=否,1=是")
    private Integer status;

    /** 删除标志（0代表存在 1代表删除） */
    private String delFlag;

    /** 员工id */
    @TableField(exist = false)
    private Long staffId;

    /**
     * 项目类型标识
     */
    @TableField(exist = false)
    private Integer projectTypeFlag;

    /**
     * 创建人
     */
    @TableField(exist = false)
    private String createByName;


}
