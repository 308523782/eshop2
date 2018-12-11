/*
 * 
 * 
 * 
 */
package com.eshop.dao.impl;

import com.eshop.dao.OrderItemDao;
import com.eshop.entity.OrderItem;

import org.springframework.stereotype.Repository;

/**
 * Dao - 订单项
 * 
 * 
 * 
 */
@Repository("orderItemDaoImpl")
public class OrderItemDaoImpl extends BaseDaoImpl<OrderItem, Long> implements OrderItemDao {

}