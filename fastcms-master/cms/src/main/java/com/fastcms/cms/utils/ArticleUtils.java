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
package com.fastcms.cms.utils;

import com.fastcms.cms.entity.Article;
import com.fastcms.cms.entity.ArticleCategory;
import com.fastcms.cms.entity.ArticleTag;
import com.fastcms.cms.order.FastcmsArticlePriceServiceManager;
import com.fastcms.utils.ApplicationUtils;
import com.fastcms.utils.ConfigUtils;
import org.apache.commons.lang.StringUtils;

import java.math.BigDecimal;

/**
 * @author： wjun_java@163.com
 * @date： 2022/2/15
 * @description：
 * @modifiedBy：
 * @version: 1.0
 */
public abstract class ArticleUtils {

    /**
     * 是否开启付费 (全站开启，优先级低于单个文件设置)
     * 付费阅读 | 付费下载
     */
    public static final String GLOBAL_ARTICLE_ENABLE_NEED_TO_PAY = "global_enable_need_to_pay";

    /**
     * 指定文章开启付费
     */
    public static final String ARTICLE_ENABLE_NEED_TO_PAY = "enableNeedToPay";

    /**
     * 是否开启文章评论审核
     */
    public static final String ENABLE_ARTICLE_COMMENT_ADMIN_VERIFY = "enableArticleCommentAdminVerify";

    /**
     * 是否开启全局文章评论功能
     */
    public static final String ENABLE_ARTICLE_COMMENT = "enableArticleComment";

    /**
     * 文章价格
     */
    public static final String ARTICLE_PRICE = "price";

    public static boolean isEnableNeedToPay() {
        return ConfigUtils.getBool(GLOBAL_ARTICLE_ENABLE_NEED_TO_PAY, true);
    }

    public static boolean isEnableNeedToPay(Article article) {
        try {
            if (getFieldProperty(article, ARTICLE_ENABLE_NEED_TO_PAY) == null) return true;
            return Boolean.parseBoolean((String) getFieldProperty(article, ARTICLE_ENABLE_NEED_TO_PAY));
        } catch (Exception e) {
            return true;
        }
    }

    public static BigDecimal getPrice(Article article) {

        if (article.getPriceClass() != null) {
            BigDecimal price = ApplicationUtils.getBean(FastcmsArticlePriceServiceManager.class).getPrice(article);
            if (price != null) {
                return price;
            }
        }

        Object fieldProperty = getFieldProperty(article, ARTICLE_PRICE);
        try {
            return fieldProperty == null ? BigDecimal.ZERO : new BigDecimal((String) fieldProperty);
        } catch (Exception e) {
            return BigDecimal.ZERO;
        }
    }

    public static Object getFieldProperty(Article article, String property) {
        return (article.getExtFields() == null) ? null : article.getExtFields().get(property);
    }

    public static boolean isEnableArticleCommentAdminVerify() {
        return ConfigUtils.getBool(ENABLE_ARTICLE_COMMENT_ADMIN_VERIFY, true);
    }

    public static boolean isEnableArticleComment() {
        return ConfigUtils.getBool(ENABLE_ARTICLE_COMMENT);
    }

    public static String getUrl(Article article) {
        if (StringUtils.isNotBlank(article.getOutLink())) {
            return article.getOutLink();
        }

        String url = article.getWebSiteDomain().concat(article.getArticleStaticPath()) + article.getId();

        if (article.isEnable()) {
            url = url.concat(article.getStaticSuffix());
        }

        return url;
    }

    public static String getArticleCategoryUrl(ArticleCategory articleCategory) {

        String url = articleCategory.getWebSiteDomain().concat(articleCategory.getCategoryStaticPath()) + articleCategory.getId();

        if (articleCategory.isEnable()) {
            url = url.concat(articleCategory.getStaticSuffix());
        }

        return url;
    }

    public static String getArticleTagUrl(ArticleTag articleTag) {

        String url = articleTag.getWebSiteDomain().concat(articleTag.getTagStaticPath()) + articleTag.getId();

        if (articleTag.isEnable()) {
            url = url.concat(articleTag.getStaticSuffix());
        }

        return url;
    }

}
