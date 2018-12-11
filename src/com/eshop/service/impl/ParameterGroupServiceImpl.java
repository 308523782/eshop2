/*
 * 
 * 
 * 
 */
package com.eshop.service.impl;

import javax.annotation.Resource;

import com.eshop.dao.ParameterGroupDao;
import com.eshop.entity.ParameterGroup;
import com.eshop.service.ParameterGroupService;

import org.springframework.stereotype.Service;

/**
 * Service - 参数组
 * 
 * 
 * 
 */
@Service("parameterGroupServiceImpl")
public class ParameterGroupServiceImpl extends BaseServiceImpl<ParameterGroup, Long> implements ParameterGroupService {

	@Resource(name = "parameterGroupDaoImpl")
	public void setBaseDao(ParameterGroupDao parameterGroupDao) {
		super.setBaseDao(parameterGroupDao);
	}

}