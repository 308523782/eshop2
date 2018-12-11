/*
 * 
 * 
 * 
 */
package com.eshop.service.impl;

import javax.annotation.Resource;

import com.eshop.dao.AttributeDao;
import com.eshop.entity.Attribute;
import com.eshop.service.AttributeService;

import org.springframework.stereotype.Service;

/**
 * Service - 属性
 * 
 * 
 * 
 */
@Service("attributeServiceImpl")
public class AttributeServiceImpl extends BaseServiceImpl<Attribute, Long> implements AttributeService {

	@Resource(name = "attributeDaoImpl")
	public void setBaseDao(AttributeDao attributeDao) {
		super.setBaseDao(attributeDao);
	}

}