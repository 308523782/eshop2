/*
 * 
 * 
 * 
 */
package com.eshop.service.impl;

import java.util.Date;

import javax.annotation.Resource;
import javax.persistence.LockModeType;

import com.eshop.dao.PaymentDao;
import com.eshop.entity.Member;
import com.eshop.entity.Orders;
import com.eshop.entity.Payment;
import com.eshop.entity.Payment.Status;
import com.eshop.entity.Payment.Type;
import com.eshop.service.MemberService;
import com.eshop.service.OrderService;
import com.eshop.service.PaymentService;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service - 收款单
 * 
 * 
 * 
 */
@Service("paymentServiceImpl")
public class PaymentServiceImpl extends BaseServiceImpl<Payment, Long> implements PaymentService {

	@Resource(name = "paymentDaoImpl")
	private PaymentDao paymentDao;
	@Resource(name = "orderServiceImpl")
	private OrderService orderService;
	@Resource(name = "memberServiceImpl")
	private MemberService memberService;

	@Resource(name = "paymentDaoImpl")
	public void setBaseDao(PaymentDao paymentDao) {
		super.setBaseDao(paymentDao);
	}

	@Transactional(readOnly = true)
	public Payment findBySn(String sn) {
		return paymentDao.findBySn(sn);
	}

	public void handle(Payment payment) {
		paymentDao.refresh(payment, LockModeType.PESSIMISTIC_WRITE);
		if (payment != null && payment.getStatus() == Status.wait) {
			if (payment.getType() == Type.payment) {
				Orders order = payment.getOrder();
				if (order != null) {
					orderService.payment(order, payment, null);
				}
			} else if (payment.getType() == Type.recharge) {
				Member member = payment.getMember();
				if (member != null) {
					memberService.update(member, null, payment.getEffectiveAmount(), null, null);
				}
			}
			payment.setStatus(Status.success);
			payment.setPaymentDate(new Date());
			paymentDao.merge(payment);
		}
	}

}