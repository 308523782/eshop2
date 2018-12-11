/*
 * 
 * 
 * 
 */
package com.eshop.service.impl;

import javax.annotation.Resource;

import com.eshop.dao.DeliveryCenterDao;
import com.eshop.entity.DeliveryCenter;
import com.eshop.service.DeliveryCenterService;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service - 广告
 * 
 * 
 * 
 */
@Service("deliveryCenterServiceImpl")
public class DeliveryCenterServiceImpl extends BaseServiceImpl<DeliveryCenter, Long> implements DeliveryCenterService {

	@Resource(name = "deliveryCenterDaoImpl")
	private DeliveryCenterDao deliveryCenterDao;

	@Resource(name = "deliveryCenterDaoImpl")
	public void setBaseDao(DeliveryCenterDao DeliveryCenterDao) {
		super.setBaseDao(DeliveryCenterDao);
	}

	@Transactional(readOnly = true)
	public DeliveryCenter findDefault() {
		return deliveryCenterDao.findDefault();
	}

}