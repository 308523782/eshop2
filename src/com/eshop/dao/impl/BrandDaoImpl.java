/*
 * 
 * 
 * 
 */
package com.eshop.dao.impl;

import com.eshop.dao.BrandDao;
import com.eshop.entity.Brand;

import org.springframework.stereotype.Repository;

/**
 * Dao - 品牌
 * 
 * 
 * 
 */
@Repository("brandDaoImpl")
public class BrandDaoImpl extends BaseDaoImpl<Brand, Long> implements BrandDao {

}