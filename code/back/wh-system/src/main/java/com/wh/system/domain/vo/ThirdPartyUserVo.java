package com.wh.system.domain.vo;

import lombok.Data;

import java.util.Date;

/**
 * @Desc: 三方用户信息
 * @author: Mr.dong
 * @date: 2023 06 24
 */
@Data
public class ThirdPartyUserVo {

    /** 主键 */
    private Long id;

    /** 统计日期 */
    private Date statDate;

    /** 人员号 */
    private String ryh;

    /** 姓名 */
    private String xm;

    /** 开户银行账号 */
    private String khyhzh;

    /** 开户支行 */
    private String khzh;

    /** 人司关系 11 劳动关系 12 外协开发 */
    private String rsgx;

    /** 手机号码 */
    private String sj;

    /** 删除标识：1 正常 2 离职 */
    private Integer isDelete;

    /** 数据类型：1 新增 2 更新 */
    private Integer dataType;

    /** 调度时间 */
    private Date etlTime;
}
