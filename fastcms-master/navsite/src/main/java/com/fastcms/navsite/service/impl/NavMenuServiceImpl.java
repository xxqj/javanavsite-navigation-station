package com.fastcms.navsite.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.fastcms.common.model.TreeNode;
import com.fastcms.common.model.TreeNodeConvert;
import com.fastcms.navsite.entity.NavMenu;
import com.fastcms.navsite.mapper.NavMenuMapper;
import com.fastcms.navsite.model.NavLinkNode;
import com.fastcms.navsite.model.NavMenuNode;
import com.fastcms.navsite.service.INavMenuService;
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
public class NavMenuServiceImpl<T extends TreeNode>  extends ServiceImpl<NavMenuMapper, NavMenu> implements INavMenuService , TreeNodeConvert<T> {

	@Override
	public List<NavMenuNode> getNavMenus() {
		List<NavMenu> list = list(Wrappers.<NavMenu>lambdaQuery().orderByAsc(NavMenu::getSortNum));
		return (List<NavMenuNode>) getNavMenuNodeList(list);
	}

	@Override
	public List<NavMenuNode> getNavCats() {
		List<NavMenu> list = list(Wrappers.<NavMenu>lambdaQuery().eq(NavMenu::getStatus, NavMenu.STATUS_SHOW).orderByAsc(NavMenu::getSortNum));
		return (List<NavMenuNode>) getNavMenuNodeList(list);
	}


	@Override
	public List<MenuNode> getMenus() {
		List<NavMenu> menus = list(Wrappers.<NavMenu>lambdaQuery().eq(NavMenu::getStatus, NavMenu.STATUS_SHOW));
		List<MenuNode> menuNodeList = menus.stream().map(item -> getMenuNode(item)).collect(Collectors.toList());;
		List<MenuNode> parentMenuList = menuNodeList.stream().filter(item -> item.getParentId() == 0).collect(Collectors.toList());
		parentMenuList.forEach(item -> getChildren(item, menuNodeList));
		return parentMenuList.stream().sorted(Comparator.comparing(MenuNode::getSortNum)).collect(Collectors.toList());
	}

	void getChildren(MenuNode menuNode, List<MenuNode> menuNodeList) {
		List<MenuNode> childrenNodeList = menuNodeList.stream().filter(item -> Objects.equals(item.getParentId(), menuNode.getId())).collect(Collectors.toList());
		if(childrenNodeList != null && !childrenNodeList.isEmpty()) {
			menuNode.setChildren(childrenNodeList);
			menuNode.setHasChildren(true);
			childrenNodeList.forEach(item -> getChildren(item, menuNodeList));
		}
	}

	MenuNode getMenuNode(NavMenu menu) {
		MenuNode menuNode = new MenuNode();
		BeanUtils.copyProperties(menu, menuNode);
		return menuNode;
	}


	List<T> getNavMenuNodeList(List<NavMenu> navMenuList) {
		return getTreeNodeList(navMenuList);
	}

	@Override
	public T convert2Node(Object object) {
		NavMenu navMenu = (NavMenu) object;
		NavMenuNode navMenuNode = new NavMenuNode(
				navMenu.getId(),
				navMenu.getParentId(),
				navMenu.getMenuName(),
				navMenu.getSortNum(),navMenu.getMenuName(),
				navMenu.getMenuIcon(),navMenu.getIsHide(),
				true,false,false);
		return (T) navMenuNode;
	}

}
