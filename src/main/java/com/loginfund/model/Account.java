package com.loginfund.model;

import java.util.Date;

public class Account {
	int id;
	String email;
	int contryId;
	String countryDesc_en;
	String userName;
	String companyName;
	String tel;
	String pay_status;
	Date creteTime;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}


	public int getContryId() {
		return contryId;
	}

	public void setContryId(int contryId) {
		this.contryId = contryId;
	}



	public String getCountryDesc_en() {
		return countryDesc_en;
	}

	public void setCountryDesc_en(String countryDesc_en) {
		this.countryDesc_en = countryDesc_en;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public Date getCreteTime() {
		return creteTime;
	}

	public void setCreteTime(Date creteTime) {
		this.creteTime = creteTime;
	}

	
	public String getPay_status() {
		return pay_status;
	}

	public void setPay_status(String pay_status) {
		this.pay_status = pay_status;
	}

	@Override
	public String toString() {
		return "Account [id=" + id + ", email=" + email + ", contryId=" + contryId + ", countryDesc_en="
				+ countryDesc_en + ", userName=" + userName + ", companyName=" + companyName + ", tel=" + tel
				+ ", pay_status=" + pay_status + ", creteTime=" + creteTime + "]";
	}


}
