package com.wh.work.mapper;

import java.util.List;

import com.wh.work.domain.WhSalaryDistribution;
import com.wh.work.domain.WhTaskStatistics;
import org.apache.ibatis.annotations.Param;

/**
 * 工时统计Mapper接口
 * 
 * @author wxd
 * @date 2023-06-07
 */
public interface WhTaskStatisticsMapper 
{
    /**
     * 查询工时统计
     * 
     * @param id 工时统计主键
     * @return 工时统计
     */
    public WhTaskStatistics selectWhTaskStatisticsById(Long id);

    /**
     * 查询工时统计列表
     * 
     * @param whTaskStatistics 工时统计
     * @return 工时统计集合
     */
    public List<WhTaskStatistics> selectWhTaskStatisticsList(WhTaskStatistics whTaskStatistics);

    /**
     * 新增工时统计
     * 
     * @param whTaskStatistics 工时统计
     * @return 结果
     */
    public int insertWhTaskStatistics(WhTaskStatistics whTaskStatistics);

    /**
     * 修改工时统计
     * 
     * @param whTaskStatistics 工时统计
     * @return 结果
     */
    public int updateWhTaskStatistics(WhTaskStatistics whTaskStatistics);

    /**
     * 删除工时统计
     * 
     * @param id 工时统计主键
     * @return 结果
     */
    public int deleteWhTaskStatisticsById(Long id);

    /**
     * 批量删除工时统计
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteWhTaskStatisticsByIds(Long[] ids);

    /**
     * 根据员工id查询任务统计
     * @param staffId
     * @param month
     * @return
     */
    public WhTaskStatistics selectByStaffId(@Param("staffId") Long staffId, @Param("month") String month);
}
