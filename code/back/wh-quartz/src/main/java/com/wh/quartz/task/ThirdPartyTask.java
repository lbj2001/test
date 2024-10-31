package com.wh.quartz.task;

import com.sun.org.apache.bcel.internal.generic.IF_ACMPEQ;
import com.wh.common.core.domain.entity.SysUser;
import com.wh.common.utils.SecurityUtils;
import com.wh.common.utils.StringUtils;
import com.wh.common.utils.Threads;
import com.wh.quartz.domain.SysJob;
import com.wh.quartz.service.ISysJobService;
import com.wh.system.domain.vo.ThirdPartyProjectVo;
import com.wh.system.domain.vo.ThirdPartyUserVo;
import com.wh.system.service.ISysUserService;
import com.wh.system.service.IThirdPartyProjectService;
import com.wh.system.service.IThirdPartyUserService;
import com.wh.work.domain.WhProject;
import com.wh.work.domain.WhProjectOrigin;
import com.wh.work.service.IWhProjectOriginService;
import com.wh.work.service.IWhProjectService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.quartz.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

/**
 * 三方调度定时任务
 * 
 * @author wh
 */
@Component("thirdPartyTask")
@Slf4j
public class ThirdPartyTask
{

    @Autowired
    private IThirdPartyUserService iThirdPartyUserService;

    @Autowired
    private IThirdPartyProjectService iThirdPartyProjectService;

    @Autowired
    private ISysJobService iSysJobService;

    @Autowired
    private ISysUserService iSysUserService;

    @Autowired
    private IWhProjectService iWhProjectService;

    @Autowired
    private IWhProjectOriginService iWhProjectOriginService;

    //@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
    public void syncThirdPartyUsers(Long jobId) throws SchedulerException {

        log.info("start sync user....");
        SysJob sysJob = iSysJobService.selectJobById(jobId);
        if (sysJob == null){
            log.info("任务不存在");
        }

        LocalDate currentDate = LocalDate.now();
        int status = iThirdPartyUserService.checkLogStatus(currentDate.toString());
        //判断三方批任务是否执行完成
        if (status == 1){
            //同步人员
            LocalDate preDate = LocalDate.now().minusDays(1);
            List<ThirdPartyUserVo> userVoList = iThirdPartyUserService.getUserList(preDate.toString());
            if (CollectionUtils.isNotEmpty(userVoList)){
                //遍历同步
                SysUser sysUser;
                for(ThirdPartyUserVo userVo : userVoList){
                    sysUser = new SysUser();
                    sysUser.setUserName(userVo.getRyh());
                    sysUser.setNickName(userVo.getXm());
                    sysUser.setPhonenumber(userVo.getSj());
                    sysUser.setBank(userVo.getKhzh());
                    sysUser.setAccount(userVo.getKhyhzh());
                    // 人司关系 11 劳动关系 12 外协开发
                    if (StringUtils.isNotEmpty(userVo.getRsgx())){
                        if ("11".equals(userVo.getRsgx())){
                            sysUser.setHumanCompanyRelation(1);
                        }else if ("12".equals(userVo.getRsgx())){
                            sysUser.setHumanCompanyRelation(2);
                        }
                    }
                    if (userVo.getDataType() == 1){
                        if (!iSysUserService.checkUserNameUnique(sysUser)){
                            log.error("新增用户[{}]失败，登录账号已存在", sysUser.getUserName());
                            continue;
                        }
                        sysUser.setPassword(SecurityUtils.encryptPassword("Dfyj123"));
                        sysUser.setFirstCooperationTime(new Date());
                        //初始化禁用
                        sysUser.setStatus("1");
                        sysUser.setCreateBy("admin");
                        iSysUserService.insertUser(sysUser);
                    }else{
                        sysUser.setUpdateBy("admin");
                        iSysUserService.updateUserByUserName(sysUser);
                    }
                }
            }

        } else{
            Threads.sleep(1800000);
            iSysJobService.run(sysJob);
        }

        log.info("end sync user....");

    }

