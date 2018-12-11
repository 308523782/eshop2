/*
 * 
 * 
 * 
 */
package com.eshop.dao.impl;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.persistence.FlushModeType;
import javax.persistence.LockModeType;
import javax.persistence.NoResultException;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import com.eshop.Filter;
import com.eshop.Page;
import com.eshop.Pageable;
import com.eshop.dao.OrderDao;
import com.eshop.entity.Member;
import com.eshop.entity.Orders;
import com.eshop.entity.Orders.OrderStatus;
import com.eshop.entity.Orders.PaymentStatus;
import com.eshop.entity.Orders.ShippingStatus;
import com.eshop.entity.OrderItem;
import com.eshop.entity.Product;

import org.springframework.stereotype.Repository;

/**
 * Dao - 订单
 * 
 * 
 * 
 */
@Repository("orderDaoImpl")
public class OrderDaoImpl extends BaseDaoImpl<Orders, Long> implements OrderDao {

	public Orders findBySn(String sn) {
		if (sn == null) {
			return null;
		}
		String jpql = "select orders from Order orders where lower(orders.sn) = lower(:sn)";
		try {
			return entityManager.createQuery(jpql, Orders.class).setFlushMode(FlushModeType.COMMIT).setParameter("sn", sn).getSingleResult();
		} catch (NoResultException e) {
			return null;
		}
	}

	public List<Orders> findList(Member member, Integer count, List<Filter> filters, List<com.eshop.Order> orders) {
		if (member == null) {
			return Collections.<Orders> emptyList();
		}
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Orders> criteriaQuery = criteriaBuilder.createQuery(Orders.class);
		Root<Orders> root = criteriaQuery.from(Orders.class);
		criteriaQuery.select(root);
		criteriaQuery.where(criteriaBuilder.equal(root.get("member"), member));
		return super.findList(criteriaQuery, null, count, filters, orders);
	}

	public Page<Orders> findPage(Member member, Pageable pageable) {
		if (member == null) {
			return new Page<Orders>(Collections.<Orders> emptyList(), 0, pageable);
		}
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Orders> criteriaQuery = criteriaBuilder.createQuery(Orders.class);
		Root<Orders> root = criteriaQuery.from(Orders.class);
		criteriaQuery.select(root);
		criteriaQuery.where(criteriaBuilder.equal(root.get("member"), member));
		return super.findPage(criteriaQuery, pageable);
	}

