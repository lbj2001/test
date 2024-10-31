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
import com.wh.work.domain.WhClaimDetail;
import com.wh.work.service.IWhClaimDetailService;
import com.wh.common.utils.poi.ExcelUtil;
import com.wh.common.core.page.TableDataInfo;

/**
 * 工时申报明细Controller
 * 
 * @author wxd
 * @date 2024-03-04
 */
@RestController
@RequestMapping("/work/claimDetail")
public class WhClaimDetailController extends BaseController
{
    @Autowired
    private IWhClaimDetailService whClaimDetailService;

    /**
     * 查询工时申报明细列表
     */
    @PreAuthorize("@ss.hasPermi('work:claimDetail:list')")
    @GetMapping("/list")
    public TableDataInfo list(WhClaimDetail whClaimDetail)
    {
        startPage();
        List<WhClaimDetail> list = whClaimDetailService.selectWhClaimDetailList(whClaimDetail);
        return getDataTable(list);
    }

    /**
     * 导出工时申报明细列表
     */
    @PreAuthorize("@ss.hasPermi('work:claimDetail:export')")
    @Log(title = "工时申报明细", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, WhClaimDetail whClaimDetail)
    {
        List<WhClaimDetail> list = whClaimDetailService.selectWhClaimDetailList(whClaimDetail);
        ExcelUtil<WhClaimDetail> util = new ExcelUtil<WhClaimDetail>(WhClaimDetail.class);
        util.exportExcel(response, list, "工时申报明细数据");
    }

    /**
     * 获取工时申报明细详细信息
     */
    @PreAuthorize("@ss.hasPermi('work:claimDetail:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(whClaimDetailService.selectWhClaimDetailById(id));
    }

    /**
     * 新增工时申报明细
     */
    @PreAuthorize("@ss.hasPermi('work:claimDetail:add')")
    @Log(title = "工时申报明细", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody WhClaimDetail whClaimDetail)
    {
        return toAjax(whClaimDetailService.insertWhClaimDetail(whClaimDetail));
    }

    /**
     * 修改工时申报明细
     */
    @PreAuthorize("@ss.hasPermi('work:claimDetail:edit')")
    @Log(title = "工时申报明细", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody WhClaimDetail whClaimDetail)
    {
        return toAjax(whClaimDetailService.updateWhClaimDetail(whClaimDetail));
    }

    /**
     * 删除工时申报明细
     */
    @PreAuthorize("@ss.hasPermi('work:claimDetail:remove')")
    @Log(title = "工时申报明细", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(whClaimDetailService.deleteWhClaimDetailByIds(ids));
    }
}
