package com.wh.work.service;

import java.util.List;
import com.wh.work.domain.WhStaff;

/**
 * 员工信息Service接口
 * 
 * @author wxd
 * @date 2023-05-16
 */
public interface IWhStaffService 
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
     * 查询单个员工信息列表
     *
     * @param whStaff
     * @return 员工信息集合
     */
    public List<WhStaff> selectSingleList(WhStaff whStaff);

    /**
     * 查询员工所有子集
     *
     * @param whStaff 员工信息
     * @return 员工信息集合
     */
    public List<WhStaff> selectWhStaffListChildren(WhStaff whStaff);

    /**
     * 查询员工所有父集
     *
     * @param whStaff 员工信息
     * @return 员工信息集合
     */
    public List<WhStaff> selectWhStaffListParents(WhStaff whStaff);

    /**
     * 查询员工所有父集（除自己）
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
     * 批量删除员工信息
     * 
     * @param ids 需要删除的员工信息主键集合
     * @return 结果
     */
    public int deleteWhStaffByIds(Long[] ids);

    /**
     * 删除员工信息信息
     * 
     * @param id 员工信息主键
     * @return 结果
     */
    public int deleteWhStaffById(Long id);

    /**
     * 解除员工组队配置
     *
     * @param whStaff 员工信息
     * @return 结果
     */
    public int dismiss(WhStaff whStaff);


    /**
     * 判断是否存在关联关系
     * @param whStaff
     * @return
     */
    public boolean checkExistRelation(WhStaff whStaff);


    /**
     * 查询领薪人
     * @param whStaff
     * @return
     */
    List<WhStaff> listSalaryNames(WhStaff whStaff);

    /**
     * 根据父级查询员工信息列表
     *
     * @param whStaff 员工信息
     * @return 员工信息集合
     */
    public List<WhStaff> selectWhStaffListByParent(WhStaff whStaff);

    /**
     * 查询最大级别组队信息
     * @param staffNo
     * @return
     */
    public WhStaff selectMaxStaff(String staffNo);

    /**
     * 查询全部下级-开发
     * @param whStaff
     * @return
     */
    public List<WhStaff> selectAllDevChildren(WhStaff whStaff);

    /**
     * 查询团队人数
     * @param staffId
     * @return
     */
    public Integer getTeamAmount(Long staffId);
}
