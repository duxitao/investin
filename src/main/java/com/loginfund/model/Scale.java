package com.loginfund.model;

public class Scale {

	int id;
	String scaleDesc_en;
	String scaleDesc_cn;
	

	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getScaleDesc_en() {
		return scaleDesc_en;
	}


	public void setScaleDesc_en(String scaleDesc_en) {
		this.scaleDesc_en = scaleDesc_en;
	}


	public String getScaleDesc_cn() {
		return scaleDesc_cn;
	}


	public void setScaleDesc_cn(String scaleDesc_cn) {
		this.scaleDesc_cn = scaleDesc_cn;
	}


	@Override
	public String toString() {
		return "Scale [id=" + id + ", scaleDesc_en=" + scaleDesc_en + ", scaleDesc_cn=" + scaleDesc_cn + "]";
	}

}
