/*
 * 
 * 
 * 
 */
package com.eshop.dao.impl;

import com.eshop.dao.SpecificationDao;
import com.eshop.entity.Specification;

import org.springframework.stereotype.Repository;

/**
 * Dao - 规格
 * 
 * 
 * 
 */
@Repository("specificationDaoImpl")
public class SpecificationDaoImpl extends BaseDaoImpl<Specification, Long> implements SpecificationDao {

}