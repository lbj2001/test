package com.wh.work.mapper;

import java.util.List;
import com.wh.work.domain.WhStaff;
import org.apache.ibatis.annotations.Param;

/**
 * 员工信息Mapper接口
 * 
 * @author wxd
 * @date 2023-05-16
 */
public interface WhStaffMapper 
{
    /**
     * 查询员工信息
     * 
     * @param id 员工信息主键
     * @return 员工信息
     */
    public WhStaff selectWhStaffById(Long id);

    /**
     * 查询员工信息列表
     * 
     * @param whStaff 员工信息
     * @return 员工信息集合
     */
    public List<WhStaff> selectWhStaffList(WhStaff whStaff);

    /**
     * 查询员工信息列表
     *
     * @param whStaff 员工信息
     * @return 员工信息集合
     */
    public List<WhStaff> selectAllRelatives(WhStaff whStaff);

    /**
     * 查询员工所有子级
     *
     * @param whStaff 员工信息
     * @return 员工信息集合
     */
    public List<WhStaff> selectWhStaffListChildren(WhStaff whStaff);

    /**
     * 查询员工子级
     *
     * @param whStaff 员工信息
     * @return 员工信息集合
     */
    public List<WhStaff> selectAllChildren(WhStaff whStaff);

    /**
     * 查询员工所有父级
     *
     * @param whStaff 员工信息
     * @return 员工信息集合
     */
    public List<WhStaff> selectWhStaffListParents(WhStaff whStaff);

    /**
     * 查询员工所有父级(除去自己)
     *
     * @param whStaff 员工信息
     * @return 员工信息集合
     */
    public List<WhStaff> selectAllParents(WhStaff whStaff);

    /**
     * 新增员工信息
     * 
     * @param whStaff 员工信息
     * @return 结果
     */
    public int insertWhStaff(WhStaff whStaff);

    /**
     * 修改员工信息
     * 
     * @param whStaff 员工信息
     * @return 结果
     */
    public int updateWhStaff(WhStaff whStaff);

    /**
     * 删除员工信息
     * 
     * @param id 员工信息主键
     * @return 结果
     */
    public int deleteWhStaffById(Long id);

    /**
     * 批量删除员工信息
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteWhStaffByIds(Long[] ids);

    /**
     * 查询最大流水编号
     * @param teamName
     * @return
     */
    public String selectMaxTeamNo(String teamName);

    /**
     * 查询领薪人
     * @param whStaff
     * @return
     */
    List<WhStaff> selectSalaryNames(WhStaff whStaff);

    /**
     * 根据父级查询员工信息列表
     *
     * @param whStaff 员工信息
     * @return 员工信息集合
     */
    public List<WhStaff> selectWhStaffListByParent(WhStaff whStaff);

    /**
     * 查询最大级别组队
     * @param staffNo
     * @return
     */
    public WhStaff selectMaxStaff(String staffNo);

    /**
     * 查询团队人数
     * @param staffId
     * @return
     */
    public Integer selectTeamAmount(Long staffId);
}
