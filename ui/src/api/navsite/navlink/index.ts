import request from '/@/utils/request';


/**
 * 分页获取产品数据
 * @param params 
 * @returns 
 */
export function getpList(params?: object) {
	return request({
		url: '/admin/navlink/pageList',
		method: 'get',
		params,
	});
}

/**
 * 获取全部菜单数据
 * @param params 
 * @returns 
 */
export function getNavCatList(params?: object) {
	return request({
		url: '/admin/navlink/catList',
		method: 'get',
		params,
	});
}

/**
 * 保存菜单数据
 * @param params 
 * @returns 
 */
export function saveNavLink(params?: object) {
	return request({
		url: '/admin/navlink/save',
		method: 'post',
		params,
	});
}

/**
 * 删除菜单数据
 * @param navId 
 * @returns 
 */
export function delNavLink(navId?: string) {
	return request({
		url: '/admin/navlink/delete/'+navId,
		method: 'post'
	});
}
