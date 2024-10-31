package com.wh.web.controller.work;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletResponse;

import com.wh.common.utils.StringUtils;
import com.wh.work.domain.WhTask;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.wh.common.annotation.Log;
import com.wh.common.core.controller.BaseController;
import com.wh.common.core.domain.AjaxResult;
import com.wh.common.enums.BusinessType;
import com.wh.work.domain.WhStaff;
import com.wh.work.service.IWhStaffService;
import com.wh.common.utils.poi.ExcelUtil;
import com.wh.common.core.page.TableDataInfo;

/**
 * 员工信息Controller
 * 
 * @author wxd
 * @date 2023-05-16
 */
@RestController
@RequestMapping("/work/staff")
public class WhStaffController extends BaseController
{
    @Autowired
    private IWhStaffService whStaffService;

    /**
     * 查询员工信息列表分页
     */
    @PreAuthorize("@ss.hasPermi('work:staff:list')")
    @GetMapping("/page")
    public TableDataInfo page(WhStaff whStaff)
    {
        whStaff.setPageMethods(1);
        startPage();
        List<WhStaff> pageList = whStaffService.selectWhStaffList(whStaff);
        // todo 优化查询
        List<WhStaff> list = new ArrayList<>();
        if(CollectionUtils.isNotEmpty(pageList)){
            WhStaff sta;
            for (WhStaff staff : pageList){
                sta = new WhStaff();
                sta.setId(staff.getId());
                sta.setDelFlag(whStaff.getDelFlag());
                sta.setStaffName(whStaff.getStaffName());
                sta.setStaffNo(whStaff.getStaffNo());
                sta.setParticipationMethods(whStaff.getParticipationMethods());
                sta.setTeamNo(whStaff.getTeamNo());
                list.addAll(whStaffService.selectWhStaffListChildren(sta));
            }
        } else {
            whStaff.setPageMethods(null);
            list = whStaffService.selectWhStaffList(whStaff);
            // 查询所有父节点
            List<WhStaff> parentList = new ArrayList<>();
            for (WhStaff sonStaff : list){
                parentList.addAll(whStaffService.selectAllParents(sonStaff));
            }
            list.addAll(parentList);
            // list 去重
            Set<WhStaff> parentSet = new HashSet<>(list);
            list.clear();
            list.addAll(parentSet);
        }

        //  todo 优化查询团队人员
        for (WhStaff staf : list){
            staf.setTeamAmount(whStaffService.getTeamAmount(staf.getId()));
        }

        return getDataTable(list, pageList);
    }

    /**
     * 查询员工信息列表
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:staff:list', 'work:task:list', 'work:taskClaim:list'})")
    @GetMapping("/list")
    public AjaxResult list(WhStaff whStaff)
    {
        List<WhStaff> list = whStaffService.selectWhStaffList(whStaff);
        return success(list);
    }

    /**
     * 查询单人信息列表
     */
    @PreAuthorize("@ss.hasPermi('work:staff:list')")
    @GetMapping("/singleList")
    public TableDataInfo singleList(WhStaff whStaff)
    {
        whStaff.setPageMethods(1);
        startPage();
        List<WhStaff> pageList = whStaffService.selectSingleList(whStaff);
        // todo 优化查询
        List<WhStaff> list = new ArrayList<>();
        if(CollectionUtils.isNotEmpty(pageList)){
            for (WhStaff staff : pageList){
                WhStaff sta = new WhStaff();
                sta.setId(staff.getId());
                list.addAll(whStaffService.selectWhStaffListChildren(sta));
            }
        } else {
            whStaff.setPageMethods(null);
            list = whStaffService.selectSingleList(whStaff);
        }
        return getDataTable(list, pageList);
    }

    /**
     * 查询员工下级列表
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:staff:list', 'work:task:distribute'})")
    @GetMapping("/listChildren")
    public AjaxResult listChildren(WhStaff whStaff)
    {
        List<WhStaff> list = whStaffService.selectWhStaffListChildren(whStaff);
        return success(list);
    }

    /**
     * 查询员工上级列表
     */
    @PreAuthorize("@ss.hasPermi('work:staff:list')")
    @GetMapping("/listParents")
    public AjaxResult listParents(WhStaff whStaff)
    {
        List<WhStaff> list = whStaffService.selectWhStaffListParents(whStaff);
        return success(list);
    }

    /**
     * 导出员工信息列表
     */
    @PreAuthorize("@ss.hasPermi('work:staff:export')")
    @Log(title = "员工信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, WhStaff whStaff)
    {
        List<WhStaff> list = whStaffService.selectWhStaffList(whStaff);
        ExcelUtil<WhStaff> util = new ExcelUtil<WhStaff>(WhStaff.class);
        util.exportExcel(response, list, "员工信息数据");
    }

    /**
     * 获取员工信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('work:staff:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(whStaffService.selectWhStaffById(id));
    }

    /**
     * 新增员工信息
     */
    @PreAuthorize("@ss.hasPermi('work:staff:add')")
    @Log(title = "员工信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody WhStaff whStaff)
    {
        whStaff.setCreateBy(getUsername());
        return toAjax(whStaffService.insertWhStaff(whStaff));
    }

    /**
     * 修改员工信息
     */
    @PreAuthorize("@ss.hasPermi('work:staff:edit')")
    @Log(title = "员工信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody WhStaff whStaff)
    {
        whStaff.setUpdateBy(getUsername());
        return toAjax(whStaffService.updateWhStaff(whStaff));
    }

    /**
     * 删除员工信息
     */
    @PreAuthorize("@ss.hasPermi('work:staff:remove')")
    @Log(title = "员工信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(whStaffService.deleteWhStaffByIds(ids));
    }

    /**
     * 删除员工信息
     */
    @PreAuthorize("@ss.hasPermi('work:staff:remove')")
    @Log(title = "员工信息", businessType = BusinessType.UPDATE)
    @RequestMapping("/dismiss")
    public AjaxResult dismiss(@RequestBody WhStaff whStaff)
    {
        return toAjax(whStaffService.dismiss(whStaff));
    }

    /**
     * 检查是否存在关联关系
     */
    @PreAuthorize("@ss.hasPermi('work:staff:remove')")
    @GetMapping(value = "/checkExist")
    public AjaxResult checkExistRelation(WhStaff whStaff)
    {
        return success(whStaffService.checkExistRelation(whStaff));
    }

    /**
     * 查询领薪人名称列表
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:task:list', 'work:taskClaim:list'})")
    @GetMapping("/listSalaryNames")
    public AjaxResult listSalaryNames(WhStaff whStaff)
    {
        List<WhStaff> list = whStaffService.listSalaryNames(whStaff);
        return success(list);
    }

    /**
     * 查询员工信息列表
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:staff:list', 'work:task:list', 'work:taskClaim:list'})")
    @GetMapping("/listByParent")
    public AjaxResult listByParent(WhStaff whStaff)
    {
        List<WhStaff> list = whStaffService.selectWhStaffListByParent(whStaff);
        return success(list);
    }

    /**
     * 修改员工信息
     */
    @PreAuthorize("@ss.hasPermi('work:staff:edit')")
    @Log(title = "员工信息", businessType = BusinessType.UPDATE)
    @PostMapping("/updateParallelFlag")
    public AjaxResult updateParallelFlag(@RequestBody WhStaff whStaff)
    {
        whStaff.setUpdateBy(getUsername());
        return toAjax(whStaffService.updateWhStaff(whStaff));
    }
}
