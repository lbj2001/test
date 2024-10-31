package com.wh.work.service.impl;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

import com.wh.common.core.domain.entity.SysUser;
import com.wh.common.utils.DateUtils;
import com.wh.common.utils.StringUtils;
import com.wh.system.service.ISysUserService;
import com.wh.work.domain.*;
import com.wh.work.domain.vo.WhJudgeTaskVO;
import com.wh.work.service.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.wh.work.mapper.WhTaskMapper;
import org.springframework.transaction.annotation.Transactional;

/**
 * 任务Service业务层处理
 * 
 * @author wxd
 * @date 2023-05-17
 */
@Service
@Slf4j
public class WhTaskServiceImpl implements IWhTaskService 
{
    @Autowired
    private WhTaskMapper whTaskMapper;

    @Autowired
    private IWhTaskDistributionService iWhTaskDistributionService;

    @Autowired
    private IWhSalaryDistributionService iWhSalaryDistributionService;

    @Autowired
    private IWhTaskStatisticsService iWhTaskStatisticsService;

    @Autowired
    private IWhStaffService iWhStaffService;

    @Autowired
    private IWhProjectService projectService;

    @Autowired
    private IWhClaimDetailService claimDetailService;

    @Autowired
    private IWhClaimDetailItemService claimDetailItemService;

    @Autowired
    private IWhVideoRecordService videoRecordService;

    @Autowired
    private IWhVideoRecordDetailService videoRecordDetailService;

    @Autowired
    private ISysUserService sysUserService;

    @Value("${work.task.prefix}")
    private String taskPrefix;

    private static final SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");

    /**
     * 查询任务
     * 
     * @param id 任务主键
     * @return 任务
     */
    @Override
    @Transactional
    public WhTask selectWhTaskById(Long id)
    {
        WhTask task =  whTaskMapper.selectWhTaskById(id);
        //查询申报工时明细
        WhClaimDetail claimDetail = new WhClaimDetail();
        claimDetail.setTaskId(task.getId());
        List<WhClaimDetail> claimDetailList = claimDetailService.selectWhClaimDetailList(claimDetail);
        if (CollectionUtils.isNotEmpty(claimDetailList)){
            List<Long> claimIds = claimDetailList.stream().map(WhClaimDetail::getId).collect(Collectors.toList());
            WhClaimDetailItem detailItem = new WhClaimDetailItem();
            detailItem.setClaimIds(claimIds);
            List<WhClaimDetailItem> detailList = claimDetailItemService.selectWhClaimDetailItemList(detailItem);
            Map<Long,List<WhClaimDetailItem>> detailMap = new HashMap<>();
            if (CollectionUtils.isNotEmpty(detailList)){
                detailMap = detailList.stream().collect(Collectors.groupingBy(WhClaimDetailItem::getClaimId));
            }
            for (WhClaimDetail detail : claimDetailList){
                if (detailMap.containsKey(detail.getId())){
                    detail.setClaimDetailItemList(detailMap.get(detail.getId()));
                }
            }
        }


        task.setClaimDetailList(claimDetailList);

        //查询分配工时明细
        WhTaskDistribution distribution = new WhTaskDistribution();
        distribution.setTaskId(task.getId());
        List<WhTaskDistribution> distributionList = iWhTaskDistributionService.selectWhTaskDistributionList(distribution);
        // 工时小计
        if (CollectionUtils.isNotEmpty(distributionList)){
            for (WhTaskDistribution taskDistribution: distributionList){
                taskDistribution.setSubTotal(taskDistribution.getWorkingHours().multiply(taskDistribution.getWorkingPrice()));
            }
        }
        task.setDistributionList(distributionList);
        return task;
    }

    @Override
    public WhTask selectLastByAppName(String appName)
    {
        WhTask task =  whTaskMapper.selectLastByAppName(appName);
        //查询分配工时
        WhTaskDistribution distribution = new WhTaskDistribution();
        distribution.setTaskId(task.getId());
        List<WhTaskDistribution> distributionList = iWhTaskDistributionService.selectWhTaskDistributionList(distribution);
        task.setDistributionList(distributionList);
        return task;
    }

