package com.wh.work.mapper;

import java.util.List;
import com.wh.work.domain.WhSalaryDistribution;
import org.apache.ibatis.annotations.Param;

/**
 * 薪酬发放Mapper接口
 * 
 * @author wxd
 * @date 2023-06-05
 */
public interface WhSalaryDistributionMapper 
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
     * 删除薪酬发放
     * 
     * @param id 薪酬发放主键
     * @return 结果
     */
    public int deleteWhSalaryDistributionById(Long id);

    /**
     * 批量删除薪酬发放
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteWhSalaryDistributionByIds(Long[] ids);

    /**
     * 根据领薪人查询薪酬列表
     * @param staffNo
     * @param month
     * @return
     */
    public WhSalaryDistribution selectSalaryByStaffNo(@Param("staffNo") String staffNo, @Param("month") String month);

    /**
     * 批量修改状态
     * @param ids
     * @return
     */
    public int batchUpdateStatus(Long[] ids);

    /**
     * 根据staffId查询存在数量
     * @param staffId
     * @return
     */
    public int countByStaffId(@Param("staffId") Long staffId);
}
