package com.wh.work.service.impl;

import java.util.List;
import com.wh.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.wh.work.mapper.WhClaimDetailItemMapper;
import com.wh.work.domain.WhClaimDetailItem;
import com.wh.work.service.IWhClaimDetailItemService;

/**
 * 工时申报明细条目Service业务层处理
 * 
 * @author wxd
 * @date 2024-03-16
 */
@Service
public class WhClaimDetailItemServiceImpl implements IWhClaimDetailItemService 
{
    @Autowired
    private WhClaimDetailItemMapper whClaimDetailItemMapper;

    /**
     * 查询工时申报明细条目
     * 
     * @param id 工时申报明细条目主键
     * @return 工时申报明细条目
     */
    @Override
    public WhClaimDetailItem selectWhClaimDetailItemById(Long id)
    {
        return whClaimDetailItemMapper.selectWhClaimDetailItemById(id);
    }

    /**
     * 查询工时申报明细条目列表
     * 
     * @param whClaimDetailItem 工时申报明细条目
     * @return 工时申报明细条目
     */
    @Override
    public List<WhClaimDetailItem> selectWhClaimDetailItemList(WhClaimDetailItem whClaimDetailItem)
    {
        return whClaimDetailItemMapper.selectWhClaimDetailItemList(whClaimDetailItem);
    }

    /**
     * 新增工时申报明细条目
     * 
     * @param whClaimDetailItem 工时申报明细条目
     * @return 结果
     */
    @Override
    public int insertWhClaimDetailItem(WhClaimDetailItem whClaimDetailItem)
    {
        whClaimDetailItem.setCreateTime(DateUtils.getNowDate());
        return whClaimDetailItemMapper.insertWhClaimDetailItem(whClaimDetailItem);
    }

    /**
     * 修改工时申报明细条目
     * 
     * @param whClaimDetailItem 工时申报明细条目
     * @return 结果
     */
    @Override
    public int updateWhClaimDetailItem(WhClaimDetailItem whClaimDetailItem)
    {
        whClaimDetailItem.setUpdateTime(DateUtils.getNowDate());
        return whClaimDetailItemMapper.updateWhClaimDetailItem(whClaimDetailItem);
    }

    /**
     * 批量删除工时申报明细条目
     * 
     * @param ids 需要删除的工时申报明细条目主键
     * @return 结果
     */
    @Override
    public int deleteWhClaimDetailItemByIds(Long[] ids)
    {
        return whClaimDetailItemMapper.deleteWhClaimDetailItemByIds(ids);
    }

    /**
     * 删除工时申报明细条目信息
     * 
     * @param id 工时申报明细条目主键
     * @return 结果
     */
    @Override
    public int deleteWhClaimDetailItemById(Long id)
    {
        return whClaimDetailItemMapper.deleteWhClaimDetailItemById(id);
    }
}