    public void syncThirdPartyProject(Long jobId) throws SchedulerException {

        log.info("start sync project ....");
        SysJob sysJob = iSysJobService.selectJobById(jobId);
        if (sysJob == null){
            log.info("同步项目任务不存在");
        }

        LocalDate currentDate = LocalDate.now();
        int status = iThirdPartyProjectService.checkLogStatus(currentDate.toString());
        //判断三方批任务是否执行完成
        if (status == 1){
            //同步项目
            LocalDate preDate = LocalDate.now().minusDays(1);
            List<ThirdPartyProjectVo> projectVoList = iThirdPartyProjectService.getProjectList(preDate.toString());
            if (CollectionUtils.isNotEmpty(projectVoList)){
                //遍历同步
                WhProject whProject;
                WhProjectOrigin whProjectOrigin;
                for(ThirdPartyProjectVo projectVo : projectVoList){
                    try{
                        //项目表
                        whProject = new WhProject();
                        whProject.setProjectNo(projectVo.getItzcbh());
                        whProject.setSummaryNo(projectVo.getZybh());

                        // 判断项目是否已存在，
                        List<WhProject> whProjects = iWhProjectService.selectAllProjectList(whProject);
                        if (CollectionUtils.isEmpty(whProjects)){
                            // 1 同步新增
                            whProject.setMainProjectName(projectVo.getItzcmc());
                            whProject.setProjectName(projectVo.getZyxxmxqc());
                            whProject.setProjectSource(1);
                            whProject.setCycleType(1);
                            whProject.setWorkHoursThreshold(new BigDecimal(50));
                            whProject.setStatus(1);
                            whProject.setCreateBy("admin");
                            if (projectVo.getIsDelete()==1){
                                whProject.setDelFlag("1");
                            }
                            iWhProjectService.insertWhProject(whProject);
                        }else {
                            // 项目名称修改
                            WhProject existProject = whProjects.get(0);
                            if (projectVo.getDataType() == 2){
                                // 删除
                                if (projectVo.getIsDelete()==1){
//                                    existProject.setDelFlag("1");
//                                    existProject.setUpdateBy("admin");
//                                    iWhProjectService.updateWhProject(existProject);
                                    // 修改
                                } else {
                                    if (existProject.getMainProjectName() == null
                                            || existProject.getProjectName() == null
                                            || !existProject.getMainProjectName().equals(projectVo.getItzcmc())
                                            || !existProject.getProjectName().equals(projectVo.getZyxxmxqc())){
                                        existProject.setMainProjectName(projectVo.getItzcmc());
                                        existProject.setProjectName(projectVo.getZyxxmxqc());
                                        existProject.setUpdateBy("admin");
                                        iWhProjectService.updateWhProject(existProject);
                                    }
                                }
                            }

                        }

                        // 判断是否已同步
                        WhProjectOrigin existOrigin = iWhProjectOriginService.selectWhProjectOriginBySyncId(projectVo.getId());
                        //未同步
                        if (existOrigin == null){
                            //项目来源表
                            whProjectOrigin = new WhProjectOrigin();
                            whProjectOrigin.setProjectNo(projectVo.getItzcbh());
                            whProjectOrigin.setSummaryNo(projectVo.getZybh());
                            whProjectOrigin.setCodeSourceNo(projectVo.getDmyyjxzybh());
                            whProjectOrigin.setSyncId(projectVo.getId());
                            //判断是否新增
                            if (projectVo.getDataType() == 1){
                                whProjectOrigin.setProjectName(projectVo.getZyxxmxqc());
                                whProjectOrigin.setCreateBy("admin");
                                iWhProjectOriginService.insertWhProjectOrigin(whProjectOrigin);
                            }else {
                                if (projectVo.getIsDelete()==1){
                                    whProjectOrigin.setDelFlag("1");
                                } else {
                                    whProjectOrigin.setDelFlag("0");
                                    whProjectOrigin.setProjectName(projectVo.getZyxxmxqc());
                                }
                                whProjectOrigin.setUpdateBy("admin");
                                iWhProjectOriginService.updateProjectOriginByNo(whProjectOrigin);

                                //级联判断主项目是否可删除，主项目下是否存在其他子项目
                                if (projectVo.getIsDelete()==1){
                                    // 查询其他子项
                                    WhProjectOrigin projectOrigin = new WhProjectOrigin();
                                    projectOrigin.setProjectNo(projectVo.getItzcbh());
                                    projectOrigin.setSummaryNo(projectVo.getZybh());
                                    List<WhProjectOrigin> originList = iWhProjectOriginService.selectWhProjectOriginList(projectOrigin);
                                    if (CollectionUtils.isEmpty(originList)){
                                        // 删除主项目
                                        WhProject delProject = new WhProject();
                                        delProject.setProjectNo(projectVo.getItzcbh());
                                        delProject.setSummaryNo(projectVo.getZybh());
                                        iWhProjectService.deleteProjectByNo(delProject);
                                    }
                                }
                            }
                        }

                    }catch(Exception e){
                        log.error("同步项目[{}]出现异常{}", projectVo.getZyxxmxqc(), e);
                    }
                }
            }

        } else{
            Threads.sleep(1800000);
            iSysJobService.run(sysJob);
        }

        log.info("end sync project....");

    }

}
