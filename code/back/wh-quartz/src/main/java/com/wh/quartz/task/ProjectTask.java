package com.wh.quartz.task;

import com.wh.work.domain.WhTask;
import com.wh.work.service.IWhTaskService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

/**
 * 项目定时任务
 * 
 * @author wh
 */
@Component("projectTask")
@Slf4j
public class ProjectTask
{

    @Autowired
    private IWhTaskService iWhTaskService;

    public void genCycleTask() throws Exception{

        log.info("genTask start....");

        //查询工时任务列表,周期性
        List<WhTask> taskList = iWhTaskService.selectCycleTaskList();
        if (CollectionUtils.isNotEmpty(taskList)){
            //遍历生成月任务
            WhTask task;
            for(WhTask whTask : taskList){
                task = new WhTask();
                task.setParentId(whTask.getParentId());
                task.setProjectId(whTask.getProjectId());
                task.setProjectType(whTask.getProjectType());
                task.setAppName(whTask.getAppName());
                task.setStaffId(whTask.getStaffId());
                task.setParticipationMethods(whTask.getParticipationMethods());
                if (whTask.getParticipationMethods() == 3){
                    task.setStage(1);
                } else{
                    task.setStage(2);
                }
                task.setStaffNo(whTask.getStaffNo());
                task.setDescription(whTask.getDescription());
                task.setLinkUrl(whTask.getLinkUrl());
                task.setQrCode(whTask.getQrCode());
                task.setDistributeStatus(1);
                task.setDistributionTime(new Date());
                task.setCycleType(3);
                task.setCreateBy(whTask.getCreateBy());
                try{
                    iWhTaskService.insertWhTask(task);
                }catch (Exception e){
                    log.info("genTask {" + whTask.getId() +","+whTask.getAppName() +"}出现异常...." + e.getMessage());
                }

            }
        }

        log.info("genTask end....");

    }

}
