package com.loginfund.model;

public class Country {
	int id;
	String countryDesc_cn;
	String countryDesc_en;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCountryDesc_cn() {
		return countryDesc_cn;
	}

	public void setCountryDesc_cn(String countryDesc_cn) {
		this.countryDesc_cn = countryDesc_cn;
	}

	public String getCountryDesc_en() {
		return countryDesc_en;
	}

	public void setCountryDesc_en(String countryDesc_en) {
		this.countryDesc_en = countryDesc_en;
	}

	@Override
	public String toString() {
		return "Country [id=" + id + ", countryDesc_cn=" + countryDesc_cn + ", countryDesc_en=" + countryDesc_en + "]";
	}



}
