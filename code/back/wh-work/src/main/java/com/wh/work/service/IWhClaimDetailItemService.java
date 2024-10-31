package com.wh.work.service;

import java.util.List;
import com.wh.work.domain.WhClaimDetailItem;

/**
 * 工时申报明细条目Service接口
 * 
 * @author wxd
 * @date 2024-03-16
 */
public interface IWhClaimDetailItemService 
{
    /**
     * 查询工时申报明细条目
     * 
     * @param id 工时申报明细条目主键
     * @return 工时申报明细条目
     */
    public WhClaimDetailItem selectWhClaimDetailItemById(Long id);

    /**
     * 查询工时申报明细条目列表
     * 
     * @param whClaimDetailItem 工时申报明细条目
     * @return 工时申报明细条目集合
     */
    public List<WhClaimDetailItem> selectWhClaimDetailItemList(WhClaimDetailItem whClaimDetailItem);

    /**
     * 新增工时申报明细条目
     * 
     * @param whClaimDetailItem 工时申报明细条目
     * @return 结果
     */
    public int insertWhClaimDetailItem(WhClaimDetailItem whClaimDetailItem);

    /**
     * 修改工时申报明细条目
     * 
     * @param whClaimDetailItem 工时申报明细条目
     * @return 结果
     */
    public int updateWhClaimDetailItem(WhClaimDetailItem whClaimDetailItem);

    /**
     * 批量删除工时申报明细条目
     * 
     * @param ids 需要删除的工时申报明细条目主键集合
     * @return 结果
     */
    public int deleteWhClaimDetailItemByIds(Long[] ids);

    /**
     * 删除工时申报明细条目信息
     * 
     * @param id 工时申报明细条目主键
     * @return 结果
     */
    public int deleteWhClaimDetailItemById(Long id);
}
