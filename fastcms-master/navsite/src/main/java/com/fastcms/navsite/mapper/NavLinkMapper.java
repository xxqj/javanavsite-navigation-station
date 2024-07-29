package com.fastcms.navsite.mapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.fastcms.navsite.entity.NavLink;
import com.fastcms.navsite.entity.NavMenu;
import com.fastcms.navsite.vo.NavLinkVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 网站菜单表 Mapper 接口
 * </p>
 *
 * @author wjun_java@163.com
 * @since 2021-05-27
 */
public interface NavLinkMapper extends BaseMapper<NavLink> {

    public Page<NavLinkVo> getPageLink(Page page, @Param("catIds") String catIds, @Param("linkName") String linkName);

    List<NavLinkVo> getLinkListByCategoryId(@Param(Constants.WRAPPER) QueryWrapper queryWrapper);

    List<NavLinkVo> getLinksListByUrlType(@Param(Constants.WRAPPER) QueryWrapper queryWrapper);

    void updateViewCount(@Param("id") Long id, @Param("count") Long count);

}
