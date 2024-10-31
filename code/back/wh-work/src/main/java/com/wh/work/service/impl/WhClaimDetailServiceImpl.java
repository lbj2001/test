package com.wh.work.service.impl;

import java.util.List;
import com.wh.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.wh.work.mapper.WhClaimDetailMapper;
import com.wh.work.domain.WhClaimDetail;
import com.wh.work.service.IWhClaimDetailService;

/**
 * 工时申报明细Service业务层处理
 * 
 * @author wxd
 * @date 2024-03-04
 */
@Service
public class WhClaimDetailServiceImpl implements IWhClaimDetailService 
{
    @Autowired
    private WhClaimDetailMapper whClaimDetailMapper;

    /**
     * 查询工时申报明细
     * 
     * @param id 工时申报明细主键
     * @return 工时申报明细
     */
    @Override
    public WhClaimDetail selectWhClaimDetailById(Long id)
    {
        return whClaimDetailMapper.selectWhClaimDetailById(id);
    }

    /**
     * 查询工时申报明细列表
     * 
     * @param whClaimDetail 工时申报明细
     * @return 工时申报明细
     */
    @Override
    public List<WhClaimDetail> selectWhClaimDetailList(WhClaimDetail whClaimDetail)
    {
        return whClaimDetailMapper.selectWhClaimDetailList(whClaimDetail);
    }

    /**
     * 新增工时申报明细
     * 
     * @param whClaimDetail 工时申报明细
     * @return 结果
     */
    @Override
    public int insertWhClaimDetail(WhClaimDetail whClaimDetail)
    {
        whClaimDetail.setCreateTime(DateUtils.getNowDate());
        return whClaimDetailMapper.insertWhClaimDetail(whClaimDetail);
    }

    /**
     * 修改工时申报明细
     * 
     * @param whClaimDetail 工时申报明细
     * @return 结果
     */
    @Override
    public int updateWhClaimDetail(WhClaimDetail whClaimDetail)
    {
        whClaimDetail.setUpdateTime(DateUtils.getNowDate());
        return whClaimDetailMapper.updateWhClaimDetail(whClaimDetail);
    }

    /**
     * 批量删除工时申报明细
     * 
     * @param ids 需要删除的工时申报明细主键
     * @return 结果
     */
    @Override
    public int deleteWhClaimDetailByIds(Long[] ids)
    {
        return whClaimDetailMapper.deleteWhClaimDetailByIds(ids);
    }

    /**
     * 删除工时申报明细信息
     * 
     * @param id 工时申报明细主键
     * @return 结果
     */
    @Override
    public int deleteWhClaimDetailById(Long id)
    {
        return whClaimDetailMapper.deleteWhClaimDetailById(id);
    }
}
