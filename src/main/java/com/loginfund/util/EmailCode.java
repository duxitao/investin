package com.loginfund.util;

import java.util.HashMap;
import java.util.Map;

public class EmailCode {

	static Map<String, VerificationCode> emailCodeMap = new HashMap<String, VerificationCode>();

	/**
	 * 创建一个length长度的随机数，并用key存储，保存时间为minutes分钟
	 * 
	 * @param key
	 * @param length
	 * @param storageTime
	 * @return
	 */
	public static String createCode(String key, int length, int minutes) {
		double l = 1;
		for (int i = 0; i < length; i++) {
			l *= 10;
		}
		String code = (int) (Math.random() * l) + "";
		while (code.length() < length) {
			code = "0" + code;
		}
		long expiryTime = System.currentTimeMillis() + minutes * 60 * 1000;
		VerificationCode vCode = new VerificationCode();
		vCode.setCode(code);
		vCode.setExpiryTime(expiryTime);
		emailCodeMap.put(key, vCode);
		return code;
	}

	public static boolean verifyCode(String key, String code) {
		if (null == code || "".equals(code))
			return false;
		VerificationCode verificationCode = emailCodeMap.get(key);
		if(null==verificationCode)
			return false;
		if (System.currentTimeMillis() > verificationCode.getExpiryTime())
			return false;
		if (code.equals(verificationCode.getCode()))
			return true;
		else
			return false;
	}
}
