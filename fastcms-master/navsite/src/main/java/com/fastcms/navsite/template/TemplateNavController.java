/**
 * Copyright (c) 广州小橘灯信息科技有限公司 2016-2017, wjun_java@163.com.
 * <p>
 * Licensed under the GNU Lesser General Public License (LGPL) ,Version 3.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.gnu.org/licenses/lgpl-3.0.txt
 * http://www.xjd2020.com
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.fastcms.navsite.template;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.fastcms.cms.entity.Article;
import com.fastcms.cms.entity.ArticleCategory;
import com.fastcms.cms.entity.ArticleTag;
import com.fastcms.cms.entity.SinglePage;
import com.fastcms.cms.service.IArticleCategoryService;
import com.fastcms.cms.service.IArticleService;
import com.fastcms.cms.service.IArticleTagService;
import com.fastcms.cms.service.ISinglePageService;
import com.fastcms.cms.task.SinglePageViewCountUpdateTask;
import com.fastcms.cms.template.TemplateBaseController;
import com.fastcms.common.utils.StrUtils;
import com.fastcms.core.template.FastcmsStaticHtmlManager;
import com.fastcms.navsite.entity.NavLink;
import com.fastcms.navsite.entity.NavMenu;
import com.fastcms.navsite.service.INavLinkService;
import com.fastcms.navsite.service.INavMenuService;
import com.fastcms.navsite.task.LinkViewCountUpdateTask;
import com.fastcms.navsite.vo.NavLinkVo;
import com.fastcms.utils.ApplicationUtils;
import org.apache.commons.compress.utils.Lists;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

import java.util.Arrays;
import java.util.List;

/**
 * @ignore
 * Freemarker模板
 * @author： 879081656@qq.com
 * @date： 2023/8/7
 * @description：
 * @modifiedBy：
 * @version: 1.0
 */
@Controller
public class TemplateNavController extends TemplateBaseController {

    static final String UNDERLINE = StrUtils.UNDERLINE;
    static final String INDEX = "index";

    static final String DEFAULT_NAV_VIEW = "site";
    static final String SITE_ATTR = "site";

    @Autowired
    private INavLinkService navLinkService;

    @Autowired
    private INavMenuService navMenuService;

    @RequestMapping("site/{navId}")
    public String path(@PathVariable("navId") String navId, Model model) {

        String _navId=navId.replace(".html","");

        NavLink navLink = navLinkService.getById(_navId);
        if(navLink!=null) {
           LinkViewCountUpdateTask.recordCount(Long.valueOf(_navId));

           String[] cats=navLink.getCatIds().split(",");
           List<String> nameList= Lists.newArrayList();
           for(int len=cats.length,i=0; i<len;i++){
              NavMenu m= navMenuService.getById(cats[i]);
              if(m!=null){
                  nameList.add(m.getMenuName());
              }
           }

            NavLinkVo vo= new NavLinkVo();
            BeanUtils.copyProperties(navLink,vo);
            vo.setCatNames(StrUtils.join(nameList,"|"));
            model.addAttribute(SITE_ATTR, vo);
         }

        String view = getTemplatePath() + DEFAULT_NAV_VIEW;
        if(navLink != null && StringUtils.isNotBlank(navLink.getSuffix())) {
            view = view.concat(UNDERLINE).concat(navLink.getSuffix());
        }

        return view;
    }



}