    /**
     * 查询任务列表
     * 
     * @param whTask 任务
     * @return 任务
     */
    @Override
    public List<WhTask> selectWhTaskList(WhTask whTask)
    {
        return whTaskMapper.selectWhTaskList(whTask);
    }

    /**
     * 查询开发人员任务列表
     *
     * @param whTask 任务
     * @return 任务
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public List<WhTask> selectDevWhTaskList(WhTask whTask)
    {
        List<WhTask> taskList = whTaskMapper.selectDevWhTaskList(whTask);
        // 更新任务状态
        List<WhTask> closeTasks = taskList.stream().filter(t->t.getStatus() == 0).collect(Collectors.toList());

        for (WhTask closeTask : closeTasks){
            try{
                Duration duration = Duration.between(closeTask.getDistributionTime().toInstant(), Instant.now());
                if (duration.toDays() > 30L){
                    closeTask.setSubmitTime(new Date());
                    closeTask.setSpendTime(30);
                    closeTask.setWorkingHours(BigDecimal.ZERO);
                    closeTask.setPaidHours(BigDecimal.ZERO);
                    //申报年月
                    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM");
                    String monthStr = LocalDate.now().format(fmt);
                    closeTask.setMonth(monthStr);
                    closeTask.setTagNo("空");
                    closeTask.setStatus(9);
                    whTaskMapper.updateWhTask(closeTask);
                }
            } catch (Exception e){
                log.error("更新任务状态失败{}", closeTask.getId());
            }

        }
        return taskList;
    }

    /**
     * 查询单人任务列表
     *
     * @param whTask 任务
     * @return 任务
     */
    @Override
    public List<WhTask> selectSingleList(WhTask whTask)
    {
        return whTaskMapper.selectSingleList(whTask);
    }

    /**
     * 查询所有父级任务列表
     *
     * @param id
     * @return 任务集合
     */
    @Override
    public List<WhTask> selectAllParents(Long id){
        return whTaskMapper.selectAllParents(id);
    }

