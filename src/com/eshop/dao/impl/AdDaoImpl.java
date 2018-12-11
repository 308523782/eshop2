/*
 * 
 * 
 * 
 */
package com.eshop.dao.impl;

import com.eshop.dao.AdDao;
import com.eshop.entity.Ad;

import org.springframework.stereotype.Repository;

/**
 * Dao - 广告
 * 
 * 
 * 
 */
@Repository("adDaoImpl")
public class AdDaoImpl extends BaseDaoImpl<Ad, Long> implements AdDao {

}