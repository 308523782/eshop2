/*
 * 
 * 
 * 
 */
package com.eshop.service.impl;

import javax.annotation.Resource;

import com.eshop.dao.OrderLogDao;
import com.eshop.entity.OrderLog;
import com.eshop.service.OrderLogService;

import org.springframework.stereotype.Service;

/**
 * Service - 订单日志
 * 
 * 
 * 
 */
@Service("orderLogServiceImpl")
public class OrderLogServiceImpl extends BaseServiceImpl<OrderLog, Long> implements OrderLogService {

	@Resource(name = "orderLogDaoImpl")
	public void setBaseDao(OrderLogDao orderLogDao) {
		super.setBaseDao(orderLogDao);
	}

}