    /**
     * 新增任务
     * 
     * @param whTask 任务
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertWhTask(WhTask whTask)
    {
        //自动生成任务编号
        whTask.setTaskNo(genTaskNo());
        whTask.setCreateTime(DateUtils.getNowDate());
        //判断开发人员是否有任务未完成申报，若有，无法进行分配新任务
        if (whTask.getDistributeStatus()!= null && whTask.getDistributeStatus() == 1){
            checkExistStaffTask(whTask);

            //判断分支下是否有未完成申报任务
            //查看项目类型
            WhProject project = projectService.selectWhProjectById(whTask.getProjectId());
            if (project != null && project.getProjectType() == 1){
                List<WhTask> branchList = this.getBranchTask(whTask);
                if (CollectionUtils.isNotEmpty(branchList)){
                    throw new RuntimeException("该分支下尚有任务未完成工时申报，无法进行新任务下发");
                }
            }
        }

        //子任务状态
        if (whTask.getParticipationMethods() == 3){
            whTask.setStage(1);//无需分配
        }else{
            whTask.setStage(2);//等待分配
        }
        //修改父任务状态
        if (!whTask.getParentId().equals(0L)){

            //查询父任务状态，如果父任务暂存待发，子任务不可进行立即下发
            WhTask parentTask = whTaskMapper.selectWhTaskById(whTask.getParentId());
            if (parentTask.getDistributeStatus() == 0 && whTask.getDistributeStatus() == 1){
                throw new RuntimeException("当前任务处于暂存待发状态，再次分配任务不可进行立即下发操作");
            }
            WhTask ta = new WhTask();
            ta.setId(whTask.getParentId());
            if ("0".equals(whTask.getIsCompleted())){
                ta.setStage(3);//正在分配
            }else{
                ta.setStage(4);//分配完成
            }
            whTaskMapper.updateWhTask(ta);
        }

        return whTaskMapper.insertWhTask(whTask);
    }

    /**
     * 检查是否存在分配任务
     * @param whTask
     */
    private void checkExistStaffTask(WhTask whTask) {
        if (whTask.getParticipationMethods() == 3 ){
            WhStaff whStaff = iWhStaffService.selectWhStaffById(whTask.getStaffId());
            //查询被分配人是否允许并行开发
            if (whStaff.getParallelFlag() == 0){
                boolean existFlag = false;
                if (whTask.getId() != null){
                    WhTask task = new WhTask();
                    task.setId(whTask.getId());
                    task.setStaffId(whTask.getStaffId());
                    task.setStatus(0);
                    List<WhTask> existList = whTaskMapper.selectIncompleteList(task);
                    if (CollectionUtils.isNotEmpty(existList)){
                        existFlag = true;
                    }
                }else{
                    existFlag = checkExistByStaffId(whTask.getStaffId()) > 0;
                }
                if (existFlag){
                    throw new RuntimeException("被分配人尚有任务未完成工时申报，无法进行新任务分配");
                }
            }else{
                //查询同一项目是否存在未全量发布, IT发布任务无需进行校验
                if (whTask.getProjectType() != 3){
                    WhTask fullTask = new WhTask();
                    fullTask.setProjectId(whTask.getProjectId());
                    WhTask latestTask = whTaskMapper.selectLatestTask(fullTask);
                    //1、全量发布
                    if(latestTask != null && latestTask.getReleaseFlag() == 1) {
                        throw new RuntimeException("本项目正在全量发布中，需要在工时申报菜单中将上一条标记为全量成功或全量失败后，才能针对本项目继续发布任务");
                    }
                }

                //允许并行开发，但必须是不同的项目
                WhTask parallelTask = new WhTask();
                parallelTask.setId(whTask.getId());
                parallelTask.setStaffId(whTask.getStaffId());
                parallelTask.setStatus(0);
                parallelTask.setDistributeStatus(1);
                parallelTask.setProjectId(whTask.getProjectId());
                List<WhTask> existList = whTaskMapper.selectIncompleteList(parallelTask);
                if (CollectionUtils.isNotEmpty(existList)){
                    throw new RuntimeException("被分配人同一项目尚有任务未完成工时申报，无法进行新任务分配");
                }
            }
            // whTask.getParticipationMethods() == 2
        } else if (whTask.getParticipationMethods() == 1){
            boolean existing = false;
            if (whTask.getId() != null){
                WhTask task = new WhTask();
                task.setId(whTask.getId());
                task.setStaffId(whTask.getStaffId());
                task.setStage(2);
                List<WhTask> existList = whTaskMapper.selectIncompleteList(task);
                if (CollectionUtils.isNotEmpty(existList)){
                    existing = true;
                }
            }else{
                existing = checkExistByStage(whTask.getStaffId()) > 0;
            }
            if (existing){
                throw new RuntimeException("被分配人已有任务，不能再次分配");
            }

        }
    }

    /**
     * 检查是否存在分配任务
     * @param whTask
     */
    private String checkExistParallelTask(WhTask whTask) {
        if (whTask.getParticipationMethods() == 3 ){
            //查询被分配人是否允许并行开发
            WhStaff whStaff = iWhStaffService.selectWhStaffById(whTask.getStaffId());
            //提示消息
            String existMsg = checkExistByStaffId(whTask.getStaffId()) > 0 ? "存在" : "不存在";
            String parallelMsg = whStaff.getParallelFlag() == 0 ? "禁止" : "允许";
            return "该人员【" + existMsg + "】正在开发的项目，且【"+parallelMsg+"】同步开发项目";
        }else{
            return null;
        }
    }

