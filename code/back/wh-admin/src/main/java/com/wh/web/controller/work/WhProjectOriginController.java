package com.wh.web.controller.work;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.wh.work.domain.WhProjectOrigin;
import com.wh.work.service.IWhProjectOriginService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.wh.common.annotation.Log;
import com.wh.common.core.controller.BaseController;
import com.wh.common.core.domain.AjaxResult;
import com.wh.common.enums.BusinessType;
import com.wh.common.utils.poi.ExcelUtil;
import com.wh.common.core.page.TableDataInfo;

/**
 * 项目来源Controller
 * 
 * @author wh
 * @date 2023-10-13
 */
@RestController
@RequestMapping("/work/projectOrigin")
public class WhProjectOriginController extends BaseController
{
    @Autowired
    private IWhProjectOriginService whProjectOriginService;

    /**
     * 查询项目来源列表
     */
    @PreAuthorize("@ss.hasPermi('work:projectOrigin:list')")
    @GetMapping("/list")
    public TableDataInfo list(WhProjectOrigin whProjectOrigin)
    {
        startPage();
        List<WhProjectOrigin> list = whProjectOriginService.selectWhProjectOriginList(whProjectOrigin);
        return getDataTable(list);
    }

    /**
     * 导出项目来源列表
     */
    @PreAuthorize("@ss.hasPermi('work:projectOrigin:export')")
    @Log(title = "项目来源", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, WhProjectOrigin whProjectOrigin)
    {
        List<WhProjectOrigin> list = whProjectOriginService.selectWhProjectOriginList(whProjectOrigin);
        ExcelUtil<WhProjectOrigin> util = new ExcelUtil<WhProjectOrigin>(WhProjectOrigin.class);
        util.exportExcel(response, list, "项目来源数据");
    }

    /**
     * 获取项目来源详细信息
     */
    @PreAuthorize("@ss.hasPermi('work:projectOrigin:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(whProjectOriginService.selectWhProjectOriginById(id));
    }

    /**
     * 新增项目来源
     */
    @PreAuthorize("@ss.hasPermi('work:projectOrigin:add')")
    @Log(title = "项目来源", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody WhProjectOrigin whProjectOrigin)
    {
        return toAjax(whProjectOriginService.insertWhProjectOrigin(whProjectOrigin));
    }

    /**
     * 修改项目来源
     */
    @PreAuthorize("@ss.hasPermi('work:projectOrigin:edit')")
    @Log(title = "项目来源", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody WhProjectOrigin whProjectOrigin)
    {
        return toAjax(whProjectOriginService.updateWhProjectOrigin(whProjectOrigin));
    }

    /**
     * 删除项目来源
     */
    @PreAuthorize("@ss.hasPermi('work:projectOrigin:remove')")
    @Log(title = "项目来源", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(whProjectOriginService.deleteWhProjectOriginByIds(ids));
    }

    /**
     * 查询代码与源列表
     */
    @PreAuthorize("@ss.hasAnyPermi({'work:project:edit'})")
    @GetMapping("/listSourceNos")
    public AjaxResult listSourceNos(@RequestParam("projectNo") String projectNo,
                                        @RequestParam("summaryNo") String summaryNo)
    {
        List<WhProjectOrigin> list = whProjectOriginService.listSourceNos(projectNo, summaryNo);
        return success(list);
    }
}
