package com.loginfund.interceptor;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;

public class LoginInterceptor implements HandlerInterceptor {

	private List<String> excludedUrls = null;
	private Logger logger = Logger.getLogger(this.getClass());

	public List<String> getExcludedUrls() {
		return excludedUrls;
	}

	public void setExcludedUrls(List<String> excludedUrls) {
		this.excludedUrls = excludedUrls;
	}

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		logger.info("language is " + request.getLocale().getLanguage().toLowerCase());
		
		String url = request.getServletPath();
		/*
		String language = request.getLocale().getLanguage().toLowerCase();
		if (!(url.contains("paypalNotify") || url.contains("paypalCancel") || url.contains("paypalReturn")))
			if ("zh".equals(language))
				return false;

*/
		for (String cludedurs : excludedUrls) {
			if (url.contains(cludedurs)) {
				// 检查是否登录
				if (null == request.getSession().getAttribute("email")) {
					String path = request.getContextPath();
					response.sendRedirect(path + "\\");
				}
			}
		}

		return true;
	}

	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

	}

	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

	}

}