    /**
     * 修改任务
     * 
     * @param whTask 任务
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateWhTask(WhTask whTask)
    {
        whTask.setUpdateTime(DateUtils.getNowDate());
        //判断开发人员是否有任务未完成申报，若有，无法进行分配新任务
        if (whTask.getDistributeStatus()!= null && whTask.getDistributeStatus() == 1){
            checkExistStaffTask(whTask);
            //判断分支下是否有未完成申报任务
            //查看项目类型
            WhProject project = projectService.selectWhProjectById(whTask.getProjectId());
            if (project != null && project.getProjectType() == 1){
                List<WhTask> branchList = this.getBranchTask(whTask);
                if (CollectionUtils.isNotEmpty(branchList)){
                    throw new RuntimeException("该分支下尚有任务未完成工时申报，无法进行新任务下发");
                }
            }
        }

        if (StringUtils.isNotEmpty(whTask.getIsCompleted())){
            if ("0".equals(whTask.getIsCompleted())){
                whTask.setStage(3);//正在分配
            }else{
                whTask.setStage(4);//分配完成
            }
        }

        return whTaskMapper.updateWhTask(whTask);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int distribute(WhTask whTask) {
        whTask.setUpdateTime(DateUtils.getNowDate());
        int number = whTaskMapper.updateWhTask(whTask);

        // 暂存
        if(whTask.getStatus() == 10){
            // 查询已存在历史数据
            WhClaimDetail existDetail = new WhClaimDetail();
            existDetail.setTaskId(whTask.getId());
            List<WhClaimDetail> existDetailList = claimDetailService.selectWhClaimDetailList(existDetail);
            List<Long> existDetailIds;
            List<Long> existDetailItemIds;
            if (CollectionUtils.isNotEmpty(existDetailList)){
                existDetailIds = existDetailList.stream().map(WhClaimDetail::getId).collect(Collectors.toList());
                // 查询已存在详情
                WhClaimDetailItem existDetailItem = new WhClaimDetailItem();
                existDetailItem.setClaimIds(existDetailIds);
                List<WhClaimDetailItem> existDetailItemList =  claimDetailItemService.selectWhClaimDetailItemList(existDetailItem);
                if (CollectionUtils.isNotEmpty(existDetailItemList)){
                    existDetailItemIds = existDetailItemList.stream().map(WhClaimDetailItem::getId).collect(Collectors.toList());
                }else{
                    existDetailItemIds = new ArrayList<>();
                }
            }else{
                existDetailIds = new ArrayList<>();
                existDetailItemIds = new ArrayList<>();
            }

            // 工时申报详细
            if (CollectionUtils.isNotEmpty(whTask.getClaimDetailList())){
                List<Long> updateDetailIds = new ArrayList<>();
                List<Long> updateDetailItemIds = new ArrayList<>();
                for (WhClaimDetail claimDetail : whTask.getClaimDetailList()){
                    if (claimDetail.getId() != null){
                        claimDetail.setUpdateBy(whTask.getUpdateBy());
                        claimDetailService.updateWhClaimDetail(claimDetail);
                        updateDetailIds.add(claimDetail.getId());
                    }else{
                        claimDetail.setTaskId(whTask.getId());
                        claimDetail.setCreateBy(whTask.getUpdateBy());
                        claimDetailService.insertWhClaimDetail(claimDetail);
                    }
                    if (CollectionUtils.isNotEmpty(claimDetail.getClaimDetailItemList())){
                        for (WhClaimDetailItem detailItem : claimDetail.getClaimDetailItemList()){
                            if (detailItem.getId() != null){
                                detailItem.setUpdateBy(whTask.getUpdateBy());
                                claimDetailItemService.updateWhClaimDetailItem(detailItem);
                                updateDetailItemIds.add(detailItem.getId());
                            }else{
                                detailItem.setClaimId(claimDetail.getId());
                                detailItem.setCreateBy(whTask.getUpdateBy());
                                claimDetailItemService.insertWhClaimDetailItem(detailItem);
                            }
                        }
                    }
                }

                // 删除历史new
                if (CollectionUtils.isNotEmpty(existDetailIds)){
                    existDetailIds.removeAll(updateDetailIds);
                    if (CollectionUtils.isNotEmpty(existDetailIds)){
                        claimDetailService.deleteWhClaimDetailByIds(existDetailIds.toArray(new Long[0]));
                    }
                }
                if (CollectionUtils.isNotEmpty(existDetailItemIds)){
                    existDetailItemIds.removeAll(updateDetailItemIds);
                    if (CollectionUtils.isNotEmpty(existDetailItemIds)){
                        claimDetailItemService.deleteWhClaimDetailItemByIds(existDetailItemIds.toArray(new Long[0]));
                    }
                }

            }else{
                // 删除历史
                if (CollectionUtils.isNotEmpty(existDetailIds)){
                    claimDetailService.deleteWhClaimDetailByIds(existDetailIds.toArray(new Long[0]));
                }
                if (CollectionUtils.isNotEmpty(existDetailItemIds)){
                    claimDetailItemService.deleteWhClaimDetailItemByIds(existDetailItemIds.toArray(new Long[0]));
                }

            }

        }else{
            // 工时申报详细
            if (CollectionUtils.isNotEmpty(whTask.getClaimDetailList())){
                for (WhClaimDetail claimDetail : whTask.getClaimDetailList()){
                    if (claimDetail.getId() != null){
                        claimDetail.setUpdateBy(whTask.getUpdateBy());
                        claimDetailService.updateWhClaimDetail(claimDetail);
                    }else{
                        claimDetail.setTaskId(whTask.getId());
                        claimDetail.setCreateBy(whTask.getUpdateBy());
                        claimDetailService.insertWhClaimDetail(claimDetail);
                        if (claimDetail.getClaimType() == 1){
                            if (CollectionUtils.isNotEmpty(claimDetail.getClaimDetailItemList())){
                                for (WhClaimDetailItem detailItem : claimDetail.getClaimDetailItemList()){
                                    detailItem.setClaimId(claimDetail.getId());
                                    detailItem.setCreateBy(whTask.getUpdateBy());
                                    claimDetailItemService.insertWhClaimDetailItem(detailItem);

                                    //级联更新视频详情记录申报状态
                                    WhVideoRecordDetail videoRecordDetail = new WhVideoRecordDetail();
                                    videoRecordDetail.setId(detailItem.getRecordDetailId());
                                    videoRecordDetail.setClaimStatus(1);
                                    videoRecordDetailService.updateWhVideoRecordDetail(videoRecordDetail);
                                }
                                //级联更新视频记录申报状态,判断详情是否全部申报
                                List<Long> recordIds = claimDetail.getClaimDetailItemList().stream().map(WhClaimDetailItem::getRecordId).collect(Collectors.toList());
                                if (CollectionUtils.isNotEmpty(recordIds)){
                                    WhVideoRecordDetail recordDetail = new WhVideoRecordDetail();
                                    recordDetail.setClaimStatus(0);
                                    recordDetail.setTimeLimit(1);
                                    for (Long recordId : recordIds){
                                        recordDetail.setRecordId(recordId);
                                        List<WhVideoRecordDetail> detailList = videoRecordDetailService.selectWhVideoRecordDetailList(recordDetail);
                                        if (CollectionUtils.isEmpty(detailList)){
                                            WhVideoRecord videoRecord = new WhVideoRecord();
                                            videoRecord.setId(recordId);
                                            videoRecord.setClaimStatus(1);
                                            videoRecordService.updateWhVideoRecord(videoRecord);
                                        }
                                    }
                                }
                            }
                        }else{
                            if (CollectionUtils.isNotEmpty(claimDetail.getClaimDetailItemList())){
                                for (WhClaimDetailItem detailItem : claimDetail.getClaimDetailItemList()){
                                    if (detailItem.getId() != null){
                                        detailItem.setUpdateBy(whTask.getUpdateBy());
                                        claimDetailItemService.updateWhClaimDetailItem(detailItem);
                                    }else{
                                        detailItem.setClaimId(claimDetail.getId());
                                        detailItem.setCreateBy(whTask.getUpdateBy());
                                        claimDetailItemService.insertWhClaimDetailItem(detailItem);
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // 工时分配详细
            if (CollectionUtils.isNotEmpty(whTask.getDistributionList())){
                for (WhTaskDistribution distribution: whTask.getDistributionList()){
                    distribution.setCreateBy(whTask.getUpdateBy());
                    distribution.setDistributeTime(whTask.getSubmitTime());
                    //分配比例
                    BigDecimal ratio = distribution.getWorkingHours().divide(whTask.getWorkingHours(),2, RoundingMode.HALF_UP)
                            .multiply(new BigDecimal(100));
                    distribution.setDistributeRatio(ratio);
                    //汇总工时,判断当前月是否已存在记录,若存在进行累加，不存在进行创建
                    this.handleDistribution(whTask.getMonth(), distribution);
                }
            }

            //判断员工是否有上级，查询上级
            WhStaff child = new WhStaff();
            child.setId(whTask.getStaffId());
            List<WhStaff> parentList = iWhStaffService.selectWhStaffListParents(child);
            if (CollectionUtils.isNotEmpty(parentList)){
                for (WhStaff whStaff : parentList){
                    this.handleStatistics(whStaff, whTask);
                }
            }

            //判断上级是否全部完成
            Long parentId = whTask.getParentId();
            if (parentId != 0L){
                number = updateParentStatus(number, parentId);
                //修改上级的上级状态
                WhTask fatherTask =  whTaskMapper.selectWhTaskById(parentId);
                if (fatherTask != null && fatherTask.getParentId()!= 0L){
                    number = updateParentStatus(number, fatherTask.getParentId());
                }
            }
        }

        return number;
    }

    /**
     * 更新父级状态
     * @param number
     * @param parentId
     * @return
     */
    private int updateParentStatus(int number, Long parentId) {
        List<WhTask> childTaskList = whTaskMapper.selectTaskByParentId(parentId);
        if (CollectionUtils.isNotEmpty(childTaskList)){
            boolean flag = childTaskList.stream().allMatch(element->element.getStatus() == 1);
            if (flag){
                WhTask parentTask = new WhTask();
                parentTask.setId(parentId);
                parentTask.setStatus(1);
                number = whTaskMapper.updateWhTask(parentTask);
            }
        }
        return number;
    }

