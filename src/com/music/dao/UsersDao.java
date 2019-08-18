package com.music.dao;

import com.music.bean.Users;
import java.math.BigDecimal;
import java.util.List;

public interface UsersDao {
	/**
	 * 注册一个用户
	 * @param user
	 */
	int insertUsers(Users user);
	
	//删除用户信息
	int deleteUsers(Integer usersId);
	
	//修改用户信息
	int updateUsers(Users user);
	
	//根据电话号码（tel）获取用户信息
	Users getOneUsers(String tel);
	/**
	 * 登录验证
	 * 2018年11月28日11:24:32 蓝道良
	 */
	Users loginVerify(String tel);
	/**
	 * 验证手机号
	 * 2018年11月28日16:41:21 蓝道良
	 * @return
	 */
	List<String> selectMobile();
	
}