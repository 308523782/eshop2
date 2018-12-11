/*
 * 
 * 
 * 
 */
package com.eshop.service.impl;

import javax.annotation.Resource;

import com.eshop.dao.DeliveryCorpDao;
import com.eshop.entity.DeliveryCorp;
import com.eshop.service.DeliveryCorpService;

import org.springframework.stereotype.Service;

/**
 * Service - 物流公司
 * 
 * 
 * 
 */
@Service("deliveryCorpServiceImpl")
public class DeliveryCorpServiceImpl extends BaseServiceImpl<DeliveryCorp, Long> implements DeliveryCorpService {

	@Resource(name = "deliveryCorpDaoImpl")
	public void setBaseDao(DeliveryCorpDao deliveryCorpDao) {
		super.setBaseDao(deliveryCorpDao);
	}

}