    /**
     * 处理工时分配
     * @param month
     * @param distribution
     */
    private void handleDistribution(String month, WhTaskDistribution distribution) {
        //判断是否有未发放的，如有直接增加工时，否则创建
        WhSalaryDistribution salaryDistribution = iWhSalaryDistributionService.selectSalaryByStaffNo(distribution.getStaffNo(), month);
        // 查询领薪人员工时单价
//        BigDecimal workingPrice = new BigDecimal(0);
//        SysUser sysUser = sysUserService.selectUserByUserName(distribution.getStaffNo());
//        if (sysUser != null && sysUser.getWorkingPrice() != null){
//            workingPrice = sysUser.getWorkingPrice();
//        }
//        distribution.setWorkingPrice(workingPrice);
        if (salaryDistribution == null ) {
            WhSalaryDistribution whSalaryDistribution = new WhSalaryDistribution();
            whSalaryDistribution.setStaffId(distribution.getStaffId());
            whSalaryDistribution.setStaffNo(distribution.getStaffNo());
            whSalaryDistribution.setWorkingHours(distribution.getWorkingHours());
            whSalaryDistribution.setSalary(distribution.getWorkingHours().multiply(distribution.getWorkingPrice()));
            whSalaryDistribution.setMonth(month);
            iWhSalaryDistributionService.insertWhSalaryDistribution(whSalaryDistribution);
            distribution.setSalaryId(whSalaryDistribution.getId());//设置薪酬id
        } else {
            //总工时
            BigDecimal totalHours = salaryDistribution.getWorkingHours().add(distribution.getWorkingHours());
            salaryDistribution.setWorkingHours(totalHours);
            //总薪水
            BigDecimal totalSalary = salaryDistribution.getSalary().add(distribution.getWorkingHours().multiply(distribution.getWorkingPrice()));
            salaryDistribution.setSalary(totalSalary);
            iWhSalaryDistributionService.updateWhSalaryDistribution(salaryDistribution);
            distribution.setSalaryId(salaryDistribution.getId());//设置薪酬id
        }
        iWhTaskDistributionService.insertWhTaskDistribution(distribution);
    }

