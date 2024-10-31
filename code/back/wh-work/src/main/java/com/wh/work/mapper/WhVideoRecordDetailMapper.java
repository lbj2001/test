package com.wh.work.mapper;

import com.wh.work.domain.WhVideoRecordDetail;

import java.util.List;

/**
 * 工时视频记录详情Mapper接口
 * 
 * @author wh
 * @date 2024-03-16
 */
public interface WhVideoRecordDetailMapper 
{
    /**
     * 查询工时视频记录详情
     * 
     * @param id 工时视频记录详情主键
     * @return 工时视频记录详情
     */
    public WhVideoRecordDetail selectWhVideoRecordDetailById(Long id);

    /**
     * 查询工时视频记录详情列表
     * 
     * @param whVideoRecordDetail 工时视频记录详情
     * @return 工时视频记录详情集合
     */
    public List<WhVideoRecordDetail> selectWhVideoRecordDetailList(WhVideoRecordDetail whVideoRecordDetail);

    /**
     * 新增工时视频记录详情
     * 
     * @param whVideoRecordDetail 工时视频记录详情
     * @return 结果
     */
    public int insertWhVideoRecordDetail(WhVideoRecordDetail whVideoRecordDetail);

    /**
     * 修改工时视频记录详情
     * 
     * @param whVideoRecordDetail 工时视频记录详情
     * @return 结果
     */
    public int updateWhVideoRecordDetail(WhVideoRecordDetail whVideoRecordDetail);

    /**
     * 删除工时视频记录详情
     * 
     * @param id 工时视频记录详情主键
     * @return 结果
     */
    public int deleteWhVideoRecordDetailById(Long id);

    /**
     * 批量删除工时视频记录详情
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteWhVideoRecordDetailByIds(Long[] ids);
}
