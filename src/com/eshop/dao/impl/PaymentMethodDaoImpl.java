/*
 * 
 * 
 * 
 */
package com.eshop.dao.impl;

import com.eshop.dao.PaymentMethodDao;
import com.eshop.entity.PaymentMethod;

import org.springframework.stereotype.Repository;

/**
 * Dao - 支付方式
 * 
 * 
 * 
 */
@Repository("paymentMethodDaoImpl")
public class PaymentMethodDaoImpl extends BaseDaoImpl<PaymentMethod, Long> implements PaymentMethodDao {

}