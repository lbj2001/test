package com.wh.work.domain.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import java.math.BigDecimal;

/**
 * 任务对象 wh_task
 * 
 * @author wxd
 * @date 2023-05-17
 */
@Data
@EqualsAndHashCode
@ToString(callSuper = true)
public class WhJudgeTaskVO
{
    private static final long serialVersionUID = 1L;

    /** 存在标识 */
    private Boolean existFlag;

    /** 提示信息 */
    private String errorMessage;

}
