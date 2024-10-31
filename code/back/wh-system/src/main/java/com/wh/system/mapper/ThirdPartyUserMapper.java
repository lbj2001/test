package com.wh.system.mapper;

import com.wh.system.domain.vo.ThirdPartyProjectVo;
import com.wh.system.domain.vo.ThirdPartyUserVo;

import java.util.List;

/**
 * 用户与角色关联表 数据层
 * 
 * @author wh
 */
public interface ThirdPartyUserMapper
{
    /**
     * 查询任务执行状态
     * @return
     */
    int selectLogStatus(String execDate);

    List<ThirdPartyUserVo> selectUserList(String statDate);

}
