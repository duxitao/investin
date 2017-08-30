package com.loginfund.util;

import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.Logger;

public class AppConfig {
	private Logger logger = Logger.getLogger(this.getClass());
	Properties properties = new Properties();

	public AppConfig(String fileName) {

		try {
			InputStream in = getClass().getClassLoader().getResourceAsStream(fileName);
			properties.load(in);
		} catch (Exception e) {
			logger.error("load properties error,fileName=" + fileName);
		}
	}

	public Properties getProperties() {
		return properties;
	}

}
