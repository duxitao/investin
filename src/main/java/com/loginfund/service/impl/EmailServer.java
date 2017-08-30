package com.loginfund.service.impl;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message.RecipientType;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.loginfund.model.Account;
import com.loginfund.model.ReciveEmail;
import com.loginfund.service.BaseDataService;
import com.loginfund.util.AppConfig;
import com.loginfund.util.EmailCode;

@Service
public class EmailServer {

	@Autowired
	AppConfig appConfig;
	private Logger logger = Logger.getLogger(this.getClass());
	@Autowired
	BaseDataService service;

	/**
	 * 邮箱提醒
	 * 
	 * @param email
	 * @param type
	 *            1-发送新注册用户提醒；2-发送新支付提醒
	 * @return
	 */
	public void sendNotice(String email, String type) {
		try {
			Account account = service.getAccountByEmail(email);
			// 查询国家对应的收件人
			ReciveEmail reciveEmail = service.getReceiveEmail(account.getContryId());
			if (null == reciveEmail)
				return;
			String toEmail = reciveEmail.getReceive_email();
			if (reciveEmail.getReceive_email() == null || "".equals(toEmail) || "0".equals(reciveEmail.getStatus()))
				return;
			// 配置发送邮件的环境属性
			final Properties props = appConfig.getProperties();

			// 构建授权信息，用于进行SMTP进行身份验证
			Authenticator authenticator = new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					// 用户名、密码
					String userName = props.getProperty("mail.user");
					String password = props.getProperty("mail.password");
					return new PasswordAuthentication(userName, password);
				}
			};
			// 使用环境属性和授权信息，创建邮件会话
			Session mailSession = Session.getInstance(props, authenticator);
			// 创建邮件消息
			MimeMessage message = new MimeMessage(mailSession);
			// 设置发件人
			message.setFrom(new InternetAddress("loginfund" + " <" + props.getProperty("mail.user") + ">"));

			// 设置收件人
			InternetAddress to = new InternetAddress(toEmail);
			message.setRecipient(RecipientType.TO, to);

			// 设置邮件标题
			if ("1".equals(type))
				message.setSubject("new user");
			else
				message.setSubject("newly paid by paypal");

			// 设置邮件的内容体
			message.setContent("<p>User name:" + account.getUserName() + "</p><p>Telphone:" + account.getTel()
					+ "</p><p>Email:" + account.getEmail() + "</p><p>Company name:" + account.getCompanyName()
					+ "</p><p>Country:" + account.getCompanyName() + "</p>", "text/html;charset=UTF-8");

			// 发送邮件
			Transport.send(message);

		} catch (Exception e) {
			logger.error(String.format("send sendNotice to %s error %s", email, e.getMessage()));
			logger.error(e);			
		}
	}

	public boolean sendEmail(String email) {
		try {

			String code = EmailCode.createCode(email, 6, 10);
			logger.info(String.format("send code to %s", email));
			logger.debug(String.format("code is %s", code));
			// 配置发送邮件的环境属性
			final Properties props = appConfig.getProperties();

			// 构建授权信息，用于进行SMTP进行身份验证
			Authenticator authenticator = new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					// 用户名、密码
					String userName = props.getProperty("mail.user");
					String password = props.getProperty("mail.password");
					return new PasswordAuthentication(userName, password);
				}
			};
			// 使用环境属性和授权信息，创建邮件会话
			Session mailSession = Session.getInstance(props, authenticator);
			// 创建邮件消息
			MimeMessage message = new MimeMessage(mailSession);
			// 设置发件人
			message.setFrom(new InternetAddress("loginfund" + " <" + props.getProperty("mail.user") + ">"));

			// 设置收件人
			InternetAddress to = new InternetAddress(email);
			message.setRecipient(RecipientType.TO, to);

			// 设置邮件标题
			message.setSubject("the verification code");

			// 设置邮件的内容体
			message.setContent(
					"<p>Hello!</p><p style='text-indent: 1em;'>Your verification code is " + code
							+ ".please enter the verification code soon.the verification code is valid for 24 hours.</p><p>Thanks</p> <p>loginfund</p>",
					"text/html;charset=UTF-8");

			// 发送邮件
			Transport.send(message);
			return true;
		} catch (Exception e) {
			logger.error(String.format("send code to %s error %s", email, e.getMessage()));
			logger.error(e);
			return false;
		}
	}
}
