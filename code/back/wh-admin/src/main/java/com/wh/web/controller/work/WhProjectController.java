package com.wh.web.controller.work;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.wh.common.annotation.Log;
import com.wh.common.core.controller.BaseController;
import com.wh.common.core.domain.AjaxResult;
import com.wh.common.enums.BusinessType;
import com.wh.work.domain.WhProject;
import com.wh.work.service.IWhProjectService;
import com.wh.common.utils.poi.ExcelUtil;
import com.wh.common.core.page.TableDataInfo;

/**
 * 项目Controller
 * 
 * @author wxd
 * @date 2023-07-26
 */
@RestController
@RequestMapping("/work/project")
public class WhProjectController extends BaseController
{
    @Autowired
    private IWhProjectService whProjectService;

    /**
     * 查询项目分页列表
     */
    @PreAuthorize("@ss.hasPermi('work:project:list')")
    @GetMapping("/page")
    public TableDataInfo page(WhProject whProject)
    {
        startPage();
        List<WhProject> list = whProjectService.selectWhProjectList(whProject);
        return getDataTable(list);
    }

    /**
     * 查询项目列表
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:project:list', 'work:task:list', 'work:taskClaim:list'})")
    @GetMapping("/list")
    public AjaxResult list(WhProject whProject)
    {
        List<WhProject> list = whProjectService.selectWhProjectList(whProject);
        return success(list);
    }

    /**
     * 查询项目列表
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:project:list', 'work:task:list', 'work:taskClaim:list'})")
    @GetMapping("/listByStaff")
    public AjaxResult listByStaff(WhProject whProject)
    {
        List<WhProject> list = whProjectService.selectStaffProjectList(whProject);
        return success(list);
    }

    /**
     * 导出项目列表
     */
    @PreAuthorize("@ss.hasPermi('work:project:export')")
    @Log(title = "项目", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, WhProject whProject)
    {
        List<WhProject> list = whProjectService.selectWhProjectList(whProject);
        ExcelUtil<WhProject> util = new ExcelUtil<WhProject>(WhProject.class);
        util.exportExcel(response, list, "项目数据");
    }

    /**
     * 获取项目详细信息
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:project:query', 'work:task:query', 'work:taskClaim:query'})")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(whProjectService.selectWhProjectById(id));
    }

    /**
     * 新增项目
     */
    @PreAuthorize("@ss.hasPermi('work:project:add')")
    @Log(title = "项目", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody WhProject whProject)
    {
        whProject.setCreateBy(getUsername());
        return toAjax(whProjectService.insertWhProject(whProject));
    }

    /**
     * 修改项目
     */
    @PreAuthorize("@ss.hasPermi('work:project:edit')")
    @Log(title = "项目", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody WhProject whProject)
    {
        whProject.setUpdateBy(getUsername());
        return toAjax(whProjectService.updateWhProject(whProject));
    }

    /**
     * 删除项目
     */
    @PreAuthorize("@ss.hasPermi('work:project:remove')")
    @Log(title = "项目", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(whProjectService.deleteWhProjectByIds(ids));
    }
}
