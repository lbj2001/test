package com.wh.work.domain;

import java.math.BigDecimal;
import java.util.Date;
import java.util.Objects;
import java.util.Set;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.wh.common.annotation.Excel;
import com.wh.common.core.domain.BaseEntity;

/**
 * 员工信息对象 wh_staff
 * 
 * @author wxd
 * @date 2023-05-16
 */
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class WhStaff extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 父级ID */
    private Long parentId;

    /** 团队ID */
    private Long teamId;

    /** 架构名称 */
    private String teamName;

    /** 架构编号 */
    private String teamNo;

    /** 员工编号 */
    @Excel(name = "员工编号")
    private String staffNo;

    /** 员工名称 */
    @Excel(name = "员工名称")
    private String staffName;

    /** 首次合作时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "首次合作时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date firstCooperationTime;

    /** 参与方式（1团队负责人 2小组负责人 3 开发人员 4领薪人员 ） */
    @Excel(name = "参与方式", readConverterExp = "1=团队负责人,2=小组负责人,3=开发人员,4=领薪人员")
    private Integer participationMethods;

    /** 上次终止合作时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date endCooperationTime;

    private Integer pageMethods;

    private Integer maxMethod;

    /** 删除标志（0代表存在 1代表删除） */
    private String delFlag;

    /** 解除标识*/
    private String dismissFlag;

    /**
     * 是否平行开发 0 否 1 是
     */
    private Integer parallelFlag;

    /** 工作内容*/
    private String workContent;

    /**
     * 用户账号状态 0 正常 1 停用
     */
    private Integer status;

    /**
     * 更新人
     */
    @TableField(exist = false)
    private String updateByName;

    /**
     * 团队人数
     */
    @TableField(exist = false)
    private Integer teamAmount;

    /**
     * 工时单价
     */
    @TableField(exist = false)
    private BigDecimal workingPrice;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        WhStaff staff = (WhStaff) o;
        return Objects.equals(id, staff.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
