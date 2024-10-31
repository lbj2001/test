package com.wh.work.service.impl;

import com.wh.common.utils.DateUtils;
import com.wh.work.domain.WhVideoRecordDetail;
import com.wh.work.mapper.WhVideoRecordDetailMapper;
import com.wh.work.service.IWhVideoRecordDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 工时视频记录详情Service业务层处理
 * 
 * @author wh
 * @date 2024-03-16
 */
@Service
public class WhVideoRecordDetailServiceImpl implements IWhVideoRecordDetailService
{
    @Autowired
    private WhVideoRecordDetailMapper whVideoRecordDetailMapper;

    /**
     * 查询工时视频记录详情
     * 
     * @param id 工时视频记录详情主键
     * @return 工时视频记录详情
     */
    @Override
    public WhVideoRecordDetail selectWhVideoRecordDetailById(Long id)
    {
        return whVideoRecordDetailMapper.selectWhVideoRecordDetailById(id);
    }

    /**
     * 查询工时视频记录详情列表
     * 
     * @param whVideoRecordDetail 工时视频记录详情
     * @return 工时视频记录详情
     */
    @Override
    public List<WhVideoRecordDetail> selectWhVideoRecordDetailList(WhVideoRecordDetail whVideoRecordDetail)
    {
        return whVideoRecordDetailMapper.selectWhVideoRecordDetailList(whVideoRecordDetail);
    }

    /**
     * 新增工时视频记录详情
     * 
     * @param whVideoRecordDetail 工时视频记录详情
     * @return 结果
     */
    @Override
    public int insertWhVideoRecordDetail(WhVideoRecordDetail whVideoRecordDetail)
    {
        whVideoRecordDetail.setCreateTime(DateUtils.getNowDate());
        return whVideoRecordDetailMapper.insertWhVideoRecordDetail(whVideoRecordDetail);
    }

    /**
     * 修改工时视频记录详情
     * 
     * @param whVideoRecordDetail 工时视频记录详情
     * @return 结果
     */
    @Override
    public int updateWhVideoRecordDetail(WhVideoRecordDetail whVideoRecordDetail)
    {
        whVideoRecordDetail.setUpdateTime(DateUtils.getNowDate());
        return whVideoRecordDetailMapper.updateWhVideoRecordDetail(whVideoRecordDetail);
    }

    /**
     * 批量删除工时视频记录详情
     * 
     * @param ids 需要删除的工时视频记录详情主键
     * @return 结果
     */
    @Override
    public int deleteWhVideoRecordDetailByIds(Long[] ids)
    {
        return whVideoRecordDetailMapper.deleteWhVideoRecordDetailByIds(ids);
    }

    /**
     * 删除工时视频记录详情信息
     * 
     * @param id 工时视频记录详情主键
     * @return 结果
     */
    @Override
    public int deleteWhVideoRecordDetailById(Long id)
    {
        return whVideoRecordDetailMapper.deleteWhVideoRecordDetailById(id);
    }
}
