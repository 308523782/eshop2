/*
 * 
 * 
 * 
 */
package com.eshop.service.impl;

import javax.annotation.Resource;

import com.eshop.dao.SpecificationValueDao;
import com.eshop.entity.SpecificationValue;
import com.eshop.service.SpecificationValueService;

import org.springframework.stereotype.Service;

/**
 * Service - 规格值
 * 
 * 
 * 
 */
@Service("specificationValueServiceImpl")
public class SpecificationValueServiceImpl extends BaseServiceImpl<SpecificationValue, Long> implements SpecificationValueService {

	@Resource(name = "specificationValueDaoImpl")
	public void setBaseDao(SpecificationValueDao specificationValueDao) {
		super.setBaseDao(specificationValueDao);
	}

}