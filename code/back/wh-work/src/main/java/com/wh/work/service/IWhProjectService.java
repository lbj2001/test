package com.wh.work.service;

import java.util.List;
import com.wh.work.domain.WhProject;

/**
 * 项目Service接口
 * 
 * @author wxd
 * @date 2023-07-26
 */
public interface IWhProjectService 
{
    /**
     * 查询项目
     * 
     * @param id 项目主键
     * @return 项目
     */
    public WhProject selectWhProjectById(Long id);

    /**
     * 查询项目列表
     * 
     * @param whProject 项目
     * @return 项目集合
     */
    public List<WhProject> selectWhProjectList(WhProject whProject);

    /**
     * 查询全部项目列表
     *
     * @param whProject 项目
     * @return 项目集合
     */
    public List<WhProject> selectAllProjectList(WhProject whProject);

    /**
     * 查询员工项目列表
     *
     * @param whProject 项目
     * @return 项目集合
     */
    public List<WhProject> selectStaffProjectList(WhProject whProject);

    /**
     * 新增项目
     * 
     * @param whProject 项目
     * @return 结果
     */
    public int insertWhProject(WhProject whProject);

    /**
     * 修改项目
     * 
     * @param whProject 项目
     * @return 结果
     */
    public int updateWhProject(WhProject whProject);

    /**
     * 批量删除项目
     * 
     * @param ids 需要删除的项目主键集合
     * @return 结果
     */
    public int deleteWhProjectByIds(Long[] ids);

    /**
     * 删除项目信息
     * 
     * @param id 项目主键
     * @return 结果
     */
    public int deleteWhProjectById(Long id);

    /**
     * 校验项目名唯一
     * @param projectName
     */
    boolean checkProjectNameUnique(String projectName);

    /**
     * 根据编号更新项目
     * @param whProject
     * @return
     */
    int updateProjectByNo(WhProject whProject);

    /**
     * 根据编号及摘要编号更新项目
     * @param whProject
     * @return
     */
    int deleteProjectByNo(WhProject whProject);
}
