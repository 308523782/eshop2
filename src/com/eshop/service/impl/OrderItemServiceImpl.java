/*
 * 
 * 
 * 
 */
package com.eshop.service.impl;

import javax.annotation.Resource;

import com.eshop.dao.OrderItemDao;
import com.eshop.entity.OrderItem;
import com.eshop.service.OrderItemService;

import org.springframework.stereotype.Service;

/**
 * Service - 订单项
 * 
 * 
 * 
 */
@Service("orderItemServiceImpl")
public class OrderItemServiceImpl extends BaseServiceImpl<OrderItem, Long> implements OrderItemService {

	@Resource(name = "orderItemDaoImpl")
	public void setBaseDao(OrderItemDao orderItemDao) {
		super.setBaseDao(orderItemDao);
	}

}