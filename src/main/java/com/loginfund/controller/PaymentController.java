package com.loginfund.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.loginfund.model.Account;
import com.loginfund.model.Payment;
import com.loginfund.model.PaymentMethod;
import com.loginfund.service.BaseDataService;
import com.loginfund.service.impl.EmailServer;
import com.loginfund.util.AppConfig;
import com.loginfund.util.CommonUtil;

@Controller
public class PaymentController {
	private Logger logger = Logger.getLogger(this.getClass());
	@Autowired
	BaseDataService service;
	@Autowired
	AppConfig appConfig;

	@Autowired
	EmailServer emailServer;

	@RequestMapping(value = "onlinePayment")
	public String onlinePayment(Model model, HttpSession session) {
		logger.info("enter onlinePayment page……");
		return "onlinePayment";
	}

	@RequestMapping(value = "createPayment", method = { RequestMethod.POST })
	@ResponseBody
	public String createPayment(String amount, HttpSession session, HttpServletRequest request) {
		logger.info("enter createPayment page……");
		// 判断是否已支付

		String email = (String) session.getAttribute("email");
		if (null == email) {
			logger.error("createPayment error: email is null");
			return "-1";
		}

		Account account = service.getAccountByEmail(email);

		if ("1".equals(account.getPay_status()))
			return "003";

		logger.info("enter createPayment email=" + email + ",amount=" + amount);
		// 如果支付金额为139，则需验证creditcode
		if (!"299".equals(amount) && !"399".equals(amount))
			return "001";// 参数异常
		if ("299".equals(amount)) {
			if (service.checkCreditCodeOfAccount(email) == 0)
				return "002";
		}
		try {
			// 创建订单
			Payment payment = new Payment();
			payment.setId(CommonUtil.getPaymentID());
			payment.setAmount(amount);		
			payment.setBusiness(appConfig.getProperties().getProperty("payment.business"));
			payment.setCmd(appConfig.getProperties().getProperty("payment.cmd"));
			payment.setEmail(email);
			//西班牙语国家用payssion支付
			if ("es".equals(request.getLocale().getLanguage()))
				payment.setPay_url(appConfig.getProperties().getProperty("payssion.pay_url"));
			else
				payment.setPay_url(appConfig.getProperties().getProperty("payment.pay_url"));
			payment.setCurrency_code(appConfig.getProperties().getProperty("currencyCode"));
			service.createPayment(payment);

			// session.setAttribute("paymentID", payment.getId());
			session.setAttribute("payment", payment);
			return "000";
		} catch (Exception e) {
			logger.error("createPayment error: " + e);
			return "-1";
		}

	}

	@RequestMapping(value = "payment")
	public String payment(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("enter onlinePayment page……");
		Payment payment = (Payment) session.getAttribute("payment");
		if(null==payment)
			return "onlinePayment";
		model.addAttribute("payment", payment);
		if ("es".equals(request.getLocale().getLanguage())) {
			// 查询国家所对应的支付方式session
			String email = (String) session.getAttribute("email");
			Account account = service.getAccountByEmail(email.trim().toLowerCase());
			// 根据国家查询支付方式
			List<PaymentMethod> paymentMethodList = service.getPaymentMethodByCoverage(account.getCountryDesc_en());
			model.addAttribute("paymentMethodList", paymentMethodList);			
			model.addAttribute("api_key", appConfig.getProperties().getProperty("payssion.api_key"));
			model.addAttribute("email", email);
			return "paymentMethod";
		} else
			return "paymentTransfer";
	}

	@RequestMapping(value = "getPayssionSign")
	@ResponseBody
	public String getPayssionSign(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("enter getPayssionSign page……");
		String pm_id = request.getParameter("pm_id");
		Payment payment = (Payment) session.getAttribute("payment");
		// api_key|pm_id|amount|currency|order_id|secret_key
		String api_key = appConfig.getProperties().getProperty("payssion.api_key");
		String secret = appConfig.getProperties().getProperty("payssion.secret");
		String sign = api_key + "|" + pm_id + "|" + payment.getAmount() + "|" + payment.getCurrency_code() + "|"
				+ payment.getId() + "|" + secret;
		sign = DigestUtils.md5DigestAsHex(sign.getBytes());
		return sign;

	}
	@RequestMapping(value = "payssionNotify")
	@ResponseBody
	public String payssionNotify(HttpServletRequest request) {
		logger.info("enter paypalNotify page……");
		String api_key = appConfig.getProperties().getProperty("payssion.api_key");
		String secret = appConfig.getProperties().getProperty("payssion.secret");
		String pm_id = request.getParameter("pm_id");
		String amount = request.getParameter("amount");
		String currency = request.getParameter("currency");
		String order_id = request.getParameter("order_id");
		//api_key|pm_id|amount|currency|order_id|state|sercret_key
		String sign=api_key+"|"+pm_id+"|"+amount+"|"+currency+"|"+order_id+"|completed|"+secret;
		sign = DigestUtils.md5DigestAsHex(sign.getBytes());
		
		if("completed".equals(request.getParameter("state"))){
			if(sign.equals(request.getParameter("notify_sig"))){
				
				String item_number = request.getParameter("order_id");
				String txn_id = request.getParameter("order_id");
				String pay_amount = request.getParameter("amount");
				Payment payment = service.getPaymentByID(item_number);
				if ("0".equals(payment.getStatus())) {
					service.updatePaymentSataus(item_number, txn_id, pay_amount);
					emailServer.sendNotice(payment.getEmail(), "2");
					return "200";
				}
				
			}
		}
		return "500";
		
		/*
		 * app_name:loginfund VIP Test
pm_id:sofort
transaction_id:H611861311795969
order_id:20170611210236927973
order_extra:
amount:399.00
paid:399.00
net:0.00
fee:0.00
currency:USD
description:test loginfund VIP
payer_email:duxitao@126.com
state:completed
notify_sig:965fb66de484ee851aa2c0c99798c6e3
a53b513292b7272decf3c245beb0e24f

		 */
		
		
		
	
	}

