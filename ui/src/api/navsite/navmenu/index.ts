import request from '/@/utils/request';

/**
 * 获取后端动态路由菜单(根据用户权限加载菜单)
 * @param params 要传的参数值，非必传
 * @returns 返回接口数据
 */
export function getUserNavMenus(params?: object) {
	return request({
		url: '/admin/navmenu/menus',
		method: 'get',
		params,
	});
}

/**
 * 获取全部菜单数据
 * @param params 
 * @returns 
 */
export function getNavMenuList(params?: object) {
	return request({
		url: '/admin/navmenu/list',
		method: 'get',
		params,
	});
}

/**
 * 保存菜单数据
 * @param params 
 * @returns 
 */
export function saveNavMenu(params?: object) {
	return request({
		url: '/admin/navmenu/save',
		method: 'post',
		params,
	});
}

/**
 * 删除菜单数据
 * @param navId 
 * @returns 
 */
export function delNavMenu(navId?: string) {
	return request({
		url: '/admin/navmenu/delete/'+navId,
		method: 'post'
	});
}
