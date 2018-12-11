/*
 * 
 * 
 * 
 */
package com.eshop.dao.impl;

import com.eshop.dao.OrderLogDao;
import com.eshop.entity.OrderLog;

import org.springframework.stereotype.Repository;

/**
 * Dao - 订单日志
 * 
 * 
 * 
 */
@Repository("orderLogDaoImpl")
public class OrderLogDaoImpl extends BaseDaoImpl<OrderLog, Long> implements OrderLogDao {

}