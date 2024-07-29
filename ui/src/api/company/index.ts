import request from '/@/utils/request';

/**
 * 获取公司数据
 * @param params 
 * @returns 
 */
export function getCompyList(params?: object) {
	return request({
		url: '/admin/company/list',
		method: 'get',
		params,
	});
}

/**
 * 保存公司数据
 * @param params 
 * @returns 
 */
export function saveCompy(params?: object) {
	return request({
		url: '/admin/company/save',
		method: 'post',
		params,
	});
}

/**
 * 删除公司数据
 * @param deptId 
 * @returns 
 */
export function delCompy(deptId?: string) {
	return request({
		url: '/admin/company/delete/'+deptId,
		method: 'post'
	});
}