    /**
     * 处理任务统计
     * @param whStaff
     * @param whTask
     */
    private void handleStatistics(WhStaff whStaff, WhTask whTask) {
        WhTaskStatistics whTaskStatistics = iWhTaskStatisticsService.selectByStaffId(whStaff.getId(), whTask.getMonth());
        if (whTaskStatistics == null) {
            whTaskStatistics = new WhTaskStatistics();
            whTaskStatistics.setStaffId(whStaff.getId());
            whTaskStatistics.setDimension(whStaff.getParticipationMethods());
            whTaskStatistics.setTotalWorkingHours(whTask.getWorkingHours());
            whTaskStatistics.setAmount(1);
            whTaskStatistics.setMonth(whTask.getMonth());
            iWhTaskStatisticsService.insertWhTaskStatistics(whTaskStatistics);
        } else {
            BigDecimal totalHours = whTaskStatistics.getTotalWorkingHours().add(whTask.getWorkingHours());
            whTaskStatistics.setTotalWorkingHours(totalHours);
            whTaskStatistics.setAmount(whTaskStatistics.getAmount()+1);
            iWhTaskStatisticsService.updateWhTaskStatistics(whTaskStatistics);
        }
    }

    @Override
    public List<WhTask> listAppNames() {
        return whTaskMapper.selectAppNames();
    }

