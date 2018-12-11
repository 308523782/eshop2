/*
 * 
 * 
 * 
 */
package com.eshop.service.impl;

import javax.annotation.Resource;

import com.eshop.dao.ReturnsDao;
import com.eshop.entity.Returns;
import com.eshop.service.ReturnsService;

import org.springframework.stereotype.Service;

/**
 * Service - 退货单
 * 
 * 
 * 
 */
@Service("returnsServiceImpl")
public class ReturnsServiceImpl extends BaseServiceImpl<Returns, Long> implements ReturnsService {

	@Resource(name = "returnsDaoImpl")
	public void setBaseDao(ReturnsDao returnsDao) {
		super.setBaseDao(returnsDao);
	}

}