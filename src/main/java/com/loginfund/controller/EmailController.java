package com.loginfund.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.loginfund.service.BaseDataService;
import com.loginfund.service.impl.EmailServer;
import com.loginfund.util.EmailCode;

@Controller
public class EmailController {
	@Autowired
	BaseDataService service;
	@Autowired
	EmailServer emailServer;

	@RequestMapping(value = "sendEmailCode", method = { RequestMethod.POST })
	@ResponseBody
	public String sendEmailCode(String email, String type, HttpSession session) {
		email = email.trim().toLowerCase();
		// 请求登录，但邮箱不存在
		if ("login".equals(type) && null == service.getAccountByEmail(email))
			return "001";
		// 请求注册，但邮箱已存在，在客户端提示选择其他邮箱
		if ("reg".equals(type) && null != service.getAccountByEmail(email.trim()))
			return "001";
		// 修改邮箱，检查邮箱是否一致，不一致提示用
		// if ("edit".equals(type) && null !=
		// service.getAccountByEmail(email.trim()))
		// return "001";

		// 生成验证码
		if (emailServer.sendEmail(email)) {
			if ("login".equals(type) || "reg".equals(type))
				session.setAttribute("email", email);
			return "000";
		} else
			return "500";
	}

	@RequestMapping(value = "checkCode", method = { RequestMethod.POST })
	@ResponseBody
	public String checkCode(String code, String email) {
		email = email.trim().toLowerCase();
		// 检查验证码
		if (!EmailCode.verifyCode(email.trim(), code.trim()))
			return "001";
		else
			return "000";
	}

}
