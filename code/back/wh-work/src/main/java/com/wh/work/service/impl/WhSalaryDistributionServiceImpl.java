package com.wh.work.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.wh.common.utils.DateUtils;
import com.wh.work.domain.WhTaskDistribution;
import com.wh.work.service.IWhTaskDistributionService;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.wh.work.mapper.WhSalaryDistributionMapper;
import com.wh.work.domain.WhSalaryDistribution;
import com.wh.work.service.IWhSalaryDistributionService;

/**
 * 薪酬发放Service业务层处理
 * 
 * @author wxd
 * @date 2023-06-05
 */
@Service
public class WhSalaryDistributionServiceImpl implements IWhSalaryDistributionService 
{
    @Autowired
    private WhSalaryDistributionMapper whSalaryDistributionMapper;

    @Autowired
    private IWhTaskDistributionService iWhTaskDistributionService;

    /**
     * 查询薪酬发放
     * 
     * @param id 薪酬发放主键
     * @return 薪酬发放
     */
    @Override
    public WhSalaryDistribution selectWhSalaryDistributionById(Long id)
    {
        return whSalaryDistributionMapper.selectWhSalaryDistributionById(id);
    }

    /**
     * 查询薪酬发放列表
     * 
     * @param whSalaryDistribution 薪酬发放
     * @return 薪酬发放
     */
    @Override
    public List<WhSalaryDistribution> selectWhSalaryDistributionList(WhSalaryDistribution whSalaryDistribution)
    {

        List<WhSalaryDistribution> list = whSalaryDistributionMapper.selectWhSalaryDistributionList(whSalaryDistribution);
        //查询子表数据
        if (CollectionUtils.isNotEmpty(list)) {
            List<Long> salaryIds = list.stream().map(WhSalaryDistribution::getId).distinct().collect(Collectors.toList());
            List<WhTaskDistribution> taskDistributionList = iWhTaskDistributionService.selectListBySalaryIds(salaryIds);
            Map<Long,List<WhTaskDistribution>> taskDistributionMap;
            if (CollectionUtils.isEmpty(list)){
                taskDistributionMap = new HashMap<>();
            }else{
                taskDistributionMap = taskDistributionList.stream().collect(Collectors.groupingBy(WhTaskDistribution::getSalaryId));
            }
            for(WhSalaryDistribution salaryDistribution: list){
                if(taskDistributionMap.containsKey(salaryDistribution.getId())){
                    salaryDistribution.setTaskDistributionList(taskDistributionMap.get(salaryDistribution.getId()));
                }
            }
        }
        return list;
    }

    /**
     * 新增薪酬发放
     * 
     * @param whSalaryDistribution 薪酬发放
     * @return 结果
     */
    @Override
    public int insertWhSalaryDistribution(WhSalaryDistribution whSalaryDistribution)
    {
        whSalaryDistribution.setCreateTime(DateUtils.getNowDate());
        return whSalaryDistributionMapper.insertWhSalaryDistribution(whSalaryDistribution);
    }

    /**
     * 修改薪酬发放
     * 
     * @param whSalaryDistribution 薪酬发放
     * @return 结果
     */
    @Override
    public int updateWhSalaryDistribution(WhSalaryDistribution whSalaryDistribution)
    {
        whSalaryDistribution.setUpdateTime(DateUtils.getNowDate());
        return whSalaryDistributionMapper.updateWhSalaryDistribution(whSalaryDistribution);
    }

    /**
     * 批量删除薪酬发放
     * 
     * @param ids 需要删除的薪酬发放主键
     * @return 结果
     */
    @Override
    public int deleteWhSalaryDistributionByIds(Long[] ids)
    {
        return whSalaryDistributionMapper.deleteWhSalaryDistributionByIds(ids);
    }

    /**
     * 删除薪酬发放信息
     * 
     * @param id 薪酬发放主键
     * @return 结果
     */
    @Override
    public int deleteWhSalaryDistributionById(Long id)
    {
        return whSalaryDistributionMapper.deleteWhSalaryDistributionById(id);
    }

    @Override
    public WhSalaryDistribution selectSalaryByStaffNo(String staffNo, String month) {
        return whSalaryDistributionMapper.selectSalaryByStaffNo(staffNo, month);
    }

    @Override
    public int distributeWhSalaryDistributionByIds(Long[] ids) {
        return whSalaryDistributionMapper.batchUpdateStatus(ids);
    }

    @Override
    public int checkExistByStaffId(Long staffId) {
        return whSalaryDistributionMapper.countByStaffId(staffId);
    }
}
