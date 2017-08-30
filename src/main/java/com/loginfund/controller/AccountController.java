package com.loginfund.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.loginfund.model.Account;
import com.loginfund.model.ContactInfo;
import com.loginfund.model.Country;
import com.loginfund.model.Info;
import com.loginfund.model.Scale;
import com.loginfund.service.BaseDataService;
import com.loginfund.service.impl.EmailServer;
import com.loginfund.util.AppConfig;
import com.loginfund.util.EmailCode;

@Controller
public class AccountController {

	private Logger logger = Logger.getLogger(this.getClass());
	@Autowired
	BaseDataService service;
	@Autowired
	EmailServer emailServer;
	
	@Autowired
	AppConfig appConfig;

	String email2;

	@RequestMapping(value = "createAccount", method = { RequestMethod.POST })
	public String createAccount(Model model, Info info, HttpSession session,HttpServletRequest request) {
		// 保存规模、领域信息
		
		session.setAttribute("info", info);
		try {
			String language = request.getLocale().getLanguage().toLowerCase();
			String countrys=appConfig.getProperties().getProperty("language_"+language);
			// 查询国家列表
			List<Country> countryList = service.getAllCountry(countrys);
			model.addAttribute("countryList", countryList);
			return "createAccount";
		} catch (Exception e) {
			logger.error("enter expectation error:" + e);
			return "exception";
		}
	}

	@RequestMapping(value = "submitCreateAccount", method = { RequestMethod.POST })
	@ResponseBody
	public String submitCreateAccount(Account account, String code, HttpSession session) {

		Info info = (Info) session.getAttribute("info");
		// info信息失效，重新填写
		if (null == info || info.getTitle_en() == null || info.getDescription_en() == null)
			return "003";

		String email = (String) session.getAttribute("email");
		// session超时验证码肯定超时了，因此直接返回验证码错误
		if (null == email)
			return "001";
		email = email.trim().toLowerCase();
		info.setEmail(email);
		account.setEmail(email);
		info.setCountryId(account.getContryId());
		// 检查验证码
		if (!EmailCode.verifyCode(email.trim(), code.trim()))
			return "001";
		// 检查账号信息是否完整
		if (account.getUserName().trim().equals("") || account.getCompanyName().trim().equals("")
				|| account.getTel().trim().equals("")) {
			return "002";
		}
		// 创建账户
		try {
			service.addAccountAndInfo(account, info);
			email2 = email;
			Thread myThread1 = new MyThread(); 			
			myThread1.start();
			return "000";

		} catch (DuplicateKeyException e) {
			logger.error(
					String.format("submitCreateAccount account=%s,info=%s error:%s", account, info, e.getMessage()));
			return "004";
		} catch (Exception e) {
			logger.error(
					String.format("submitCreateAccount account=%s,info=%s error:%s", account, info, e.getMessage()));
			return "005";
		}

	}

	@RequestMapping(value = "updateAccountAndInfo")
	@ResponseBody
	public String updateAccountAndInfo(HttpSession session, String tel, String email, String scaleId, String account_id,
			String info_id) {
		try {
			service.updateAccountAndInfo(tel, email, scaleId, account_id, info_id);
			if (!"".equals(email.trim()))
				session.setAttribute("email", email);
			return "000";

		} catch (DuplicateKeyException e) {
			logger.error(String.format("updateAccountAndInfo error:%s", e.getMessage()));
			return "004";
		} catch (Exception e) {
			logger.error(String.format("updateAccountAndInfo error:%s", e.getMessage()));
			return "005";
		}

	}

	@RequestMapping(value = "accountInfo")
	public String accountInfo(Model model, HttpSession session) {
		try {
			String email = (String) session.getAttribute("email");
			email = email.trim().toLowerCase();
			model.addAttribute("account", service.getAccountByEmail(email));
			model.addAttribute("info", service.getInfoByEmail(email));
			return "accountInfo";
		} catch (Exception e) {
			logger.error("enter expectation error:" + e);
			return "exception";
		}
	}

	@RequestMapping(value = "editAccountInfo")
	public String editAccountInfo(Model model, HttpSession session) {
		try {
			String email = (String) session.getAttribute("email");
			email = email.trim().toLowerCase();
			model.addAttribute("account", service.getAccountByEmail(email));
			model.addAttribute("info", service.getInfoByEmail(email));
			List<Scale> scaleList = service.getAllScale();
			model.addAttribute("scaleList", scaleList);
			return "editAccountInfo";
		} catch (Exception e) {
			logger.error("enter editAccountInfo error:" + e);
			return "exception";
		}
	}

	@RequestMapping("contact")
	public String contact(Model model, String w, HttpSession session,HttpServletRequest request) {
		logger.info("enter contact page……");
		try {
			// 查询国家列表
			String language = request.getLocale().getLanguage().toLowerCase();
			String countrys=appConfig.getProperties().getProperty("language_"+language);
			// 查询国家列表
			List<Country> countryList = service.getAllCountry(countrys);
			model.addAttribute("countryList", countryList);

			String email = (String) session.getAttribute("email");
			if (null != email) {
				email = email.trim().toLowerCase();
				model.addAttribute("account", service.getAccountByEmail(email));
			}
			model.addAttribute("w", w);// 对话框宽度
			return "contact";
		} catch (Exception e) {
			logger.error("enter enter error:" + e);
			return "exception";
		}

	}

	@RequestMapping(value = "addContactInfo", method = { RequestMethod.POST })
	@ResponseBody
	public String addContactInfo(ContactInfo contactInfo, String email, String code, String type) {
		try {
			if ("0".equals(type)) {
				// 检查验证码
				if (!EmailCode.verifyCode(email.trim(), code.trim()))
					return "001";
			}
			service.addContactInfo(contactInfo);
			return "000";
		} catch (Exception e) {
			logger.error("enter addContactInfo error:" + e);
			return "-1";
		}

	}

	class MyThread extends Thread {

		@Override
		public void run() {
			emailServer.sendNotice(email2, "1");
		}
	}

}
