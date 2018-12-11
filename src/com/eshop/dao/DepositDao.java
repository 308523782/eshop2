/*
 * 
 * 
 * 
 */
package com.eshop.dao;

import com.eshop.Page;
import com.eshop.Pageable;
import com.eshop.entity.Deposit;
import com.eshop.entity.Member;

/**
 * Dao - 预存款
 * 
 * 
 * 
 */
public interface DepositDao extends BaseDao<Deposit, Long> {

	/**
	 * 查找预存款分页
	 * 
	 * @param member
	 *            会员
	 * @param pageable
	 *            分页信息
	 * @return 预存款分页
	 */
	Page<Deposit> findPage(Member member, Pageable pageable);

}