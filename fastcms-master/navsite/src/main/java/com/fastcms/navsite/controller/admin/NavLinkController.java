package com.fastcms.navsite.controller.admin;


import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.fastcms.common.auth.ActionTypes;
import com.fastcms.common.auth.Secured;
import com.fastcms.common.constants.FastcmsConstants;
import com.fastcms.common.model.RestResult;
import com.fastcms.common.model.RestResultUtils;
import com.fastcms.core.auth.AuthUtils;
import com.fastcms.core.mybatis.PageModel;
import com.fastcms.navsite.entity.NavMenu;
import com.fastcms.navsite.entity.NavMenuLink;
import com.fastcms.navsite.model.NavLinkNode;
import com.fastcms.navsite.model.NavMenuNode;
import com.fastcms.navsite.service.INavCatService;
import com.fastcms.navsite.service.INavLinkService;
import com.fastcms.navsite.service.INavMenuLinkService;
import com.fastcms.navsite.service.INavMenuService;
import com.fastcms.navsite.vo.NavLinkVo;
import com.fastcms.utils.I18nUtils;
import org.apache.commons.lang3.StringUtils;
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
@RequestMapping(FastcmsConstants.ADMIN_MAPPING + "/navlink")
public class NavLinkController {

    @Autowired
    private INavLinkService navLinkService;

    @Autowired
    private INavCatService navCatService;

    @Autowired
    private INavMenuLinkService navMenuLinkService;

    /**
     * 路由列表
     * @return
     */
    @GetMapping("catList")
    @Secured(name = RESOURCE_NAME_NAVLINK_CLIST, resource = "navlink:clist", action = ActionTypes.READ)
    public RestResult<List<NavLinkNode>> catList() {
        return RestResultUtils.success(navCatService.getNavCatsAll());
    }


    /**
     * 用户列表
     * @param page
     * @param catIds    产品类目
     * @return
     */
    @RequestMapping("pageList")
    @Secured(name = RESOURCE_NAME_NAVLINK_PLIST, resource = "navlink:plist", action = ActionTypes.READ)
    public RestResult<Page<NavLinkVo>> pageList(PageModel page,
                                              @RequestParam(name = "catIds", required = false) String catIds,
                                                @RequestParam(name = "linkName", required = false) String linkName
                                                ) {

        return  RestResultUtils.success(navLinkService.getPageLink(page.toPage(),catIds,linkName));
    }



    /**
     * 保存路由
     * @param navLinkVo
     * @return
     */
    @PostMapping("save")
    @Secured(name = RESOURCE_NAME_NAVLINK_SAVE, resource = "navlink:save", action = ActionTypes.WRITE)
    public RestResult<Boolean> save(@Validated NavLinkVo navLinkVo) {
        return RestResultUtils.success(navLinkService.saveOrUpdate(navLinkVo));
    }

    /**
     * 删除路由
     * @param linkId
     * @return
     */
    @PostMapping("delete/{linkId}")
    @Secured(name = RESOURCE_NAME_NAVLINK_DELETE, resource = "navlink:delete", action = ActionTypes.WRITE)
    public RestResult<Object> del(@PathVariable("linkId") Long linkId) {

        return RestResultUtils.success(navLinkService.delLinkAndMenu(linkId));

    }



}
