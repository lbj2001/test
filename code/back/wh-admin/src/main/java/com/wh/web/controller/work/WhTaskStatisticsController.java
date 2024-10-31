package com.wh.work.controller;

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
import com.wh.work.domain.WhTaskStatistics;
import com.wh.work.service.IWhTaskStatisticsService;
import com.wh.common.utils.poi.ExcelUtil;
import com.wh.common.core.page.TableDataInfo;

/**
 * 工时统计Controller
 * 
 * @author wxd
 * @date 2023-06-07
 */
@RestController
@RequestMapping("/work/taskStatistics")
public class WhTaskStatisticsController extends BaseController
{
    @Autowired
    private IWhTaskStatisticsService whTaskStatisticsService;

    /**
     * 查询工时统计列表
     */
    @PreAuthorize("@ss.hasPermi('work:taskStatistics:list')")
    @GetMapping("/page")
    public TableDataInfo page(WhTaskStatistics whTaskStatistics)
    {
        startPage();
        List<WhTaskStatistics> list = whTaskStatisticsService.selectWhTaskStatisticsList(whTaskStatistics);
        return getDataTable(list);
    }

    /**
     * 查询工时统计列表
     */
    @PreAuthorize("@ss.hasPermi('work:taskStatistics:list')")
    @GetMapping("/list")
    public AjaxResult list(WhTaskStatistics whTaskStatistics)
    {
        List<WhTaskStatistics> list = whTaskStatisticsService.selectWhTaskStatisticsList(whTaskStatistics);
        return success(list);
    }

    /**
     * 导出工时统计列表
     */
    @PreAuthorize("@ss.hasPermi('work:taskStatistics:export')")
    @Log(title = "工时统计", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, WhTaskStatistics whTaskStatistics)
    {
        List<WhTaskStatistics> list = whTaskStatisticsService.selectWhTaskStatisticsList(whTaskStatistics);
        ExcelUtil<WhTaskStatistics> util = new ExcelUtil<WhTaskStatistics>(WhTaskStatistics.class);
        util.exportExcel(response, list, "工时统计数据");
    }

    /**
     * 获取工时统计详细信息
     */
    @PreAuthorize("@ss.hasPermi('work:taskStatistics:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(whTaskStatisticsService.selectWhTaskStatisticsById(id));
    }

    /**
     * 新增工时统计
     */
    @PreAuthorize("@ss.hasPermi('work:taskStatistics:add')")
    @Log(title = "工时统计", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody WhTaskStatistics whTaskStatistics)
    {
        return toAjax(whTaskStatisticsService.insertWhTaskStatistics(whTaskStatistics));
    }

    /**
     * 修改工时统计
     */
    @PreAuthorize("@ss.hasPermi('work:taskStatistics:edit')")
    @Log(title = "工时统计", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody WhTaskStatistics whTaskStatistics)
    {
        return toAjax(whTaskStatisticsService.updateWhTaskStatistics(whTaskStatistics));
    }

    /**
     * 删除工时统计
     */
    @PreAuthorize("@ss.hasPermi('work:taskStatistics:remove')")
    @Log(title = "工时统计", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(whTaskStatisticsService.deleteWhTaskStatisticsByIds(ids));
    }
}
