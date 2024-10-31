package com.wh.work.service.impl;

import java.util.List;
import com.wh.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import com.wh.work.mapper.WhTaskDistributionMapper;
import com.wh.work.domain.WhTaskDistribution;
import com.wh.work.service.IWhTaskDistributionService;

/**
 * 任务认领Service业务层处理
 * 
 * @author wxd
 * @date 2023-05-17
 */
@Service
public class WhTaskDistributionServiceImpl implements IWhTaskDistributionService
{
    @Autowired
    private WhTaskDistributionMapper whTaskDistributionMapper;

    /**
     * 查询任务认领
     * 
     * @param id 任务认领主键
     * @return 任务认领
     */
    @Override
    public WhTaskDistribution selectWhTaskDistributionById(Long id)
    {
        return whTaskDistributionMapper.selectWhTaskDistributionById(id);
    }

    /**
     * 查询任务认领列表
     * 
     * @param whTaskDistribution 任务认领
     * @return 任务认领
     */
    @Override
    public List<WhTaskDistribution> selectWhTaskDistributionList(WhTaskDistribution whTaskDistribution)
    {

        return whTaskDistributionMapper.selectWhTaskDistributionList(whTaskDistribution);
    }

    /**
     * 根据薪酬id查询任务认领列表
     * @param salaryIds 薪酬id
     * @return
     */
    @Override
    public List<WhTaskDistribution> selectListBySalaryIds(List<Long> salaryIds) {
        return whTaskDistributionMapper.selectListBySalaryIds(salaryIds);
    }

    /**
     * 新增任务认领
     * 
     * @param whTaskDistribution 任务认领
     * @return 结果
     */
    @Override
    public int insertWhTaskDistribution(WhTaskDistribution whTaskDistribution)
    {
        whTaskDistribution.setCreateTime(DateUtils.getNowDate());
        int flag = 0;
        try{
            flag = whTaskDistributionMapper.insertWhTaskDistribution(whTaskDistribution);
        }catch (DuplicateKeyException e){
            throw new RuntimeException("员工已分配工时，请勿重复添加");
        }
        return flag;
    }

    /**
     * 修改任务认领
     * 
     * @param whTaskDistribution 任务认领
     * @return 结果
     */
    @Override
    public int updateWhTaskDistribution(WhTaskDistribution whTaskDistribution)
    {
        whTaskDistribution.setUpdateTime(DateUtils.getNowDate());
        int flag = 0;
        try{
            flag = whTaskDistributionMapper.updateWhTaskDistribution(whTaskDistribution);
        }catch (DuplicateKeyException e){
            throw new RuntimeException("员工已认领任务，请勿重复添加");
        }
        return flag;
    }

    /**
     * 批量删除任务认领
     * 
     * @param ids 需要删除的任务认领主键
     * @return 结果
     */
    @Override
    public int deleteWhTaskDistributionByIds(Long[] ids)
    {
        return whTaskDistributionMapper.deleteWhTaskDistributionByIds(ids);
    }

    /**
     * 删除任务认领信息
     * 
     * @param id 任务认领主键
     * @return 结果
     */
    @Override
    public int deleteWhTaskDistributionById(Long id)
    {
        return whTaskDistributionMapper.deleteWhTaskDistributionById(id);
    }
}
