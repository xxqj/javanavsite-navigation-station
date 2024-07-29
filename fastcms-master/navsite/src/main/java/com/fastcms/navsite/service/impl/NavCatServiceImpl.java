package com.fastcms.navsite.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.fastcms.common.model.TreeNode;
import com.fastcms.common.model.TreeNodeConvert;
import com.fastcms.navsite.entity.NavMenu;
import com.fastcms.navsite.mapper.NavMenuMapper;
import com.fastcms.navsite.model.NavLinkNode;
import com.fastcms.navsite.model.NavMenuNode;
import com.fastcms.navsite.service.INavCatService;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * 网站菜单表 服务实现类
 * @author wjun_java@163.com
 * @since 2021-05-27
 */
@Service
public class NavCatServiceImpl<T extends TreeNode>  extends ServiceImpl<NavMenuMapper, NavMenu> implements INavCatService {


	@Override
	public List<NavLinkNode> getNavCats() {
		List<NavMenu> menus = list(Wrappers.<NavMenu>lambdaQuery().eq(NavMenu::getStatus, NavMenu.STATUS_SHOW).orderByAsc(NavMenu::getSortNum));
		List<NavLinkNode> menuNodeList = menus.stream().map(item -> getMenuNode(item)).collect(Collectors.toList());;
		List<NavLinkNode> parentMenuList = menuNodeList.stream().filter(item -> item.getParentId() == 0).collect(Collectors.toList());
		parentMenuList.forEach(item -> getChildren(item, menuNodeList));
		List<NavLinkNode> n=parentMenuList.stream().sorted(Comparator.comparing(NavLinkNode::getSortNum)).collect(Collectors.toList());

		return n;

	}

	@Override
	public List<NavLinkNode> getNavCatsAll() {
		List<NavMenu> menus = list(Wrappers.<NavMenu>lambdaQuery().orderByAsc(NavMenu::getSortNum));
		List<NavLinkNode> menuNodeList = menus.stream().map(item -> getMenuNode(item)).collect(Collectors.toList());;
		List<NavLinkNode> parentMenuList = menuNodeList.stream().filter(item -> item.getParentId() == 0).collect(Collectors.toList());
		parentMenuList.forEach(item -> getChildren(item, menuNodeList));
		List<NavLinkNode> n=parentMenuList.stream().sorted(Comparator.comparing(NavLinkNode::getSortNum)).collect(Collectors.toList());

		return n;
	}


	void getChildren(NavLinkNode menuNode, List<NavLinkNode> menuNodeList) {
		List<NavLinkNode> childrenNodeList = menuNodeList.stream().filter(item -> Objects.equals(item.getParentId(), menuNode.getId())).collect(Collectors.toList());
		if(childrenNodeList != null && !childrenNodeList.isEmpty()) {
			//menuNode.setChildren(childrenNodeList);
			menuNode.setHasChildren(true);
			menuNode.setChildren(childrenNodeList);
			childrenNodeList.forEach(item -> getChildren(item, menuNodeList));
		}
	}

	NavLinkNode getMenuNode(NavMenu navMenu) {
		NavLinkNode navMenuNode = new NavLinkNode(
				navMenu.getId(),
				navMenu.getParentId(),
				String.valueOf(navMenu.getId()),
				navMenu.getSortNum(),navMenu.getMenuName(),
				navMenu.getMenuIcon(),navMenu.getIsHide(),
				true);
		return navMenuNode;
	}




}
