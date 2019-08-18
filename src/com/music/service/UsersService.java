package com.music.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.music.bean.Users;
import com.music.dao.UsersDao;

@Service
public class UsersService {
	@Resource
	private UsersDao usersDao;
	
	/**
	 * 登录验证
	 * @param mobilePhone
	 * @param userPwd
	 * @return
	 */
	public Users loginVerify(String tel) {
		return usersDao.loginVerify(tel);
	}
	/**
	 * 注册验证
	 * 2018年11月28日16:41:45蓝道良
	 */
	public Integer registe(Users u) {
		return usersDao.insertUsers(u);
	}
	
	/**
	 * 查询手机号验证是否注册过
	 */
	public List<String> selectMobile(){
		return usersDao.selectMobile();
	}
	
}