	@RequestMapping(value = "paypalNotify")
	@ResponseBody
	public String paypalNotify(HttpServletRequest request) {
		logger.info("enter paypalNotify page……");
		Enumeration<String> en = request.getParameterNames();

		/*
		 * mc_gross-------139.00 protection_eligibility-------Eligible
		 * address_status-------unconfirmed payer_id-------7XF6HF3UDBAZ6
		 * tax-------0.00 address_street-------NO 1 Nan Jin Road
		 * payment_date-------01:03:48 Jan 22, 2017 PST
		 * payment_status-------Completed charset-------gb2312
		 * address_zip-------200000 first_name-------du mc_fee-------5.03
		 * address_country_code-------CN address_name-------xitao du
		 * notify_version-------3.8 custom------- payer_status-------unverified
		 * business-------duxitao-facilitator@126.com
		 * address_country-------China address_city-------Shanghai
		 * quantity-------1 verify_sign-------AVfSQ5PLCwiNa3zy.rOy.Na-
		 * EbloA51LcuYp9xfpzxBxasDQGS4LiKjw
		 * payer_email-------duxitaotest1@126.com txn_id-------4KD33620LW391323W
		 * payment_type-------instant last_name-------xitao
		 * address_state-------Shanghai
		 * receiver_email-------duxitao-facilitator@126.com
		 * payment_fee-------5.03 receiver_id-------BGFMTTF9FX7ZN
		 * txn_type-------web_accept item_name-------loginfund VIP
		 * mc_currency-------USD item_number-------20170122170330258796
		 * residence_country-------CN test_ipn-------1
		 * handling_amount-------0.00 transaction_subject-------
		 * payment_gross-------139.00 shipping-------0.00
		 * ipn_track_id-------71606179686fc
		 */
		try {
			String str = "cmd=_notify-validate";
			while (en.hasMoreElements()) {
				String paramName = (String) en.nextElement();
				String paramValue = request.getParameter(paramName);
				str = str + "&" + paramName + "=" + URLEncoder.encode(paramValue, "utf-8");
			}

			URL u = new URL(appConfig.getProperties().getProperty("payment.pay_url"));
			URLConnection uc = u.openConnection();
			uc.setDoOutput(true);
			uc.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			PrintWriter pw = new PrintWriter(uc.getOutputStream());
			pw.println(str);
			pw.close();
			// 接受 PayPal 对 IPN 回发的回复信息
			BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream()));
			String res = in.readLine();
			in.close();
			// 将 POST 信息分配给本地变量，可以根据您的需要添加
			// 该付款明细所有变量可参考：
			// https://www.paypal.com/IntegrationCenter/ic_ipn-pdt-variable-reference.html

			// 获取 PayPal 对回发信息的回复信息，判断刚才的通知是否为 PayPal 发出的
			if ("VERIFIED".equals(res)) {
				logger.info("pay success:" + str);

				String item_number = request.getParameter("item_number");
				String txn_id = request.getParameter("payer_id");
				String pay_amount = request.getParameter("payment_gross");
				Payment payment = service.getPaymentByID(item_number);
				if ("0".equals(payment.getStatus())) {
					service.updatePaymentSataus(item_number, txn_id, pay_amount);
					emailServer.sendNotice(payment.getEmail(), "2");
				}
			}
			return "paypalNotify";
		} catch (Exception e) {
			logger.error("enter expectation error:" + e);
			return "exception";
		}
	}

	@RequestMapping(value = "paypalCancel")
	@ResponseBody
	public String paypalCancel(HttpServletRequest request) {
		logger.info("enter paypalCancel page……");

		return "paypalCancel";
	}

	@RequestMapping(value = "paypalReturn")
	public String paypalReturn(Model model, HttpSession session, HttpServletRequest request) {
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

	@RequestMapping(value = "createRequest")
	@ResponseBody
	public String createRequest(HttpSession session, String amount, String tel) {
		logger.info("enter createRequest page……");

		String email = (String) session.getAttribute("email");
		if (null == email) {
			logger.error("createRequest error: email is null");
			return "-1";
		}
		logger.info("enter createRequest email=" + email + ",amount=" + amount + ",tel=" + tel);
		// 如果支付金额为179，则需验证creditcode
		if (!"459".equals(amount) && !"359".equals(amount))
			return "001";
		if ("359".equals(amount)) {
			if (service.checkCreditCodeOfAccount(email) == 0)
				return "002";
		}
		try {
			service.updateRequestStatus(amount, tel, email);
			return "000";
		} catch (Exception e) {
			logger.error("createRequest error: " + e);
			return "-1";
		}

	}

}
