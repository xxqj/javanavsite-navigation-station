package com.fastcms.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.fastcms.entity.Config;
import com.fastcms.vo.ConfigVo;

import java.util.List;

/**
 *  配置服务类
 * @author wjun_java@163.com
 * @since 2021-02-14
 */
public interface IConfigService extends IService<Config> {

	Config findByKey(String key);

	String getValue(String key);

	Config saveConfig(String key, String value);

	/**
	 * 获取多个配置
	 * @param configKeys
	 * @return
	 */
	List<Config> getConfigs(List<String> configKeys);

	List<Config> getAllConfigs();


	public Page<ConfigVo> getPageConfig(Page page, String typeId, String cfgName,String keyName);

	/**
	 * 获取对外开放的配置
	 * @param configKeys
	 * @return
	 */
	List<Config> getPublicConfigs(List<String> configKeys);

}
