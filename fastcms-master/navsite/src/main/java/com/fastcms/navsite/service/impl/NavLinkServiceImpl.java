package com.fastcms.navsite.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.fastcms.common.model.RestResultUtils;
import com.fastcms.common.utils.StrUtils;
import com.fastcms.navsite.entity.NavLink;
import com.fastcms.navsite.entity.NavMenuLink;
import com.fastcms.navsite.mapper.NavLinkMapper;
import com.fastcms.navsite.service.INavLinkService;
import com.fastcms.navsite.service.INavMenuLinkService;
import com.fastcms.navsite.vo.NavLinkVo;
import com.fastcms.utils.CollectionUtils;
import com.fastcms.utils.I18nUtils;
import org.apache.commons.compress.utils.Lists;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

import static com.fastcms.service.IPermissionService.PermissionI18n.ROUTES_CHILDREN_NOT_DELETE;

/**
 * <p>
 * 链接表 服务实现类
 * </p>
 *
 * @author 879081656@qq.com
 * @since 2023-03-09
 */
@Service
public class NavLinkServiceImpl extends ServiceImpl<NavLinkMapper, NavLink> implements INavLinkService {

    @Autowired
    private INavMenuLinkService navMenuLinkService;


    @Override
    public void updateViewCount(Long path, Long count) {
        getBaseMapper().updateViewCount(path, count);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean saveOrUpdate(NavLinkVo navLinkVo) {

        String[] cats= Optional.of(navLinkVo.getMenuIds()).get().split(",");

        if(navLinkVo.getId()!=null && navLinkVo.getId().intValue()!=0){
            //修改先删除关联表
            if(cats.length!=0){
                HashMap m=new HashMap();
                m.put("link_id",navLinkVo.getId());
                navMenuLinkService.removeByMap(m);
            }
        }
        NavLink link=new NavLink();
        BeanUtils.copyProperties(navLinkVo,link);
        link.setStatus(navLinkVo.getStatus());
        link.setCatIds(navLinkVo.getMenuIds());
        link.setLinkIcon(link.getLinkIcon()==null?(link.getLinkUrl()+"/favicon.ico"):link.getLinkIcon());
        this.saveOrUpdate(link);

        List<NavMenuLink> navMenuLinks= Lists.newArrayList();
        if(cats.length!=0){
            for(String c:cats){
                NavMenuLink lk =new NavMenuLink();
                lk.setMenuId(Long.valueOf(c));
                lk.setLinkId(link.getId());
                navMenuLinks.add(lk);

            }
        }

        return  navMenuLinkService.saveBatch(navMenuLinks);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean delLinkAndMenu(Long linkId) {
        //List<NavMenuLink> list = navMenuLinkService.list(Wrappers.<NavMenuLink>lambdaQuery().eq(NavMenuLink::getLinkId, linkId));
        //if(list != null && list.size()>0) {
        HashMap m=new HashMap();
        //m.put("menuId",c);
              m.put("link_id",linkId);
              //Todo
            navMenuLinkService.removeByMap(m);
       // }

        return this.removeById(linkId);
    }

    @Override
    public Page<NavLinkVo> getPageLink(Page page, String catIds,String linkName) {
        return this.baseMapper.getPageLink(page,catIds,linkName);
    }

    @Override
    public List<NavLinkVo> getLinksListByCategoryId(Long categoryId, List<Long> includeIds, List<Long> excludeIds, Integer count, String orderBy) {
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq(categoryId != null && categoryId > 0, "acr.menu_id", categoryId);
        queryWrapper.eq("a.status", "show");
        queryWrapper.eq("a.url_type", "5");
        queryWrapper.in(CollectionUtils.isNotEmpty(includeIds), "acr.menu_id", includeIds);
        queryWrapper.notIn(CollectionUtils.isNotEmpty(excludeIds), "acr.menu_id", excludeIds);
        if("a.sort_num".contentEquals(orderBy)){
            queryWrapper.orderByAsc(StrUtils.isNotBlank(orderBy), orderBy);
        }else {
            queryWrapper.orderByDesc(StrUtils.isNotBlank(orderBy), orderBy);
        }

        queryWrapper.last(count != null, "limit 0," + count);
        //System.out.println("getCustomSqlSegment="+queryWrapper.getCustomSqlSegment());
        return getBaseMapper().getLinkListByCategoryId(queryWrapper);
    }

    @Override
    public List<NavLinkVo> getLinksListByCategoryId(Long categoryId, Integer count, String orderBy) {
        return getLinksListByCategoryId(categoryId,null,null,count,orderBy);
    }

    @Override
    public List<NavLinkVo> getLinksListByCategoryId(Long categoryId, String orderBy) {
        return getLinksListByCategoryId(categoryId,null,orderBy);
    }

    @Override
    public List<NavLinkVo> getLinksListByUrlType(Integer urlType, String orderBy) {
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("a.status", "show");
        queryWrapper.eq("a.url_type", urlType);
        queryWrapper.orderByAsc(StrUtils.isNotBlank(orderBy), orderBy);
        return getBaseMapper().getLinksListByUrlType(queryWrapper);
    }


}
