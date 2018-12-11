/*
 * 
 * 
 * 
 */
package com.eshop.dao.impl;

import com.eshop.dao.CartItemDao;
import com.eshop.entity.CartItem;

import org.springframework.stereotype.Repository;

/**
 * Dao - 购物车项
 * 
 * 
 * 
 */
@Repository("cartItemDaoImpl")
public class CartItemDaoImpl extends BaseDaoImpl<CartItem, Long> implements CartItemDao {

}