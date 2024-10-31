package com.wh.work.service.impl;

import java.util.List;
import com.wh.common.utils.DateUtils;
import com.wh.work.domain.WhProjectOrigin;
import com.wh.work.mapper.WhProjectOriginMapper;
import com.wh.work.service.IWhProjectOriginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 项目来源Service业务层处理
 * 
 * @author wh
 * @date 2023-10-13
 */
@Service
public class WhProjectOriginServiceImpl implements IWhProjectOriginService
{
    @Autowired
    private WhProjectOriginMapper whProjectOriginMapper;

    /**
     * 查询项目来源
     * 
     * @param id 项目来源主键
     * @return 项目来源
     */
    @Override
    public WhProjectOrigin selectWhProjectOriginById(Long id)
    {
        return whProjectOriginMapper.selectWhProjectOriginById(id);
    }

    /**
     * 查询项目来源列表
     * 
     * @param whProjectOrigin 项目来源
     * @return 项目来源
     */
    @Override
    public List<WhProjectOrigin> selectWhProjectOriginList(WhProjectOrigin whProjectOrigin)
    {
        return whProjectOriginMapper.selectWhProjectOriginList(whProjectOrigin);
    }

    /**
     * 新增项目来源
     * 
     * @param whProjectOrigin 项目来源
     * @return 结果
     */
    @Override
    public int insertWhProjectOrigin(WhProjectOrigin whProjectOrigin)
    {
        whProjectOrigin.setCreateTime(DateUtils.getNowDate());
        return whProjectOriginMapper.insertWhProjectOrigin(whProjectOrigin);
    }

    /**
     * 修改项目来源
     * 
     * @param whProjectOrigin 项目来源
     * @return 结果
     */
    @Override
    public int updateWhProjectOrigin(WhProjectOrigin whProjectOrigin)
    {
        whProjectOrigin.setUpdateTime(DateUtils.getNowDate());
        return whProjectOriginMapper.updateWhProjectOrigin(whProjectOrigin);
    }

    /**
     * 批量删除项目来源
     * 
     * @param ids 需要删除的项目来源主键
     * @return 结果
     */
    @Override
    public int deleteWhProjectOriginByIds(Long[] ids)
    {
        return whProjectOriginMapper.deleteWhProjectOriginByIds(ids);
    }

    /**
     * 删除项目来源信息
     * 
     * @param id 项目来源主键
     * @return 结果
     */
    @Override
    public int deleteWhProjectOriginById(Long id)
    {
        return whProjectOriginMapper.deleteWhProjectOriginById(id);
    }

    /**
     * 根据编号更新项目来源
     * @param whProjectOrigin
     * @return
     */
    @Override
    public int updateProjectOriginByNo(WhProjectOrigin whProjectOrigin) {
        return whProjectOriginMapper.updateProjectOriginByNo(whProjectOrigin);
    }

    @Override
    public List<WhProjectOrigin> listSourceNos(String projectNo, String summaryNo) {
        WhProjectOrigin whProjectOrigin = new WhProjectOrigin();
        whProjectOrigin.setProjectNo(projectNo);
        whProjectOrigin.setSummaryNo(summaryNo);
        return whProjectOriginMapper.selectWhProjectOriginList(whProjectOrigin);
    }

    @Override
    public WhProjectOrigin selectWhProjectOriginBySyncId(Long syncId) {
        return whProjectOriginMapper.selectWhProjectOriginBySyncId(syncId);
    }


}
