package com.wh.system.domain.vo;/**
 * @author wxd
 * @date 2023/6/24
 * @desc
 */

import lombok.Data;

/**
 * @Desc: 功能描述
 * @author: Mr.dong
 * @date: 2023 06 24
 */
@Data
public class ContactVo {

    /** 测试地址 */
    private String testUrl;

    /** 技术支持姓名 */
    private String supportName;

    /** 技术支持微信 */
    private String supportWechat;

    /** 技术支持联系方式 */
    private String supportPhone;

    /** 管理员姓名 */
    private String adminName;

    /** 管理员微信 */
    private String adminWechat;

    /** 管理员联系方式 */
    private String adminPhone;
}
