package com.music.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.music.bean.Users;
import com.music.msg.IndustrySMS;
import com.music.service.UsersService;

@Controller
public class UsersController {
	private static Map<String,String> phoneMsg = new HashMap<String,String>();
	
	@Resource
	private UsersService userService;
	
	/**
	 * 登录验证
	 * @throws IOException 
	 */
	@RequestMapping("/loginVerify")
	@ResponseBody
	public void login(String tel,String password,HttpServletResponse response,HttpSession session) throws IOException {
		Users u =userService.loginVerify(tel);
		if(u == null) {
			response.sendRedirect("front/loginAndRegister.jsp?status=3");
		}else if(!u.getPassword().equals(password)){
			response.sendRedirect("front/loginAndRegister.jsp?status=3");
		}else {
			session.setAttribute("user", u);
			response.sendRedirect("front/index.jsp");
		}
	}
	
	/**
	 * 注册
	 * @throws IOException 
	 * @throws ServletException 
	 */
	@RequestMapping("/registe")
	public void register(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException, ServletException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		Users u = new Users();
		
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		u.setTel(request.getParameter("tel"));
		u.setUsername(request.getParameter("username"));
		u.setPassword(request.getParameter("password"));
		
		u.setRegisterTime(sdf.format(new Date()));
		u.setPicture("img/user.jpg");
		List<String> phoneList = userService.selectMobile();
		for(String s:phoneList) {
			if(s.equals(request.getParameter("tel"))) {
				response.sendRedirect("front/loginAndRegister.jsp?status=2");
				return;
			}
		}
		
		userService.registe(u);
		response.sendRedirect("front/loginAndRegister.jsp?status=1");
	}
	
	
	/**
	 * 获取验证码
	 * 2018年11月28日21:19:51 蓝道良
	 */
	@RequestMapping("/getCode")
	@ResponseBody
	public String getCode(String phone) {
		IndustrySMS i = new IndustrySMS();
		String msg = i.execute(phone);
		
		phoneMsg.put(phone, msg);
		//System.out.println(phoneMsg.get(phone));
		return msg;
	}
	
	/**
	 * 验证码验证
	 * @throws IOException 
	 */
	@RequestMapping("/codeLogin")
	public void codeLogin(String phonenumber,String userpwd,HttpServletResponse response,HttpSession session) throws IOException {
		///System.out.println(phonenumber);
		//System.out.println(phoneMsg);
		List<String> phoneList = userService.selectMobile();
		boolean isExist = false;
		for(String s:phoneList) {
			if(s.equals(phonenumber)) {
				isExist = true;
				break;
			}
		}
		if(!isExist) {
			response.sendRedirect("front/loginAndRegister.jsp?status=4");
			return;
		}
		String code = phoneMsg.get(phonenumber);
		//System.out.println(code);
		if(code.equals(userpwd)) {
			//获取到当前Users对象
			Users u = userService.loginVerify(phonenumber);
			session.setAttribute("user", u);
			response.sendRedirect("front/index.jsp");
			return;
		}else {
			response.sendRedirect("front/loginAndRegister.jsp?status=5");
		}
		
	}
	
	/**
	 * 退出登录（清除session)
	 * @throws IOException 
	 */
	@RequestMapping("/removeUser")
	public void removeUser(HttpSession session,HttpServletResponse response) throws IOException {
		//System.out.println("------------------进来了");
		session.invalidate();
		response.getWriter().print("<script type=\"text/javascript\">window.top.location.href=\"front/index.jsp\";</script>");
	}
	
	
	
	
}
