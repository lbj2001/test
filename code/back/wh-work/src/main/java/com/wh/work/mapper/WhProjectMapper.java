package com.wh.work.mapper;

import java.util.List;
import com.wh.work.domain.WhProject;

/**
 * 项目Mapper接口
 * 
 * @author wxd
 * @date 2023-07-26
 */
public interface WhProjectMapper 
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
     * 删除项目
     * 
     * @param id 项目主键
     * @return 结果
     */
    public int deleteWhProjectById(Long id);

    /**
     * 批量删除项目
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteWhProjectByIds(Long[] ids);

    /**
     * 查询最大流水编号
     * @return
     */
    public String selectMaxProjectNo();

    /**
     * 查询项目名是否存在
     * @param projectName
     * @return
     */
    int selectExistProjectName(String projectName);

    /**
     * 根据编号更新项目
     * @param whProject
     * @return
     */
    int updateProjectByNo(WhProject whProject);

    /**
     * 根据编号删除项目
     * @param whProject
     * @return
     */
    int deleteProjectByNo(WhProject whProject);
}
