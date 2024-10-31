package com.wh.work.service;

import java.util.List;

import com.wh.work.domain.WhProject;
import com.wh.work.domain.WhTask;
import com.wh.work.domain.vo.WhJudgeTaskVO;
import com.wh.work.domain.vo.WhTaskStatisticsReqVO;
import com.wh.work.domain.vo.WhTaskStatisticsRespVO;

/**
 * 任务Service接口
 * 
 * @author wxd
 * @date 2023-05-17
 */
public interface IWhTaskService 
{
    /**
     * 查询任务
     * 
     * @param id 任务主键
     * @return 任务
     */
    public WhTask selectWhTaskById(Long id);

    /**
     * 查询任务
     *
     * @param appName 应用名称
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
     * 查询开发人员任务列表
     *
     * @param whTask 任务
     * @return 任务集合
     */
    public List<WhTask> selectDevWhTaskList(WhTask whTask);

    /**
     * 查询任务列表
     *
     * @param whTask 任务
     * @return 任务集合
     */
    public List<WhTask> selectSingleList(WhTask whTask);

    /**
     * 查询所有父级任务列表
     *
     * @param id 任务
     * @return 任务集合
     */
    public List<WhTask> selectAllParents(Long id);

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
     * 领薪分配工时
     *
     * @param whTask 任务
     * @return 结果
     */
    public int distribute(WhTask whTask);

    /**
     * 查询任务列表
     *
     * @return 任务集合
     */
    public List<WhTask> listAppNames();

    /**
     * 查询项目名称列表
     *
     * @return 任务集合
     */
    public List<WhProject> listProjectNames(String staffNo);

    /**
     * 查询员工列表
     *
     * @return 任务集合
     */
    public List<WhTask> listStaffNames(List<String> staffNos);

    /**
     * 查询标签列表
     *
     * @return 任务集合
     */
    public List<WhTask> listAllTags(WhTask whTask);

    /**
     * 查询分配人员工列表
     *
     * @return 任务集合
     */
    public List<WhTask> listDistributeNames();

    /**
     * 批量删除任务
     * 
     * @param ids 需要删除的任务主键集合
     * @return 结果
     */
    public int deleteWhTaskByIds(Long[] ids);

    /**
     * 删除任务信息
     * 
     * @param id 任务主键
     * @return 结果
     */
    public int deleteWhTaskById(Long id);

    /**
     * 根据staffId判断是否存在
     * @param staffId
     * @return
     */
    public int checkExistByStaffId(Long staffId);

    /**
     * 根据staffId及stage判断是否存在
     * @param staffId
     * @return
     */
    public int checkExistByStage(Long staffId);

    /**
     * 查询周期性任务列表
     * @return 任务集合
     */
    List<WhTask> selectCycleTaskList();

    /**
     * 判断任务是否存在
     * @param whTask
     * @return
     */
    public String judgeExistTask(WhTask whTask);

    /**
     * 查询最新任务列表
     *
     * @return 任务集合
     */
    public WhTask getLatestTask(WhTask whTask);

    /**
     * 查询分支认知
     * @param whTask
     * @return
     */
    public List<WhTask> getBranchTask(WhTask whTask);

    /**
     * 修改任务下发状态
     *
     * @param whTask 任务
     * @return 结果
     */
    public int updateDistributeStatus(WhTask whTask);


}
