/*
 * 
 * 
 * 
 */
package com.eshop.service.impl;

import javax.annotation.Resource;

import com.eshop.dao.CartItemDao;
import com.eshop.entity.CartItem;
import com.eshop.service.CartItemService;

import org.springframework.stereotype.Service;

/**
 * Service - 购物车项
 * 
 * 
 * 
 */
@Service("cartItemServiceImpl")
public class CartItemServiceImpl extends BaseServiceImpl<CartItem, Long> implements CartItemService {

	@Resource(name = "cartItemDaoImpl")
	public void setBaseDao(CartItemDao cartItemDao) {
		super.setBaseDao(cartItemDao);
	}

}