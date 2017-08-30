package com.loginfund.controller;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.loginfund.service.BaseDataService;

@Controller
public class CreditCodeController {
	private Logger logger = Logger.getLogger(this.getClass());
	@Autowired
	BaseDataService service;

	@RequestMapping(value = "getCreditCode", method = { RequestMethod.POST })
	@ResponseBody
	public String getCreditCode(HttpSession session) {
		String email = (String) session.getAttribute("email");
		if (null == email) {
			logger.error("getCreditCode error: email is null");
			return "-1";
		}
		try {
			// 查询该账户是否有未使用的code
			String creditCode = service.getCreditCodeByEmail(email);
			if (null == creditCode) {
				// 随机查询一个可用的code
				creditCode = service.getCreditCodeByrand(email);
				return "new" + creditCode;
			} else {
				return "old" + creditCode;
			}

		} catch (Exception e) {
			logger.error("getCreditCode error:" + e);
			return "-1";
		}
	}

	@RequestMapping(value = "checkCreditCode", method = { RequestMethod.POST })
	@ResponseBody
	public String checkCreditCode(HttpSession session, String code) {
		String email = (String) session.getAttribute("email");
		if (null == email) {
			logger.error("checkCreditCode error: email is null");
			return "-1";
		}
		try {
			int resul = service.checkCreditCode(code);
			if (resul == 1) {
				service.addCreditCodeToAccount(email, code);
			}
			return resul + "";
		} catch (Exception e) {
			logger.error("checkCreditCode:" + e);
			return "-1";
		}
	}
	@RequestMapping(value = "checkCreditCodeOfAccount", method = { RequestMethod.POST })
	@ResponseBody
	public String checkCreditCodeOfAccount(HttpSession session) {
		String email = (String) session.getAttribute("email");
		if (null == email) {
			logger.error("checkCreditCodeOfAccount error: email is null");
			return "-1";
		}
		try {
			int resul = service.checkCreditCodeOfAccount(email);			
			return resul + "";
		} catch (Exception e) {
			logger.error("checkCreditCodeOfAccount:" + e);
			return "-1";
		}
	}
	
	
}
