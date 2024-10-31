package com.wh.work.service.impl;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

import com.wh.common.core.domain.entity.SysUser;
import com.wh.common.utils.DateUtils;
import com.wh.system.service.ISysUserService;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.wh.work.mapper.WhProjectMapper;
import com.wh.work.domain.WhProject;
import com.wh.work.service.IWhProjectService;

/**
 * 项目Service业务层处理
 * 
 * @author wxd
 * @date 2023-07-26
 */
@Service
public class WhProjectServiceImpl implements IWhProjectService 
{
    @Autowired
    private WhProjectMapper whProjectMapper;

    @Autowired
    private ISysUserService userService;

    /**
     * 查询项目
     * 
     * @param id 项目主键
     * @return 项目
     */
    @Override
    public WhProject selectWhProjectById(Long id)
    {
        return whProjectMapper.selectWhProjectById(id);
    }

    /**
     * 查询项目列表
     * 
     * @param whProject 项目
     * @return 项目
     */
    @Override
    public List<WhProject> selectWhProjectList(WhProject whProject)
    {
        List<WhProject> projectList = whProjectMapper.selectWhProjectList(whProject);
        if (CollectionUtils.isNotEmpty(projectList)){
            // 遍历查询项目负责人
            SysUser sysUser = new SysUser();
            sysUser.setStatus("0");
            List<SysUser> userList = userService.selectUserList(sysUser);
            Map<String, SysUser> userMap;
            if (CollectionUtils.isNotEmpty(userList)){
                userMap = userList.stream().collect(Collectors.toMap(SysUser::getUserName, Function.identity(), (k1,k2)->k2));
            }else{
                userMap = new HashMap<>();
            }

            List<String> projectLeaders;
            for (WhProject project : projectList){
                projectLeaders = new ArrayList<>();
                String projectLeader = project.getProjectLeader();
                if (projectLeader != null){
                    String[] leaderArray = projectLeader.split(",");
                    for (String leader : leaderArray){
                        if (userMap.containsKey(leader)){
                            projectLeaders.add(userMap.get(leader).getNickName());
                        }
                    }
                }
                project.setProjectLeaders(projectLeaders);
            }

        }
        return projectList;
    }

    /**
     * 查询项目列表
     *
     * @param whProject 项目
     * @return 项目
     */
    @Override
    public List<WhProject> selectAllProjectList(WhProject whProject)
    {
        return whProjectMapper.selectWhProjectList(whProject);
    }

    @Override
    public List<WhProject> selectStaffProjectList(WhProject whProject) {
        return whProjectMapper.selectStaffProjectList(whProject);
    }

    /**
     * 新增项目
     * 
     * @param whProject 项目
     * @return 结果
     */
    @Override
    public int insertWhProject(WhProject whProject)
    {
        whProject.setCreateTime(DateUtils.getNowDate());
        if (whProject.getProjectSource() == 2){
            //生成项目编号
            whProject.setProjectNo(genProjectNo());
        }
        //转化项目负责人
        if (CollectionUtils.isNotEmpty(whProject.getProjectLeaders())){
            whProject.setProjectLeader(String.join(",", whProject.getProjectLeaders()));
        }
        //转化分支类型
        if (CollectionUtils.isNotEmpty(whProject.getBranchTypes())){
            whProject.setBranchType(String.join(",", whProject.getBranchTypes()));
        }
        return whProjectMapper.insertWhProject(whProject);
    }

    /**
     * 修改项目
     * 
     * @param whProject 项目
     * @return 结果
     */
    @Override
    public int updateWhProject(WhProject whProject)
    {
        whProject.setUpdateTime(DateUtils.getNowDate());
        //转化项目负责人
        if (CollectionUtils.isNotEmpty(whProject.getProjectLeaders())){
            whProject.setProjectLeader(String.join(",", whProject.getProjectLeaders()));
        }
        //转化分支类型
        if (CollectionUtils.isNotEmpty(whProject.getBranchTypes())){
            whProject.setBranchType(String.join(",", whProject.getBranchTypes()));
        }
        return whProjectMapper.updateWhProject(whProject);
    }

    /**
     * 批量删除项目
     * 
     * @param ids 需要删除的项目主键
     * @return 结果
     */
    @Override
    public int deleteWhProjectByIds(Long[] ids)
    {
        return whProjectMapper.deleteWhProjectByIds(ids);
    }

    /**
     * 删除项目信息
     * 
     * @param id 项目主键
     * @return 结果
     */
    @Override
    public int deleteWhProjectById(Long id)
    {
        return whProjectMapper.deleteWhProjectById(id);
    }

    @Override
    public boolean checkProjectNameUnique(String projectName) {
        int number = whProjectMapper.selectExistProjectName(projectName);
        return number > 0;
    }

    @Override
    public int updateProjectByNo(WhProject whProject) {
        return whProjectMapper.updateProjectByNo(whProject);
    }

    @Override
    public int deleteProjectByNo(WhProject whProject) {
        return whProjectMapper.deleteProjectByNo(whProject);
    }

    /**
     * 生成项目编号/4位流水号
     * @return
     */
    private String genProjectNo(){
        String teamNo = "";
        //查询库中最大值
        String maxPojectNo = whProjectMapper.selectMaxProjectNo();
        if (null != maxPojectNo){
            int number = Integer.parseInt(maxPojectNo) + 1;
            teamNo = String.format("%04d", number);
        }else{
            teamNo = "0000";
        }

        return teamNo;

    }
}
