package com.fastcms.navsite.service;

import com.baomidou.mybatisplus.extension.service.IService;
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
public interface INavCatService extends IService<NavMenu> {


	/**
	 * 获取系统权限列表
	 * @return userId
	 */


	List<NavLinkNode> getNavCats();

	List<NavLinkNode> getNavCatsAll();


}
