package com.loginfund.model;

public class Field {
	int id;
	String fieldDesc_cn;
	String fieldDesc_en;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFieldDesc_cn() {
		return fieldDesc_cn;
	}

	public void setFieldDesc_cn(String fieldDesc_cn) {
		this.fieldDesc_cn = fieldDesc_cn;
	}

	public String getFieldDesc_en() {
		return fieldDesc_en;
	}

	public void setFieldDesc_en(String fieldDesc_en) {
		this.fieldDesc_en = fieldDesc_en;
	}

	@Override
	public String toString() {
		return "Field [id=" + id + ", fieldDesc_cn=" + fieldDesc_cn + ", fieldDesc_en=" + fieldDesc_en + "]";
	}

}
