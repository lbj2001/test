package com.wh.work.service;

import java.net.UnknownHostException;
import java.util.List;
import com.wh.work.domain.WhVideoRecord;
import com.wh.work.domain.vo.WhVideoSyncVO;

/**
 * 工时视频记录Service接口
 * 
 * @author wxd
 * @date 2024-03-09
 */
public interface IWhVideoRecordService 
{
    /**
     * 查询工时视频记录
     * 
     * @param id 工时视频记录主键
     * @return 工时视频记录
     */
    public WhVideoRecord selectWhVideoRecordById(Long id);

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
     * 批量删除工时视频记录
     * 
     * @param ids 需要删除的工时视频记录主键集合
     * @return 结果
     */
    public int deleteWhVideoRecordByIds(Long[] ids);

    /**
     * 删除工时视频记录信息
     * 
     * @param id 工时视频记录主键
     * @return 结果
     */
    public int deleteWhVideoRecordById(Long id);

    /**
     * 查询工时视频记录列表
     *
     * @param videoSyncVO 工时视频记录
     * @return 工时视频记录集合
     */
    public List<WhVideoSyncVO> selectThirdPartyRecordList(WhVideoSyncVO videoSyncVO);

    /**
     * 查询最新同步数据
     *
     * @return 工时视频记录集合
     */
    public WhVideoRecord selectLastestSync();

    /**
     * 校验视频地址
     * @return
     */
    public boolean checkVideoAddress();

    /**
     * 异步调用视频记录
     */
    public boolean ayncVideoRecordList(WhVideoSyncVO videoSyncVO);

    /**
     * 同步视频记录
     */
    public void syncVideoRecordList(WhVideoSyncVO videoSyncVO);
}
