/*
 * 
 * 
 * 
 */
package com.eshop.service.impl;

import javax.annotation.Resource;

import com.eshop.dao.SpecificationDao;
import com.eshop.entity.Specification;
import com.eshop.service.SpecificationService;

import org.springframework.stereotype.Service;

/**
 * Service - 规格
 * 
 * 
 * 
 */
@Service("specificationServiceImpl")
public class SpecificationServiceImpl extends BaseServiceImpl<Specification, Long> implements SpecificationService {

	@Resource(name = "specificationDaoImpl")
	public void setBaseDao(SpecificationDao specificationDao) {
		super.setBaseDao(specificationDao);
	}

}