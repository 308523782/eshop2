/*
 * 
 * 
 * 
 */
package com.eshop.service.impl;

import javax.annotation.Resource;

import com.eshop.dao.ParameterDao;
import com.eshop.entity.Parameter;
import com.eshop.service.ParameterService;

import org.springframework.stereotype.Service;

/**
 * Service - 参数
 * 
 * 
 * 
 */
@Service("parameterServiceImpl")
public class ParameterServiceImpl extends BaseServiceImpl<Parameter, Long> implements ParameterService {

	@Resource(name = "parameterDaoImpl")
	public void setBaseDao(ParameterDao parameterDao) {
		super.setBaseDao(parameterDao);
	}

}