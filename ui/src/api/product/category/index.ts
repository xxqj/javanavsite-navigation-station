import request from '/@/utils/request';

/**
 * 获取产品分类数据
 * @param params 
 * @returns 
 */
export function getCategoryList(params?: object) {
	return request({
		url: '/admin/prodcategory/list',
		method: 'get',
		params,
	});
}

/**
 * 保存产品分类数据
 * @param params 
 * @returns 
 */
export function saveCategory(params?: object) {
	return request({
		url: '/admin/prodcategory/save',
		method: 'post',
		params,
	});
}

/**
 * 删除分类数据
 * @param Category 
 * @returns 
 */
export function delCategory(categoryId?: string) {
	return request({
		url: '/admin/prodcategory/delete/'+categoryId,
		method: 'post'
	});
}