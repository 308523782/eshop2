/*
 * 
 * 
 * 
 */
package com.eshop.dao;

import com.eshop.entity.Cart;

/**
 * Dao - 购物车
 * 
 * 
 * 
 */
public interface CartDao extends BaseDao<Cart, Long> {

	/**
	 * 清除过期购物车
	 */
	void evictExpired();

}