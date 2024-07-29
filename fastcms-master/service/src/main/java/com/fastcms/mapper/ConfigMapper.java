package com.fastcms.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.fastcms.entity.Config;
import com.fastcms.vo.ConfigVo;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author wjun_java@163.com
 * @since 2021-02-14
 */
public interface ConfigMapper extends BaseMapper<Config> {
    public Page<ConfigVo> getPageConfig(Page page, @Param("typeId") String typeId, @Param("cfgName") String cfgName, @Param("keyName") String keyName);
}
