package com.eleven.appr.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("apprLine")
public class ApprLineDTO {
	
	private String doc_idx;
	private String mem_id;
	private String state;
	private String order;
	private Date app_date;
	
	private String dep_name;
	private String name;
	private String duty_name;
	
	private String sign_file;
	
	public String getDoc_idx() {
		return doc_idx;
	}
	public void setDoc_idx(String doc_idx) {
		this.doc_idx = doc_idx;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public Date getApp_date() {
		return app_date;
	}
	public void setApp_date(Date date) {
		this.app_date = date;
	}
	public String getDep_name() {
		return dep_name;
	}
	public void setDep_name(String dep_name) {
		this.dep_name = dep_name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDuty_name() {
		return duty_name;
	}
	public void setDuty_name(String duty_name) {
		this.duty_name = duty_name;
	}
	public String getSign_file() {
		return sign_file;
	}
	public void setSign_file(String sign_file) {
		this.sign_file = sign_file;
	}
	
	
}
