/*
 * 
 * 
 * 
 */
package com.eshop.service.impl;

import javax.annotation.Resource;

import com.eshop.dao.PaymentMethodDao;
import com.eshop.entity.PaymentMethod;
import com.eshop.service.PaymentMethodService;

import org.springframework.stereotype.Service;

/**
 * Service - 支付方式
 * 
 * 
 * 
 */
@Service("paymentMethodServiceImpl")
public class PaymentMethodServiceImpl extends BaseServiceImpl<PaymentMethod, Long> implements PaymentMethodService {

	@Resource(name = "paymentMethodDaoImpl")
	public void setBaseDao(PaymentMethodDao paymentMethodDao) {
		super.setBaseDao(paymentMethodDao);
	}

}