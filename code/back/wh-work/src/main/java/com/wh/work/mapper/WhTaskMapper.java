package com.wh.work.mapper;

import java.util.List;

import com.wh.work.domain.WhProject;
import com.wh.work.domain.WhTask;
import com.wh.work.domain.vo.WhTaskRelativeRespVO;
import com.wh.work.domain.vo.WhTaskStatisticsReqVO;
import com.wh.work.domain.vo.WhTaskStatisticsRespVO;
import org.apache.ibatis.annotations.Param;

/**
 * 任务Mapper接口
 * 
 * @author wxd
 * @date 2023-05-17
 */
public interface WhTaskMapper 
{
    /**
     * 查询任务
     * 
     * @param id 任务主键
     * @return 任务
     */
    public WhTask selectWhTaskById(Long id);

    /**
     * 查询最新任务
     *
     * @param appName 任务主键
     * @return 任务
     */
    public WhTask selectLastByAppName(String appName);

    /**
     * 查询任务列表
     *
     * @param whTask 任务
     * @return 任务集合
     */
    public List<WhTask> selectWhTaskList(WhTask whTask);

    /**
     * 根据父节点查询任务列表
     *
     * @param parentId 父id
     * @return 任务集合
     */
    public List<WhTask> selectTaskByParentId(@Param("parentId") Long parentId);


    /**
     * 查询开发人员任务列表
     *
     * @param whTask 任务
     * @return 任务集合
     */
    public List<WhTask> selectDevWhTaskList(WhTask whTask);

    /**
     * 查询单个员工任务列表
     *
     * @param whTask 任务
     * @return 任务集合
     */
    public List<WhTask> selectSingleList(WhTask whTask);

    /**
     * 查询员工所有父级
     *
     * @param id 任务
     * @return 任务集合
     */
    public List<WhTask> selectAllParents(@Param("id") Long id);

    /**
     * 新增任务
     * 
     * @param whTask 任务
     * @return 结果
     */
    public int insertWhTask(WhTask whTask);

    /**
     * 修改任务
     * 
     * @param whTask 任务
     * @return 结果
     */
    public int updateWhTask(WhTask whTask);

    /**
     * 查询应用名称列表
     *
     * @return 任务集合
     */
    public List<WhTask> selectAppNames();

    /**
     * 查询所有tag编号
     * @param whTask
     * @return
     */
    public List<WhTask> selectAllTags(WhTask whTask);

    /**
     * 查询应用名称列表
     *
     * @return 任务集合
     */
    public List<WhProject> selectProjectNames(@Param("staffNo") String staffNo);

    /**
     * 查询员工名称列表
     *
     * @return 任务集合
     */
    public List<WhTask> selectStaffNames(@Param("staffNos") List<String> staffNos);

    /**
     * 查询分配人名称列表
     *
     * @return 任务集合
     */
    public List<WhTask> selectDistributeNames();

    /**
     * 删除任务
     * 
     * @param id 任务主键
     * @return 结果
     */
    public int deleteWhTaskById(Long id);

    /**
     * 批量删除任务
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteWhTaskByIds(Long[] ids);

    /**
     * 根据staffId查询数量
     * @param staffId
     * @return
     */
    public int countByStaffId(@Param("staffId") Long staffId);

    /**
     * 根据staffId查询数量
     * @param staffId
     * @return
     */
    public int countByStage(@Param("staffId") Long staffId);

    /**
     * 查询周期性任务
     * @return
     */
    public List<WhTask> selectCycleTaskList();

    /**
     * 获取最新任务
     * @param task
     * @return
     */
    public WhTask selectLatestTask(WhTask task);

    /**
     * 查询分支任务
     * @param task
     * @return
     */
    public List<WhTask> selectBranchTask(WhTask task);

    /**
     * 查询未完成的任务
     * @param task
     * @return
     */
    public List<WhTask> selectIncompleteList(WhTask task);

}
