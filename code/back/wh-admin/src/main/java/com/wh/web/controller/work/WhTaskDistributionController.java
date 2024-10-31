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
import com.wh.work.domain.WhTaskDistribution;
import com.wh.work.service.IWhTaskDistributionService;
import com.wh.common.utils.poi.ExcelUtil;
import com.wh.common.core.page.TableDataInfo;

/**
 * 任务认领Controller
 * 
 * @author wxd
 * @date 2023-05-17
 */
@RestController
@RequestMapping("/work/taskDistribution")
public class WhTaskDistributionController extends BaseController
{
    @Autowired
    private IWhTaskDistributionService whTaskDistributionService;

    /**
     * 查询任务认领列表
     */
    @PreAuthorize("@ss.hasPermi('work:taskDistribution:list')")
    @GetMapping("/list")
    public TableDataInfo list(WhTaskDistribution whTaskDistribution)
    {
        startPage();
        List<WhTaskDistribution> list = whTaskDistributionService.selectWhTaskDistributionList(whTaskDistribution);
        return getDataTable(list);
    }

    /**
     * 导出任务认领列表
     */
    @PreAuthorize("@ss.hasPermi('work:taskDistribution:export')")
    @Log(title = "任务认领", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, WhTaskDistribution whTaskDistribution)
    {
        List<WhTaskDistribution> list = whTaskDistributionService.selectWhTaskDistributionList(whTaskDistribution);
        ExcelUtil<WhTaskDistribution> util = new ExcelUtil<WhTaskDistribution>(WhTaskDistribution.class);
        util.exportExcel(response, list, "任务认领数据");
    }

    /**
     * 获取任务认领详细信息
     */
    @PreAuthorize("@ss.hasPermi('work:taskDistribution:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(whTaskDistributionService.selectWhTaskDistributionById(id));
    }

    /**
     * 新增任务认领
     */
    @PreAuthorize("@ss.hasPermi('work:taskDistribution:add')")
    @Log(title = "任务认领", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody WhTaskDistribution whTaskDistribution)
    {
        whTaskDistribution.setCreateBy(getUsername());
        return toAjax(whTaskDistributionService.insertWhTaskDistribution(whTaskDistribution));
    }

    /**
     * 修改任务认领
     */
    @PreAuthorize("@ss.hasPermi('work:taskDistribution:edit')")
    @Log(title = "任务认领", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody WhTaskDistribution whTaskDistribution)
    {
        whTaskDistribution.setUpdateBy(getUsername());
        return toAjax(whTaskDistributionService.updateWhTaskDistribution(whTaskDistribution));
    }

    /**
     * 删除任务认领
     */
    @PreAuthorize("@ss.hasPermi('work:taskDistribution:remove')")
    @Log(title = "任务认领", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(whTaskDistributionService.deleteWhTaskDistributionByIds(ids));
    }
}
