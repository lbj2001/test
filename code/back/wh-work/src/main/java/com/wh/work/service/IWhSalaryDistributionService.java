package com.wh.work.service;

import java.util.List;
import com.wh.work.domain.WhSalaryDistribution;

/**
 * 薪酬发放Service接口
 * 
 * @author wxd
 * @date 2023-06-05
 */
public interface IWhSalaryDistributionService 
{
    /**
     * 查询薪酬发放
     * 
     * @param id 薪酬发放主键
     * @return 薪酬发放
     */
    public WhSalaryDistribution selectWhSalaryDistributionById(Long id);

    /**
     * 查询薪酬发放列表
     * 
     * @param whSalaryDistribution 薪酬发放
     * @return 薪酬发放集合
     */
    public List<WhSalaryDistribution> selectWhSalaryDistributionList(WhSalaryDistribution whSalaryDistribution);

    /**
     * 新增薪酬发放
     * 
     * @param whSalaryDistribution 薪酬发放
     * @return 结果
     */
    public int insertWhSalaryDistribution(WhSalaryDistribution whSalaryDistribution);

    /**
     * 修改薪酬发放
     * 
     * @param whSalaryDistribution 薪酬发放
     * @return 结果
     */
    public int updateWhSalaryDistribution(WhSalaryDistribution whSalaryDistribution);

    /**
     * 批量删除薪酬发放
     * 
     * @param ids 需要删除的薪酬发放主键集合
     * @return 结果
     */
    public int deleteWhSalaryDistributionByIds(Long[] ids);

    /**
     * 删除薪酬发放信息
     * 
     * @param id 薪酬发放主键
     * @return 结果
     */
    public int deleteWhSalaryDistributionById(Long id);

    /**
     * 根据领薪人查询薪酬发放列表
     * @param staffId
     * @param month
     * @return
     */
    public WhSalaryDistribution selectSalaryByStaffNo(String staffNo, String month);

    /**
     * 批量修改薪酬发放
     *
     * @param ids 需要删除的薪酬发放主键集合
     * @return 结果
     */
    public int distributeWhSalaryDistributionByIds(Long[] ids);

    /**
     * 根据staffId判断是否存在
     * @param staffId
     * @return
     */
    public int checkExistByStaffId(Long staffId);
}
