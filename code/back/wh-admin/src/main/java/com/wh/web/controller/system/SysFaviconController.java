package com.wh.web.controller.system;

import com.wh.common.core.controller.BaseController;
import com.wh.common.core.domain.AjaxResult;
import com.wh.common.utils.StringUtils;
import com.wh.system.service.ISysConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 首页
 *
 * @author wh
 */
@RestController
public class SysFaviconController extends BaseController
{

    @Autowired
    private ISysConfigService configService;

    private final String DEF_ICON= "favicon.png";

    /**
     * 应用浏览器图标
     */
    @RequestMapping("/favicon")
    public AjaxResult favicon()
    {
        String favicon = configService.selectConfigByKey("sys.web.icon");
        if (StringUtils.isEmpty(favicon)){
            return success(DEF_ICON);
        }
        return success(favicon);
    }
}
