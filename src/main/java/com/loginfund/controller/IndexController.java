package com.loginfund.controller;


import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.loginfund.service.BaseDataService;
import com.loginfund.util.EmailCode;

@Controller
public class IndexController {

	private Logger logger = Logger.getLogger(this.getClass());
	@Autowired
	BaseDataService service;

	@RequestMapping("/")
	public String index(Model model) {
		logger.info("enter index page……");
		return "index";
	}

	@RequestMapping("login")
	@ResponseBody
	public String login(String code, HttpSession session) {
		String email = (String) session.getAttribute("email");
		logger.info("login…… email=" + email);
		// session超时验证码肯定超时了，因此直接返回验证码错误
		if (null == email)
			return "001";
		// 检查验证码
		if (!EmailCode.verifyCode(email.trim(), code.trim()))
			return "001";
		else
			return "000";
	}
}
