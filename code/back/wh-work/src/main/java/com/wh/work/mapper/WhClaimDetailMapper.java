package com.wh.work.mapper;

import java.util.List;
import com.wh.work.domain.WhClaimDetail;

/**
 * 工时申报明细Mapper接口
 * 
 * @author wxd
 * @date 2024-03-04
 */
public interface WhClaimDetailMapper 
{
    /**
     * 查询工时申报明细
     * 
     * @param id 工时申报明细主键
     * @return 工时申报明细
     */
    public WhClaimDetail selectWhClaimDetailById(Long id);

    /**
     * 查询工时申报明细列表
     * 
     * @param whClaimDetail 工时申报明细
     * @return 工时申报明细集合
     */
    public List<WhClaimDetail> selectWhClaimDetailList(WhClaimDetail whClaimDetail);

    /**
     * 新增工时申报明细
     * 
     * @param whClaimDetail 工时申报明细
     * @return 结果
     */
    public int insertWhClaimDetail(WhClaimDetail whClaimDetail);

    /**
     * 修改工时申报明细
     * 
     * @param whClaimDetail 工时申报明细
     * @return 结果
     */
    public int updateWhClaimDetail(WhClaimDetail whClaimDetail);

    /**
     * 删除工时申报明细
     * 
     * @param id 工时申报明细主键
     * @return 结果
     */
    public int deleteWhClaimDetailById(Long id);

    /**
     * 批量删除工时申报明细
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteWhClaimDetailByIds(Long[] ids);
}
