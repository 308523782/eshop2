/*
 * 
 * 
 * 
 */
package com.eshop.service.impl;

import javax.annotation.Resource;

import com.eshop.dao.ShippingMethodDao;
import com.eshop.entity.ShippingMethod;
import com.eshop.service.ShippingMethodService;

import org.springframework.stereotype.Service;

/**
 * Service - 配送方式
 * 
 * 
 * 
 */
@Service("shippingMethodServiceImpl")
public class ShippingMethodServiceImpl extends BaseServiceImpl<ShippingMethod, Long> implements ShippingMethodService {

	@Resource(name = "shippingMethodDaoImpl")
	public void setBaseDao(ShippingMethodDao shippingMethodDao) {
		super.setBaseDao(shippingMethodDao);
	}

}