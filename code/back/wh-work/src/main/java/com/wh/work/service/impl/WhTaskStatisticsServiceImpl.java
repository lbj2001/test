package com.wh.work.service.impl;

import java.util.List;
import com.wh.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.wh.work.mapper.WhTaskStatisticsMapper;
import com.wh.work.domain.WhTaskStatistics;
import com.wh.work.service.IWhTaskStatisticsService;

/**
 * 工时统计Service业务层处理
 * 
 * @author wxd
 * @date 2023-06-07
 */
@Service
public class WhTaskStatisticsServiceImpl implements IWhTaskStatisticsService 
{
    @Autowired
    private WhTaskStatisticsMapper whTaskStatisticsMapper;

    /**
     * 查询工时统计
     * 
     * @param id 工时统计主键
     * @return 工时统计
     */
    @Override
    public WhTaskStatistics selectWhTaskStatisticsById(Long id)
    {
        return whTaskStatisticsMapper.selectWhTaskStatisticsById(id);
    }

    /**
     * 查询工时统计列表
     * 
     * @param whTaskStatistics 工时统计
     * @return 工时统计
     */
    @Override
    public List<WhTaskStatistics> selectWhTaskStatisticsList(WhTaskStatistics whTaskStatistics)
    {
        return whTaskStatisticsMapper.selectWhTaskStatisticsList(whTaskStatistics);
    }

    /**
     * 新增工时统计
     * 
     * @param whTaskStatistics 工时统计
     * @return 结果
     */
    @Override
    public int insertWhTaskStatistics(WhTaskStatistics whTaskStatistics)
    {
        whTaskStatistics.setCreateTime(DateUtils.getNowDate());
        return whTaskStatisticsMapper.insertWhTaskStatistics(whTaskStatistics);
    }

    /**
     * 修改工时统计
     * 
     * @param whTaskStatistics 工时统计
     * @return 结果
     */
    @Override
    public int updateWhTaskStatistics(WhTaskStatistics whTaskStatistics)
    {
        whTaskStatistics.setUpdateTime(DateUtils.getNowDate());
        return whTaskStatisticsMapper.updateWhTaskStatistics(whTaskStatistics);
    }

    /**
     * 批量删除工时统计
     * 
     * @param ids 需要删除的工时统计主键
     * @return 结果
     */
    @Override
    public int deleteWhTaskStatisticsByIds(Long[] ids)
    {
        return whTaskStatisticsMapper.deleteWhTaskStatisticsByIds(ids);
    }

    /**
     * 删除工时统计信息
     * 
     * @param id 工时统计主键
     * @return 结果
     */
    @Override
    public int deleteWhTaskStatisticsById(Long id)
    {
        return whTaskStatisticsMapper.deleteWhTaskStatisticsById(id);
    }

    @Override
    public WhTaskStatistics selectByStaffId(Long staffId, String month) {
        return whTaskStatisticsMapper.selectByStaffId(staffId, month);
    }
}
