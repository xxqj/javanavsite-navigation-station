package com.fastcms.navsite.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.fastcms.core.template.StaticPathHelper;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 网站菜单
 *
 * @author wjun_java@163.com
 * @since 2021-05-27
 */
public class NavLink implements Serializable, StaticPathHelper {

    private static final long serialVersionUID = 1L;

    public static final String STATUS_SHOW = "show";
    public static final String STATUS_HIDDEN = "hidden";

    public static final Integer ARTICLE_URL_TYPE = 1;
    public static final Integer PAGE_URL_TYPE = 2;
    public static final Integer CATEGORY_URL_TYPE = 3;
    public static final Integer TAG_URL_TYPE = 4;

    /**
     * id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 创建者
     */
    @TableField(fill = FieldFill.INSERT)
    private Long createUserId;

    /**
     * 菜单名称
     */
    @NotBlank(message = "{fastcms.cms.template.menu.title.is.not.allow.empty}")
    private String linkName;

    /**
     * 菜单地址
     */
    @NotBlank(message = "{fastcms.cms.template.menu.url.is.not.allow.empty}")
    private String linkUrl;

    /**
     * 二维码地址
     */

    private String qrcode;

    /**
     * 菜单图标
     */
    private String linkIcon;

    /**
     * 排序
     */
    private Integer sortNum;

    /**
     * 打开方式
     */
    private String target;

    /**
     * 菜单跳转url类型 1，文章，2，页面，3，分类， 4，标签 5网页链接 6 友情链接
     */
    private Integer urlType;

    /**
     * 状态
     */
    private String status;

    private String linkDesc;

    private String catIds;

    /**
     * 页面后缀
     */
    private String suffix;

    /**
     * 访问量
     */
    private Integer viewCount;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime created;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updated;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLinkName() {
        return linkName;
    }

    public void setLinkName(String linkName) {
        this.linkName = linkName;
    }

    public String getLinkUrl() {
        return linkUrl;
    }

    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl;
    }

    public String getLinkIcon() {
        return linkIcon;
    }

    public void setLinkIcon(String linkIcon) {
        this.linkIcon = linkIcon;
    }

    public String getLinkDesc() {
        return linkDesc;
    }

    public void setLinkDesc(String linkDesc) {
        this.linkDesc = linkDesc;
    }

    public Long getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Long createUserId) {
        this.createUserId = createUserId;
    }

    public Integer getSortNum() {
        return sortNum;
    }

    public void setSortNum(Integer sortNum) {
        this.sortNum = sortNum;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public Integer getUrlType() {
        return urlType;
    }

    public void setUrlType(Integer urlType) {
        this.urlType = urlType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getCreated() {
        return created;
    }

    public void setCreated(LocalDateTime created) {
        this.created = created;
    }

    public LocalDateTime getUpdated() {
        return updated;
    }

    public void setUpdated(LocalDateTime updated) {
        this.updated = updated;
    }

    public String getCatIds() {
        return catIds;
    }

    public void setCatIds(String catIds) {
        this.catIds = catIds;
    }

    public String getQrcode() {
        return qrcode;
    }

    public void setQrcode(String qrcode) {
        this.qrcode = qrcode;
    }

    public Integer getViewCount() {
        return viewCount;
    }

    public void setViewCount(Integer viewCount) {
        this.viewCount = viewCount;
    }

    public String getSuffix() {
        return suffix;
    }

    public void setSuffix(String suffix) {
        this.suffix = suffix;
    }

    @Override
    public String getUrl() {

        if (linkUrl != null && !linkUrl.startsWith("http")
                && isEnable() && !linkUrl.endsWith(getStaticSuffix())) {

            String typePath = "";
            if (getUrlType() == ARTICLE_URL_TYPE) {
                typePath = getArticleStaticPath();
            } else if (getUrlType() == PAGE_URL_TYPE) {
                typePath = getPageStaticPath();
            } else if (getUrlType() == CATEGORY_URL_TYPE) {
                typePath = getCategoryStaticPath();
            }

            return getWebSiteDomain().concat(typePath).concat(linkUrl) + getStaticSuffix();
        }

        return linkUrl;
    }

}
