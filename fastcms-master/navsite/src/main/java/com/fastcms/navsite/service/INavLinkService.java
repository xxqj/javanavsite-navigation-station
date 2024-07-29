package com.fastcms.navsite.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.fastcms.navsite.entity.NavLink;
import com.fastcms.navsite.entity.NavMenu;
import com.fastcms.navsite.model.NavMenuNode;
import com.fastcms.navsite.vo.NavLinkVo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.apache.ibatis.annotations.Param;

import java.io.Serializable;
import java.util.List;

/**
 * 网站菜单服务类
 * @author wjun_java@163.com
 * @since 2021-05-27
 */
public interface INavLinkService extends IService<NavLink> {


    /**
     * 更新页面浏览数量
     * @param path
     * @param count
     */
    void updateViewCount(Long path, Long count);

    public boolean saveOrUpdate(NavLinkVo navLinkVo);

    public boolean delLinkAndMenu(Long linkId);

    public Page<NavLinkVo> getPageLink(Page page, String catIds,String linkName);

    /**
     * 根据分类查询文章列表
     * @param categoryId    查询具体分类
     * @param includeIds    查询包含分类
     * @param excludeIds    查询排查分类
     * @param count         查询数量
     * @param orderBy       排序条件
     * @return
     */
    List<NavLinkVo> getLinksListByCategoryId(Long categoryId, List<Long> includeIds, List<Long> excludeIds, Integer count, String orderBy);

    /**
     * 根据分类ID查询文章列表
     * @param categoryId    查询具体分类
     * @param count         查询数量
     * @param orderBy       排序条件
     * @return
     */
    List<NavLinkVo> getLinksListByCategoryId(Long categoryId, Integer count, String orderBy);

    /**
     * 根据分类id查询文章列表
     * @param categoryId
     * @param orderBy
     * @return
     */
    List<NavLinkVo> getLinksListByCategoryId(Long categoryId, String orderBy);


    List<NavLinkVo> getLinksListByUrlType(Integer urlType, String orderBy);
}
