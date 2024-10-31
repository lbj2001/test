package com.wh.web.controller.work;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletResponse;

import com.wh.common.utils.StringUtils;
import com.wh.system.service.ISysUserService;
import com.wh.work.domain.WhProject;
import com.wh.work.domain.WhStaff;
import com.wh.work.domain.vo.WhTaskStatisticsReqVO;
import com.wh.work.domain.vo.WhTaskStatisticsRespVO;
import com.wh.work.service.IWhStaffService;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.wh.common.annotation.Log;
import com.wh.common.core.controller.BaseController;
import com.wh.common.core.domain.AjaxResult;
import com.wh.common.enums.BusinessType;
import com.wh.work.domain.WhTask;
import com.wh.work.service.IWhTaskService;
import com.wh.common.utils.poi.ExcelUtil;
import com.wh.common.core.page.TableDataInfo;

/**
 * 任务Controller
 * 
 * @author wxd
 * @date 2023-05-17
 */
@RestController
@RequestMapping("/work/task")
public class WhTaskController extends BaseController
{
    @Autowired
    private IWhTaskService whTaskService;

    @Autowired
    private IWhStaffService whStaffService;

    /**
     * 查询任务下发分页列表
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:task:list'})")
    @GetMapping("/page")
    public TableDataInfo page(WhTask whTask)
    {
        whTask.setParentId(0L);
        startPage();
        List<WhTask> pageList = whTaskService.selectWhTaskList(whTask);
        // todo 优化查询
        List<WhTask> list = new ArrayList<>();
        if(CollectionUtils.isNotEmpty(pageList)){
            for (WhTask task : pageList){
                WhTask newTask = new WhTask();
                newTask.setId(task.getId());
                list.addAll(whTaskService.selectSingleList(newTask));
            }
        } else {
            whTask.setParentId(null);
            list = whTaskService.selectWhTaskList(whTask);
        }

        return getDataTable(list, pageList);
    }

    /**
     * 查询任务列表
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:task:list','work:taskClaim:list'})")
    @GetMapping("/list")
    public AjaxResult list(WhTask whTask)
    {
        List<WhTask> list = whTaskService.selectWhTaskList(whTask);
        return success(list);
    }

    /**
     * 查询单人任务列表
     */
    @PreAuthorize("@ss.hasPermi('work:task:list')")
    @GetMapping("/singleList")
    public TableDataInfo singleList(WhTask whTask)
    {
        whTask.setParentId(0L);
        //查询分配人顶级角色
        WhStaff maxStaff = whStaffService.selectMaxStaff(whTask.getStaffNo());
        if (maxStaff != null){
            //查询分配人所有下级
            WhStaff staff = new WhStaff();
            staff.setId(maxStaff.getId());
            List<WhStaff> allChildren = whStaffService.selectAllDevChildren(staff);
            List<Long> devStaffIds = allChildren.stream().map(WhStaff::getId).collect(Collectors.toList());
            whTask.getStaffIds().addAll(devStaffIds);
        }
        startPage();
        List<WhTask> pageList = whTaskService.selectSingleList(whTask);
        // todo 优化查询
        List<WhTask> list = new ArrayList<>();
        if(CollectionUtils.isNotEmpty(pageList)){
            for (WhTask task : pageList){
                WhTask newTask = new WhTask();
                newTask.setId(task.getId());
                list.addAll(whTaskService.selectSingleList(newTask));
            }
        } else {
            whTask.setParentId(null);
            list = whTaskService.selectSingleList(whTask);
        }
        return getDataTable(list, pageList);
    }

    /**
     * 查询工时申报分页列表
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:taskClaim:list', 'work:taskInquire:list'})")
    @GetMapping("/devPage")
    public TableDataInfo devPage(WhTask whTask)
    {
        //查询分配人顶级角色
        WhStaff maxStaff = whStaffService.selectMaxStaff(whTask.getStaffNo());
        if (maxStaff != null){
            //查询分配人所有下级
            WhStaff staff = new WhStaff();
            staff.setId(maxStaff.getId());
            staff.setParticipationMethods(3);
            List<WhStaff> devChildren = whStaffService.selectAllDevChildren(staff);
            List<String> devStaffNos = devChildren.stream().map(WhStaff::getStaffNo).collect(Collectors.toList());
            whTask.setStaffNos(devStaffNos);
        }
        startPage();
        List<WhTask> list = whTaskService.selectDevWhTaskList(whTask);
        return getDataTable(list);
    }

    /**
     * 导出任务列表
     */
    @PreAuthorize("@ss.hasPermi('work:task:export')")
    @Log(title = "任务", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, WhTask whTask)
    {
        List<WhTask> list = whTaskService.selectWhTaskList(whTask);
        ExcelUtil<WhTask> util = new ExcelUtil<WhTask>(WhTask.class);
        util.exportExcel(response, list, "任务数据");
    }

