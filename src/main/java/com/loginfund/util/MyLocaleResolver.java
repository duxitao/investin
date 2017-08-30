package com.loginfund.util;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.LocaleResolver;

public class MyLocaleResolver implements LocaleResolver {

	public Locale resolveLocale(HttpServletRequest request) {
		String language = request.getLocale().getLanguage().toLowerCase();
		if ("en".equals(language) || "es".equals(language))
			return request.getLocale();
		if("zh".equals(language))
			return new Locale("es");
		return Locale.ENGLISH;
	}

	public void setLocale(HttpServletRequest request, HttpServletResponse response, Locale locale) {

	}

}
