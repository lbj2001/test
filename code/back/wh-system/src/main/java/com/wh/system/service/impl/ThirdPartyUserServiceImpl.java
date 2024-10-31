package com.wh.system.service.impl;

import com.wh.common.annotation.DataSource;
import com.wh.common.enums.DataSourceType;
import com.wh.system.domain.vo.ThirdPartyProjectVo;
import com.wh.system.domain.vo.ThirdPartyUserVo;
import com.wh.system.mapper.ThirdPartyUserMapper;
import com.wh.system.service.IThirdPartyUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Desc: 功能描述
 * @author: Mr.dong
 * @date: 2023 06 25
 */
@Service
@DataSource(value = DataSourceType.SLAVE)
public class ThirdPartyUserServiceImpl implements IThirdPartyUserService {

    @Autowired
    private ThirdPartyUserMapper thirdPartyUserMapper;

    @Override
    public int checkLogStatus(String execDate) {
        return thirdPartyUserMapper.selectLogStatus(execDate);
    }

    @Override
    public List<ThirdPartyUserVo> getUserList(String statDate) {
        return thirdPartyUserMapper.selectUserList(statDate);
    }
}
