import request from '/@/utils/request';

/**
 * 分页获取产品数据
 * @param params 
 * @returns 
 */
export function getProdList(params?: object) {
	return request({
		url: '/admin/prod/pageList',
		method: 'get',
		params,
	});
}

/**
 * 保存产品数据
 * @param params 
 * @returns 
 */
export function saveProd(params?: Object) {
	return request({
		url: '/admin/prod/save',
		method: 'post',
		params,
		//headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	});
}

/**
 * 删除产品数据
 * @param prodId
 * @returns 
 */
export function delProd(prodId?: string) {
	return request({
		url: '/admin/prod/delete/' + prodId,
		method: 'post'
	});
}

/**
 * 获取产品信息
 * @param params 
 * @returns 
 */
export function getProdInfo(userId?: string) {
	return request({
		url: '/admin/prod/'+userId+'/get',
		method: 'get',
	});
}

/**
 * 保存产品数据
 * @param params 
 * @returns 
 */
export function saveProductMeta(params?: Object) {
	return request({
		url: '/admin/prod/productMeta/save',
		method: 'post',
		params,
		//headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	});
}

/**
 * 获取产品信息
 * @param params 
 * @returns 
 */
export function getProductMeta(prodId?: string,params?: object) {
	return request({
		url: '/admin/prod/productMeta/'+prodId,
		method: 'get',
		params,
	});
}


/**
 * 分页获取产品数据
 * @param params 
 * @returns 
 */
export function getProdBannerList(prodId?: string,params?: object) {
	return request({
		url: '/admin/prod/productBanner/list/'+prodId,
		method: 'get',
		params,
	});
}

/**
 * 分页获取产品数据
 * @param params 
 * @returns 
 */
export function getProdBanner(id?: string) {
	return request({
		url: '/admin/prod/productBanner/'+id,
		method: 'get',
	});
}

/**
 * 保存产品数据
 * @param params 
 * @returns 
 */
export function saveProdBanner(params?: Object) {
	return request({
		url: '/admin/prod/prodBanner/save',
		method: 'post',
		params,
		//headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	});
}


/**
 * 分页获取产品数据
 * @param params 
 * @returns 
 */
export function getProdPicList(prodId?: string,params?: object) {
	return request({
		url: '/admin/prod/productPic/list/'+prodId,
		method: 'get',
		params,
	});
}

/**
 * 分页获取产品数据
 * @param params 
 * @returns 
 */
export function getProdPic(id?: string) {
	return request({
		url: '/admin/prod/productPic/'+id,
		method: 'get',
	});
}

/**
 * 保存产品数据
 * @param params 
 * @returns 
 */
export function saveProdPic(params?: Object) {
	return request({
		url: '/admin/prod/prodPic/save',
		method: 'post',
		params,
		//headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	});
}


/**
 * 分页获取产品数据
 * @param params 
 * @returns 
 */
export function getProdPdfList(prodId?: string,params?: object) {
	return request({
		url: '/admin/prod/productPdf/list/'+prodId,
		method: 'get',
		params,
	});
}

/**
 * 分页获取产品数据
 * @param params 
 * @returns 
 */
export function getProdPdf(id?: string) {
	return request({
		url: '/admin/prod/productPdf/'+id,
		method: 'get',
	});
}

/**
 * 保存产品数据
 * @param params 
 * @returns 
 */
export function saveProdPdf(params?: Object) {
	return request({
		url: '/admin/prod/prodPdf/save',
		method: 'post',
		params,
		//headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	});
}

/**
 * 分页获取产品数据
 * @param params 
 * @returns 
 */
export function getProdVideoList(prodId?: string,params?: object) {
	return request({
		url: '/admin/prod/productVideo/list/'+prodId,
		method: 'get',
		params,
	});
}

/**
 * 分页获取产品数据
 * @param params 
 * @returns 
 */
export function getProdVideo(id?: string) {
	return request({
		url: '/admin/prod/productVideo/'+id,
		method: 'get',
	});
}

/**
 * 保存产品数据
 * @param params 
 * @returns 
 */
export function saveProdVideo(params?: Object) {
	return request({
		url: '/admin/prod/prodVideo/save',
		method: 'post',
		params,
		//headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	});
}


/**
 * 删除产品pdf
 * @param fId
 * @returns 
 */
export function delProdPdf(fId?: string) {
	return request({
		url: '/admin/prod/delete/prodPdf/' + fId,
		method: 'post'
	});
}

/**
 * 删除产品pic
 * @param fId
 * @returns 
 */
export function delProdPic(pId?: string) {
	return request({
		url: '/admin/prod/delete/prodPic/' + pId,
		method: 'post'
	});
}


/**
 * 删除产品video
 * @param fId
 * @returns 
 */
export function delProdVideo(vId?: string) {
	return request({
		url: '/admin/prod/delete/prodVideo/' + vId,
		method: 'post'
	});
}


/**
 * 删除产品banner
 * @param bId
 * @returns 
 */
export function delProdBanner(bId?: string) {
	return request({
		url: '/admin/prod/delete/prodBanner/' + bId,
		method: 'post'
	});
}