package com.wh.system.domain.vo;

import lombok.Data;

import java.util.Date;

/**
 * @Desc: 三方用户信息
 * @author: Mr.dong
 * @date: 2023 06 24
 */
@Data
public class ThirdPartyProjectVo {

    /** 主键 */
    private Long id;

    /** 统计日期 */
    private Date statDate;

    /** IT资产编号 */
    private String itzcbh;

    /** IT资产名称 */
    private String itzcmc;

    /** 摘要编号 */
    private String zybh;

    /** 代码、源与镜像摘要编号*/
    private String dmyyjxzybh;

    /** 摘要信息明细全称*/
    private String zyxxmxqc;

    /** 删除标识：0 否 1 是 */
    private Integer isDelete;

    /** 数据类型：1 新增 2 更新 */
    private Integer dataType;

    /** 调度时间 */
    private Date etlTime;

}
