package com.fastcms.navsite.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.fastcms.common.model.RouterNode;
import com.fastcms.navsite.entity.NavMenu;
import com.fastcms.navsite.model.NavLinkNode;
import com.fastcms.navsite.model.NavMenuNode;
import com.fasterxml.jackson.annotation.JsonIgnore;

import java.io.Serializable;
import java.util.List;

/**
 * 网站菜单服务类
 * @author wjun_java@163.com
 * @since 2021-05-27
 */
public interface INavMenuService extends IService<NavMenu> {


	/**
	 * 获取系统权限列表
	 * @return userId
	 */
	List<NavMenuNode> getNavMenus();

	/**
	 * 获取系统权限列表
	 * @return userId
	 */
	List<NavMenuNode> getNavCats();

	List<MenuNode> getMenus();

	class MenuNode extends NavMenu implements Serializable {
		@JsonIgnore
		boolean hasChildren = false;
		List<MenuNode> children;

		public boolean getHasChildren() {
			return hasChildren;
		}

		public boolean isHasChildren() {
			return hasChildren;
		}

		public void setHasChildren(boolean hasChildren) {
			this.hasChildren = hasChildren;
		}

		public List<MenuNode> getChildren() {
			return children;
		}

		public void setChildren(List<MenuNode> children) {
			this.children = children;
		}
	}

}
