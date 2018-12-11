/*
 * 
 * 
 * 
 */
package com.eshop.service.impl;

import javax.annotation.Resource;

import com.eshop.dao.RefundsDao;
import com.eshop.entity.Refunds;
import com.eshop.service.RefundsService;

import org.springframework.stereotype.Service;

/**
 * Service - 退款单
 * 
 * 
 * 
 */
@Service("refundsServiceImpl")
public class RefundsServiceImpl extends BaseServiceImpl<Refunds, Long> implements RefundsService {

	@Resource(name = "refundsDaoImpl")
	public void setBaseDao(RefundsDao refundsDao) {
		super.setBaseDao(refundsDao);
	}

}