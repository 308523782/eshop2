/*
 * 
 * 
 * 
 */
package com.eshop.service;

import com.eshop.entity.Sn.Type;

/**
 * Service - 序列号
 * 
 * 
 * 
 */
public interface SnService {

	/**
	 * 生成序列号
	 * 
	 * @param type
	 *            类型
	 * @return 序列号
	 */
	String generate(Type type);

}