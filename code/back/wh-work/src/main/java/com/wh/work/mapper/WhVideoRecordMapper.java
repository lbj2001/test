package com.wh.work.mapper;

import java.util.List;
import com.wh.work.domain.WhVideoRecord;
import org.apache.ibatis.annotations.Param;

/**
 * 工时视频记录Mapper接口
 * 
 * @author wxd
 * @date 2024-03-09
 */
public interface WhVideoRecordMapper 
{
    /**
     * 查询工时视频记录
     * 
     * @param id 工时视频记录主键
     * @return 工时视频记录
     */
    public WhVideoRecord selectWhVideoRecordById(Long id);

    /**
     * 根据sessionId查询工时视频记录
     *
     * @param sessionIds 池id集合
     * @return 工时视频记录
     */
    public List<WhVideoRecord> selectWhVideoRecordBySessionIds(@Param("sessionIds") List<Long> sessionIds);

    /**
     * 查询工时视频记录列表
     * 
     * @param whVideoRecord 工时视频记录
     * @return 工时视频记录集合
     */
    public List<WhVideoRecord> selectWhVideoRecordList(WhVideoRecord whVideoRecord);

    /**
     * 新增工时视频记录
     * 
     * @param whVideoRecord 工时视频记录
     * @return 结果
     */
    public int insertWhVideoRecord(WhVideoRecord whVideoRecord);

    /**
     * 修改工时视频记录
     * 
     * @param whVideoRecord 工时视频记录
     * @return 结果
     */
    public int updateWhVideoRecord(WhVideoRecord whVideoRecord);

    /**
     * 删除工时视频记录
     * 
     * @param id 工时视频记录主键
     * @return 结果
     */
    public int deleteWhVideoRecordById(Long id);

    /**
     * 批量删除工时视频记录
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteWhVideoRecordByIds(Long[] ids);

    /**
     * 查询最新工时视频记录
     *
     * @return 工时视频记录
     */
    public WhVideoRecord selectLastestSync();
}
