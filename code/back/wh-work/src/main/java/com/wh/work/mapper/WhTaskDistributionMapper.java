package com.wh.work.mapper;

import java.util.List;
import com.wh.work.domain.WhTaskDistribution;
import org.apache.ibatis.annotations.Param;

/**
 * 任务认领Mapper接口
 * 
 * @author wxd
 * @date 2023-05-17
 */
public interface WhTaskDistributionMapper
{
    /**
     * 查询任务认领
     * 
     * @param id 任务认领主键
     * @return 任务认领
     */
    public WhTaskDistribution selectWhTaskDistributionById(Long id);

    /**
     * 查询任务认领列表
     * 
     * @param whTaskDistribution 任务认领
     * @return 任务认领集合
     */
    public List<WhTaskDistribution> selectWhTaskDistributionList(WhTaskDistribution whTaskDistribution);

    /**
     * 查询任务认领列表
     *
     * @param salaryIds 任务认领
     * @return 任务认领集合
     */
    public List<WhTaskDistribution> selectListBySalaryIds(@Param("salaryIds") List<Long> salaryIds);

    /**
     * 新增任务认领
     * 
     * @param whTaskDistribution 任务认领
     * @return 结果
     */
    public int insertWhTaskDistribution(WhTaskDistribution whTaskDistribution);

    /**
     * 修改任务认领
     * 
     * @param whTaskDistribution 任务认领
     * @return 结果
     */
    public int updateWhTaskDistribution(WhTaskDistribution whTaskDistribution);

    /**
     * 删除任务认领
     * 
     * @param id 任务认领主键
     * @return 结果
     */
    public int deleteWhTaskDistributionById(Long id);

    /**
     * 批量删除任务认领
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteWhTaskDistributionByIds(Long[] ids);
}
