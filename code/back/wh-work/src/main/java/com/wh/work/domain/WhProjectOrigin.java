package com.wh.work.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.wh.common.annotation.Excel;
import com.wh.common.core.domain.BaseEntity;

/**
 * 项目来源对象 wh_project_origin
 * 
 * @author wh
 * @date 2023-10-13
 */
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class WhProjectOrigin extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 项目编号 */
    @Excel(name = "项目编号")
    private String projectNo;

    /** 项目名称 */
    @Excel(name = "项目名称")
    private String projectName;

    /** 摘要编号 */
    @Excel(name = "摘要编号")
    private String summaryNo;

    /** 代码与源镜像摘要编号 */
    @Excel(name = "代码与源镜像摘要编号")
    private String codeSourceNo;

    /** 同步主键id */
    private Long syncId;

    /** 删除标志（0代表存在 1代表删除） */
    private String delFlag;
}
