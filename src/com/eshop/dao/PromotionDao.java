/*
 * 
 * 
 * 
 */
package com.eshop.dao;

import java.util.List;

import com.eshop.Filter;
import com.eshop.Order;
import com.eshop.entity.Promotion;

/**
 * Dao - 促销
 * 
 * 
 * 
 */
public interface PromotionDao extends BaseDao<Promotion, Long> {

	/**
	 * 查找促销
	 * 
	 * @param hasBegun
	 *            是否已开始
	 * @param hasEnded
	 *            是否已结束
	 * @param count
	 *            数量
	 * @param filters
	 *            筛选
	 * @param orders
	 *            排序
	 * @return 促销
	 */
	List<Promotion> findList(Boolean hasBegun, Boolean hasEnded, Integer count, List<Filter> filters, List<Order> orders);

}