package com.wh.work.controller;

import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections4.CollectionUtils;
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
import com.wh.work.domain.WhSalaryDistribution;
import com.wh.work.service.IWhSalaryDistributionService;
import com.wh.common.utils.poi.ExcelUtil;
import com.wh.common.core.page.TableDataInfo;

/**
 * 薪酬发放Controller
 * 
 * @author wxd
 * @date 2023-06-05
 */
@RestController
@RequestMapping("/work/salaryDistribution")
public class WhSalaryDistributionController extends BaseController
{
    @Autowired
    private IWhSalaryDistributionService whSalaryDistributionService;

    /**
     * 查询薪酬发放分页列表
     */
    @PreAuthorize("@ss.hasPermi('work:salaryDistribution:list')")
    @GetMapping("/page")
    public TableDataInfo page(WhSalaryDistribution whSalaryDistribution)
    {
        startPage();
        List<WhSalaryDistribution> list = whSalaryDistributionService.selectWhSalaryDistributionList(whSalaryDistribution);
        return getDataTable(list);
    }

    /**
     * 查询薪酬发放列表
     */
    @PreAuthorize("@ss.hasPermi('work:salaryDistribution:list')")
    @GetMapping("/list")
    public AjaxResult list(WhSalaryDistribution whSalaryDistribution)
    {
        List<WhSalaryDistribution> list = whSalaryDistributionService.selectWhSalaryDistributionList(whSalaryDistribution);
        return success(list);
    }

    /**
     * 导出薪酬发放列表
     */
    @PreAuthorize("@ss.hasPermi('work:salaryDistribution:export')")
    @Log(title = "薪酬发放", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, WhSalaryDistribution whSalaryDistribution)
    {
        List<WhSalaryDistribution> list = whSalaryDistributionService.selectWhSalaryDistributionList(whSalaryDistribution);
        ExcelUtil<WhSalaryDistribution> util = new ExcelUtil<WhSalaryDistribution>(WhSalaryDistribution.class);
        util.exportExcel(response, list, "薪酬发放数据");
    }

    /**
     * 获取薪酬发放详细信息
     */
    @PreAuthorize("@ss.hasPermi('work:salaryDistribution:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(whSalaryDistributionService.selectWhSalaryDistributionById(id));
    }

    /**
     * 新增薪酬发放
     */
    @PreAuthorize("@ss.hasPermi('work:salaryDistribution:add')")
    @Log(title = "薪酬发放", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody WhSalaryDistribution whSalaryDistribution)
    {
        return toAjax(whSalaryDistributionService.insertWhSalaryDistribution(whSalaryDistribution));
    }

    /**
     * 修改薪酬发放
     */
    @PreAuthorize("@ss.hasPermi('work:salaryDistribution:edit')")
    @Log(title = "薪酬发放", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody WhSalaryDistribution whSalaryDistribution)
    {
        return toAjax(whSalaryDistributionService.updateWhSalaryDistribution(whSalaryDistribution));
    }

    /**
     * 删除薪酬发放
     */
    @PreAuthorize("@ss.hasPermi('work:salaryDistribution:remove')")
    @Log(title = "薪酬发放", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(whSalaryDistributionService.deleteWhSalaryDistributionByIds(ids));
    }

    /**
     * 薪酬发放，修改发放状态
     */
    @PreAuthorize("@ss.hasPermi('work:salaryDistribution:distribute')")
    @Log(title = "薪酬发放", businessType = BusinessType.DELETE)
    @PutMapping("/{ids}")
    public AjaxResult distribute(@PathVariable Long[] ids)
    {
        return toAjax(whSalaryDistributionService.distributeWhSalaryDistributionByIds(ids));
    }
}
