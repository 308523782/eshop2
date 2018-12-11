/*
 * 
 * 
 * 
 */
package com.eshop.dao.impl;

import com.eshop.dao.RoleDao;
import com.eshop.entity.Role;

import org.springframework.stereotype.Repository;

/**
 * Dao - 角色
 * 
 * 
 * 
 */
@Repository("roleDaoImpl")
public class RoleDaoImpl extends BaseDaoImpl<Role, Long> implements RoleDao {

}