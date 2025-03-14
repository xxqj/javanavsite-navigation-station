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
package com.fastcms.cms.directive;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fastcms.cms.entity.ArticleCategory;
import com.fastcms.cms.service.IArticleCategoryService;
import com.fastcms.common.utils.StrUtils;
import com.fastcms.core.directive.BaseDirective;
import freemarker.core.Environment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * 获取某个分类下的直接子分类
 * <@categoryList parentId=category.id! type="" orderBy="" count="10">
 *     <#if data??>
 *         <#list data as item>
 *             ${(item.id)!}
 *             ${(item.title)!}
 *             ${(item.icon)!}
 *             ${(item.url)!}
 *      		...
 *         </#list>
 *     </#if>
 * </@categoryList>
 *
 * @author： wjun_java@163.com
 * @date： 2021/5/24
 * @description：
 * @modifiedBy：
 * @version: 1.0
 */
@Component("categoryList")
public class CategoryListDirective extends BaseDirective {

	static final String PARAM_TYPE = "type";
	static final String PARAM_PARENT_ID = "parentId";

	@Autowired
	private IArticleCategoryService articleCategoryService;

	@Override
	public Object doExecute(Environment env, Map params) {
		final String type = getStr(PARAM_TYPE, params, ArticleCategory.CATEGORY_TYPE);
		final Integer count = getInt(PARAM_COUNT, params, Integer.valueOf(getStr("cnt", params,"10")));
		final String orderBy = getStr(PARAM_ORDER_BY, params, "created");
		final Long parentId = getLong(PARAM_PARENT_ID, params, 0l);

		QueryWrapper queryWrapper = new QueryWrapper();
		queryWrapper.eq(parentId != 0, "parent_id", parentId);
		queryWrapper.eq(StrUtils.isNotBlank(type),"type", type);
		queryWrapper.last(count > 0,"limit 0," + count);
		queryWrapper.orderByDesc(orderBy);

		return articleCategoryService.list(queryWrapper);
	}

}