    /**
     * 获取任务详细信息
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:task:query','work:taskClaim:query','work:taskInquire:query'})")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(whTaskService.selectWhTaskById(id));
    }

    /**
     * 新增任务
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:task:add'})")
    @Log(title = "任务", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody WhTask whTask)
    {
        whTask.setCreateBy(getUsername());
        return toAjax(whTaskService.insertWhTask(whTask));
    }

    /**
     * 修改任务
     */
    @PreAuthorize("@ss.hasPermi('work:task:edit')")
    @Log(title = "任务", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody WhTask whTask)
    {
        whTask.setUpdateBy(getUsername());
        return toAjax(whTaskService.updateWhTask(whTask));
    }

    /**
     * 领薪分配工时
     */
    @PreAuthorize("@ss.hasPermi('work:taskClaim:distribute')")
    @Log(title = "任务", businessType = BusinessType.UPDATE)
    @PutMapping("/distribute")
    public AjaxResult distribute(@RequestBody WhTask whTask)
    {
        whTask.setUpdateBy(getUsername());
        return toAjax(whTaskService.distribute(whTask));
    }

    /**
     * 查询应用名称列表
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:task:list', 'work:task:add', 'work:task:edit', 'work:taskClaim:list'})")
    @GetMapping("/listAppNames")
    public AjaxResult listAppNames()
    {
        List<WhTask> list = whTaskService.listAppNames();
        return success(list);
    }

    /**
     * 查询项目列表
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:task:list', 'work:taskClaim:list'})")
    @GetMapping("/listProjectNames")
    public AjaxResult listProjectNames(@RequestParam("staffNo") String staffNo)
    {
        List<WhProject> list = whTaskService.listProjectNames(staffNo);
        return success(list);
    }

    /**
     * 查询被分配人名称列表
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:task:list', 'work:taskClaim:list'})")
    @GetMapping("/listStaffNames")
    public AjaxResult listStaffNames(@RequestParam(required = false) String staffNo)
    {
        List<String> devStaffNos;
        if (StringUtils.isNotEmpty(staffNo)){
            //查询分配人顶级角色
            WhStaff maxStaff = whStaffService.selectMaxStaff(staffNo);
            //查询分配人所有下级
            WhStaff staff = new WhStaff();
            staff.setId(maxStaff.getId());
            List<WhStaff> devChildren = whStaffService.selectAllDevChildren(staff);
            devStaffNos = devChildren.stream().map(WhStaff::getStaffNo).collect(Collectors.toList());
        }else{
            devStaffNos = new ArrayList<>();
        }

        List<WhTask> list = whTaskService.listStaffNames(devStaffNos);
        return success(list);
    }

    /**
     * 查询应用名称列表
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:task:list', 'work:taskClaim:list'})")
    @GetMapping("/listDistributeNames")
    public AjaxResult listDistributeNames()
    {
        List<WhTask> list = whTaskService.listDistributeNames();
        return success(list);
    }

    /**
     * 删除任务
     */
    @PreAuthorize("@ss.hasPermi('work:task:remove')")
    @Log(title = "任务", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(whTaskService.deleteWhTaskByIds(ids));
    }

    /**
     * 获取最新任务
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:task:add','work:task:edit'})")
    @GetMapping(value = "/getLastTask")
    public AjaxResult getLastTask(@RequestParam("appName") String appName)
    {
        return success(whTaskService.selectLastByAppName(appName));
    }

    /**
     * 判断员工是否存在任务
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:task:add'})")
    @GetMapping("/judgeExistTask")
    public AjaxResult judgeExistTask(WhTask whTask)
    {
        return success(whTaskService.judgeExistTask(whTask));
    }

    /**
     * 获取全部tag标签
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:task:add','work:task:edit'})")
    @GetMapping(value = "/getAllTags")
    public AjaxResult getAllTags(WhTask whTask)
    {
        return success(whTaskService.listAllTags(whTask));
    }

    /**
     * 获取最近提交任务
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:task:add','work:task:edit'})")
    @GetMapping(value = "/getLatestTask")
    public AjaxResult getLatestTask(WhTask whTask)
    {
        return success(whTaskService.getLatestTask(whTask));
    }

    /**
     * 获取全部tag标签
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:task:add','work:task:edit'})")
    @GetMapping(value = "/getBranchTask")
    public AjaxResult getBranchTask(WhTask whTask)
    {
        return success(whTaskService.getBranchTask(whTask));
    }

    /**
     * 新增任务
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:task:edit'})")
    @Log(title = "任务", businessType = BusinessType.UPDATE)
    @PostMapping(value = "updateDistributeStatus")
    public AjaxResult updateDistributeStatus(@RequestBody WhTask whTask)
    {
        whTask.setUpdateBy(getUsername());
        return toAjax(whTaskService.updateDistributeStatus(whTask));
    }

}
