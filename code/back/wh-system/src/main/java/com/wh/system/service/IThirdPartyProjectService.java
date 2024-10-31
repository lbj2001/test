package com.wh.system.service;

import com.wh.system.domain.vo.ThirdPartyProjectVo;

import java.util.List;

/**
 * @author wxd
 * @date 2023/6/25
 * @desc 第三方数据集市
 */
public interface IThirdPartyProjectService {

    /**
     * 检查执行日志状态
     * @return
     */
    int checkLogStatus(String execDate);

    List<ThirdPartyProjectVo> getProjectList(String statDate);
}
