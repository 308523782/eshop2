/*
 * 
 * 
 * 
 */
package com.eshop.service.impl;

import javax.annotation.Resource;

import com.eshop.dao.PluginConfigDao;
import com.eshop.entity.PluginConfig;
import com.eshop.service.PluginConfigService;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service - 插件配置
 * 
 * 
 * 
 */
@Service("pluginConfigServiceImpl")
public class PluginConfigServiceImpl extends BaseServiceImpl<PluginConfig, Long> implements PluginConfigService {

	@Resource(name = "pluginConfigDaoImpl")
	private PluginConfigDao pluginConfigDao;

	@Resource(name = "pluginConfigDaoImpl")
	public void setBaseDao(PluginConfigDao pluginConfigDao) {
		super.setBaseDao(pluginConfigDao);
	}

	@Transactional(readOnly = true)
	public boolean pluginIdExists(String pluginId) {
		return pluginConfigDao.pluginIdExists(pluginId);
	}

	@Transactional(readOnly = true)
	public PluginConfig findByPluginId(String pluginId) {
		return pluginConfigDao.findByPluginId(pluginId);
	}

}