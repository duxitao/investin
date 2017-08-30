package com.loginfund.model;

public class PaymentMethod {

	String method_en;
	String method_es;
	String pm_id;
	String coverage;

	public String getMethod_en() {
		return method_en;
	}

	public void setMethod_en(String method_en) {
		this.method_en = method_en;
	}

	public String getMethod_es() {
		return method_es;
	}

	public void setMethod_es(String method_es) {
		this.method_es = method_es;
	}

	public String getPm_id() {
		return pm_id;
	}

	public void setPm_id(String pm_id) {
		this.pm_id = pm_id;
	}

	public String getCoverage() {
		return coverage;
	}

	public void setCoverage(String coverage) {
		this.coverage = coverage;
	}

	@Override
	public String toString() {
		return "PaymentMethod [method_en=" + method_en + ", method_es=" + method_es + ", pm_id=" + pm_id + ", coverage="
				+ coverage + "]";
	}

}
