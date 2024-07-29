package com.fastcms.navsite.controller.admin;


import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.fastcms.common.auth.ActionTypes;
import com.fastcms.common.auth.Secured;
import com.fastcms.common.constants.FastcmsConstants;
import com.fastcms.common.model.RestResult;
import com.fastcms.common.model.RestResultUtils;
import com.fastcms.common.model.RouterNode;
import com.fastcms.core.auth.AuthUtils;
import com.fastcms.entity.Permission;
import com.fastcms.navsite.entity.NavMenu;
import com.fastcms.navsite.model.NavMenuNode;
import com.fastcms.navsite.service.INavMenuService;
import com.fastcms.service.IPermissionService;
import com.fastcms.utils.I18nUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.fastcms.service.IPermissionService.PermissionI18n.ROUTES_CHILDREN_NOT_DELETE;
import static com.fastcms.service.IResourceService.ResourceI18n.*;

/**
 * 导航菜单
 * @author： 879081656@qq.com
 * @date： 2023/06/30
 * @description：
 * @modifiedBy：
 * @version: 1.0
 */
@RestController
@RequestMapping(FastcmsConstants.ADMIN_MAPPING + "/navmenu")
public class NavMenuController {

    @Autowired
    private INavMenuService navMenuService;

    /**
     * 路由列表
     * @return
     */
    @GetMapping("list")
    @Secured(name = RESOURCE_NAME_NAVMENU_LIST, resource = "navmenu:list", action = ActionTypes.READ)
    public RestResult<List<NavMenuNode>> list() {
        return RestResultUtils.success(navMenuService.getNavMenus());
    }

    /**
     * 保存路由
     * @param navMenu
     * @return
     */
    @PostMapping("save")
    @Secured(name = RESOURCE_NAME_NAVMENU_SAVE, resource = "navmenu:save", action = ActionTypes.WRITE)
    public RestResult<Boolean> save(@Validated NavMenu navMenu) {
        navMenu.setStatus(navMenu.getIsHide());
        return RestResultUtils.success(navMenuService.saveOrUpdate(navMenu));
    }

    /**
     * 删除路由
     * @param navId
     * @return
     */
    @PostMapping("delete/{navId}")
    @Secured(name = RESOURCE_NAME_NAVMENU_DELETE, resource = "navmenu:delete", action = ActionTypes.WRITE)
    public RestResult<Object> delMenu(@PathVariable("navId") Long navId) {
        List<NavMenu> list = navMenuService.list(Wrappers.<NavMenu>lambdaQuery().eq(NavMenu::getParentId, navId));
        if(list != null && list.size()>0) {
            return RestResultUtils.failed("请删除子分类");
        }
        return RestResultUtils.success(navMenuService.removeById(navId));
    }



}