	public Page<Orders> findPage(OrderStatus orderStatus, PaymentStatus paymentStatus, ShippingStatus shippingStatus, Boolean hasExpired, Pageable pageable) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Orders> criteriaQuery = criteriaBuilder.createQuery(Orders.class);
		Root<Orders> root = criteriaQuery.from(Orders.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (orderStatus != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("orderStatus"), orderStatus));
		}
		if (paymentStatus != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("paymentStatus"), paymentStatus));
		}
		if (shippingStatus != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("shippingStatus"), shippingStatus));
		}
		if (hasExpired != null) {
			if (hasExpired) {
				restrictions = criteriaBuilder.and(restrictions, root.get("expire").isNotNull(), criteriaBuilder.lessThan(root.<Date> get("expire"), new Date()));
			} else {
				restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.or(root.get("expire").isNull(), criteriaBuilder.greaterThanOrEqualTo(root.<Date> get("expire"), new Date())));
			}
		}
		criteriaQuery.where(restrictions);
		return super.findPage(criteriaQuery, pageable);
	}

	public Long count(OrderStatus orderStatus, PaymentStatus paymentStatus, ShippingStatus shippingStatus, Boolean hasExpired) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Orders> criteriaQuery = criteriaBuilder.createQuery(Orders.class);
		Root<Orders> root = criteriaQuery.from(Orders.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (orderStatus != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("orderStatus"), orderStatus));
		}
		if (paymentStatus != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("paymentStatus"), paymentStatus));
		}
		if (shippingStatus != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("shippingStatus"), shippingStatus));
		}
		if (hasExpired != null) {
			if (hasExpired) {
				restrictions = criteriaBuilder.and(restrictions, root.get("expire").isNotNull(), criteriaBuilder.lessThan(root.<Date> get("expire"), new Date()));
			} else {
				restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.or(root.get("expire").isNull(), criteriaBuilder.greaterThanOrEqualTo(root.<Date> get("expire"), new Date())));
			}
		}
		criteriaQuery.where(restrictions);
		return super.count(criteriaQuery, null);
	}

	public Long waitingPaymentCount(Member member) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Orders> criteriaQuery = criteriaBuilder.createQuery(Orders.class);
		Root<Orders> root = criteriaQuery.from(Orders.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.notEqual(root.get("orderStatus"), OrderStatus.completed), criteriaBuilder.notEqual(root.get("orderStatus"), OrderStatus.cancelled));
		restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.or(criteriaBuilder.equal(root.get("paymentStatus"), PaymentStatus.unpaid), criteriaBuilder.equal(root.get("paymentStatus"), PaymentStatus.partialPayment)));
		restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.or(root.get("expire").isNull(), criteriaBuilder.greaterThanOrEqualTo(root.<Date> get("expire"), new Date())));
		if (member != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("member"), member));
		}
		criteriaQuery.where(restrictions);
		return super.count(criteriaQuery, null);
	}

	public Long waitingShippingCount(Member member) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Orders> criteriaQuery = criteriaBuilder.createQuery(Orders.class);
		Root<Orders> root = criteriaQuery.from(Orders.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.notEqual(root.get("orderStatus"), OrderStatus.completed), criteriaBuilder.notEqual(root.get("orderStatus"), OrderStatus.cancelled), criteriaBuilder.equal(root.get("paymentStatus"), PaymentStatus.paid), criteriaBuilder.equal(root.get("shippingStatus"), ShippingStatus.unshipped));
		restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.or(root.get("expire").isNull(), criteriaBuilder.greaterThanOrEqualTo(root.<Date> get("expire"), new Date())));
		if (member != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("member"), member));
		}
		criteriaQuery.where(restrictions);
		return super.count(criteriaQuery, null);
	}

	public BigDecimal getSalesAmount(Date beginDate, Date endDate) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<BigDecimal> criteriaQuery = criteriaBuilder.createQuery(BigDecimal.class);
		Root<Orders> root = criteriaQuery.from(Orders.class);
		criteriaQuery.select(criteriaBuilder.sum(root.<BigDecimal> get("amountPaid")));
		Predicate restrictions = criteriaBuilder.conjunction();
		restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("orderStatus"), OrderStatus.completed));
		if (beginDate != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.greaterThanOrEqualTo(root.<Date> get("createDate"), beginDate));
		}
		if (endDate != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.lessThanOrEqualTo(root.<Date> get("createDate"), endDate));
		}
		criteriaQuery.where(restrictions);
		return entityManager.createQuery(criteriaQuery).setFlushMode(FlushModeType.COMMIT).getSingleResult();
	}

	public Integer getSalesVolume(Date beginDate, Date endDate) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Integer> criteriaQuery = criteriaBuilder.createQuery(Integer.class);
		Root<Orders> root = criteriaQuery.from(Orders.class);
		criteriaQuery.select(criteriaBuilder.sum(root.join("orderItems").<Integer> get("shippedQuantity")));
		Predicate restrictions = criteriaBuilder.conjunction();
		restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("orderStatus"), OrderStatus.completed));
		if (beginDate != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.greaterThanOrEqualTo(root.<Date> get("createDate"), beginDate));
		}
		if (endDate != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.lessThanOrEqualTo(root.<Date> get("createDate"), endDate));
		}
		criteriaQuery.where(restrictions);
		return entityManager.createQuery(criteriaQuery).setFlushMode(FlushModeType.COMMIT).getSingleResult();
	}

	public void releaseStock() {
		String jpql = "select orders from Order orders where orders.isAllocatedStock = :isAllocatedStock and orders.expire is not null and orders.expire <= :now";
		List<Orders> orders = entityManager.createQuery(jpql, Orders.class).setParameter("isAllocatedStock", true).setParameter("now", new Date()).getResultList();
		if (orders != null) {
			for (Orders order : orders) {
				if (order != null && order.getOrderItems() != null) {
					for (OrderItem orderItem : order.getOrderItems()) {
						if (orderItem != null) {
							Product product = orderItem.getProduct();
							if (product != null) {
								entityManager.lock(product, LockModeType.PESSIMISTIC_WRITE);
								product.setAllocatedStock(product.getAllocatedStock() - (orderItem.getQuantity() - orderItem.getShippedQuantity()));
							}
						}
					}
					order.setIsAllocatedStock(false);
				}
			}
		}
	}

}