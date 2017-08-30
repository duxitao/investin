package com.loginfund.model;

import java.util.Date;

public class Info {

	int id;
	String title_cn;
	String title_en;
	String description_cn;
	String description_en;
	int scaleId;
	String  scaleDesc_en;
	int fieldId;	
	String fieldDesc_en;
	int countryId;
	Date dateConfirmed;
	Date dateExpiry;
	String email;
	int inquiryNum;
	String status;
	Date createTime;
	String createBy;
	Date updateTime;
	String updateBy;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle_cn() {
		return title_cn;
	}

	public void setTitle_cn(String title_cn) {
		this.title_cn = title_cn;
	}

	public String getTitle_en() {
		return title_en;
	}

	public void setTitle_en(String title_en) {
		this.title_en = title_en;
	}

	public String getDescription_cn() {
		return description_cn;
	}

	public void setDescription_cn(String description_cn) {
		this.description_cn = description_cn;
	}

	public String getDescription_en() {
		return description_en;
	}

	public void setDescription_en(String description_en) {
		this.description_en = description_en;
	}

	public int getScaleId() {
		return scaleId;
	}

	public void setScaleId(int scaleId) {
		this.scaleId = scaleId;
	}

	public int getFieldId() {
		return fieldId;
	}

	public void setFieldId(int fieldId) {
		this.fieldId = fieldId;
	}

	public Date getDateConfirmed() {
		return dateConfirmed;
	}

	public void setDateConfirmed(Date dateConfirmed) {
		this.dateConfirmed = dateConfirmed;
	}

	public Date getDateExpiry() {
		return dateExpiry;
	}

	public void setDateExpiry(Date dateExpiry) {
		this.dateExpiry = dateExpiry;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getInquiryNum() {
		return inquiryNum;
	}

	public void setInquiryNum(int inquiryNum) {
		this.inquiryNum = inquiryNum;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(String updateBy) {
		this.updateBy = updateBy;
	}

	public String getScaleDesc_en() {
		return scaleDesc_en;
	}

	public void setScaleDesc_en(String scaleDesc_en) {
		this.scaleDesc_en = scaleDesc_en;
	}

	public String getFieldDesc_en() {
		return fieldDesc_en;
	}

	public void setFieldDesc_en(String fieldDesc_en) {
		this.fieldDesc_en = fieldDesc_en;
	}

	public int getCountryId() {
		return countryId;
	}

	public void setCountryId(int countryId) {
		this.countryId = countryId;
	}

	@Override
	public String toString() {
		return "Info [id=" + id + ", title_cn=" + title_cn + ", title_en=" + title_en + ", description_cn="
				+ description_cn + ", description_en=" + description_en + ", scaleId=" + scaleId + ", scaleDesc_en="
				+ scaleDesc_en + ", fieldId=" + fieldId + ", countryId=" + countryId + ", fieldDesc_en=" + fieldDesc_en
				+ ", dateConfirmed=" + dateConfirmed + ", dateExpiry=" + dateExpiry + ", email=" + email
				+ ", inquiryNum=" + inquiryNum + ", status=" + status + ", createTime=" + createTime + ", createBy="
				+ createBy + ", updateTime=" + updateTime + ", updateBy=" + updateBy + "]";
	}








}
