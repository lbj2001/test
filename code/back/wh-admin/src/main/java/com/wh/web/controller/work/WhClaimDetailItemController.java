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
import com.wh.work.domain.WhClaimDetailItem;
import com.wh.work.service.IWhClaimDetailItemService;
import com.wh.common.utils.poi.ExcelUtil;
import com.wh.common.core.page.TableDataInfo;

/**
 * 工时申报明细条目Controller
 * 
 * @author wxd
 * @date 2024-03-16
 */
@RestController
@RequestMapping("/work/item")
public class WhClaimDetailItemController extends BaseController
{
    @Autowired
    private IWhClaimDetailItemService whClaimDetailItemService;

    /**
     * 查询工时申报明细条目列表
     */
    @PreAuthorize("@ss.hasPermi('work:item:list')")
    @GetMapping("/list")
    public TableDataInfo list(WhClaimDetailItem whClaimDetailItem)
    {
        startPage();
        List<WhClaimDetailItem> list = whClaimDetailItemService.selectWhClaimDetailItemList(whClaimDetailItem);
        return getDataTable(list);
    }

    /**
     * 导出工时申报明细条目列表
     */
    @PreAuthorize("@ss.hasPermi('work:item:export')")
    @Log(title = "工时申报明细条目", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, WhClaimDetailItem whClaimDetailItem)
    {
        List<WhClaimDetailItem> list = whClaimDetailItemService.selectWhClaimDetailItemList(whClaimDetailItem);
        ExcelUtil<WhClaimDetailItem> util = new ExcelUtil<WhClaimDetailItem>(WhClaimDetailItem.class);
        util.exportExcel(response, list, "工时申报明细条目数据");
    }

    /**
     * 获取工时申报明细条目详细信息
     */
    @PreAuthorize("@ss.hasPermi('work:item:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(whClaimDetailItemService.selectWhClaimDetailItemById(id));
    }

    /**
     * 新增工时申报明细条目
     */
    @PreAuthorize("@ss.hasPermi('work:item:add')")
    @Log(title = "工时申报明细条目", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody WhClaimDetailItem whClaimDetailItem)
    {
        return toAjax(whClaimDetailItemService.insertWhClaimDetailItem(whClaimDetailItem));
    }

    /**
     * 修改工时申报明细条目
     */
    @PreAuthorize("@ss.hasPermi('work:item:edit')")
    @Log(title = "工时申报明细条目", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody WhClaimDetailItem whClaimDetailItem)
    {
        return toAjax(whClaimDetailItemService.updateWhClaimDetailItem(whClaimDetailItem));
    }

    /**
     * 删除工时申报明细条目
     */
    @PreAuthorize("@ss.hasPermi('work:item:remove')")
    @Log(title = "工时申报明细条目", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(whClaimDetailItemService.deleteWhClaimDetailItemByIds(ids));
    }
}