    @Override
    public List<WhProject> listProjectNames(String staffNo) {
        return whTaskMapper.selectProjectNames(staffNo);
    }

    @Override
    public List<WhTask> listStaffNames(List<String> staffNos) {
        return whTaskMapper.selectStaffNames(staffNos);
    }

    @Override
    public List<WhTask> listAllTags(WhTask whTask) {
        return whTaskMapper.selectAllTags(whTask);
    }


    @Override
    public List<WhTask> listDistributeNames() {
        return whTaskMapper.selectDistributeNames();
    }

    /**
     * 批量删除任务
     * 
     * @param ids 需要删除的任务主键
     * @return 结果
     */
    @Override
    public int deleteWhTaskByIds(Long[] ids)
    {
        return whTaskMapper.deleteWhTaskByIds(ids);
    }

    /**
     * 删除任务信息
     * 
     * @param id 任务主键
     * @return 结果
     */
    @Override
    public int deleteWhTaskById(Long id)
    {
        return whTaskMapper.deleteWhTaskById(id);
    }

    @Override
    public int checkExistByStaffId(Long staffId) {
        return whTaskMapper.countByStaffId(staffId);
    }

    @Override
    public int checkExistByStage(Long staffId) {
        return whTaskMapper.countByStage(staffId);
    }

    @Override
    public List<WhTask> selectCycleTaskList() {
        return whTaskMapper.selectCycleTaskList();
    }

    @Override
    public String judgeExistTask(WhTask whTask) {
        return checkExistParallelTask(whTask);
    }

    @Override
    public WhTask getLatestTask(WhTask whTask) {
        return whTaskMapper.selectLatestTask(whTask);
    }

    @Override
    public List<WhTask> getBranchTask(WhTask whTask) {
        return whTaskMapper.selectBranchTask(whTask);
    }

    @Override
    public int updateDistributeStatus(WhTask whTask) {
        checkExistStaffTask(whTask);
        WhTask task = new WhTask();
        task.setId(whTask.getId());
        task.setDistributeStatus(whTask.getDistributeStatus());
        return whTaskMapper.updateWhTask(task);
    }

    /**
     * 生成任务编号
     * @return
     */
    private String genTaskNo(){
        //获取检验室编号前缀
        return taskPrefix + format.format(new Date());
    }
}
