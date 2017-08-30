package com.loginfund.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class CommonUtil {

	public static String getPaymentID() {
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");

		String code = (int) (Math.random() * 1000000) + "";
		while (code.length() < 6) {
			code = "0" + code;
		}

		return df.format(new Date()) + code;
	}

	public static void main(String[] args) {
		System.out.println(getPaymentID());//20170122151951238075
	}

}
