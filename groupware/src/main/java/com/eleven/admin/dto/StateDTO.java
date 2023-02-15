package com.eleven.admin.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias("StateDTO")
public class StateDTO {
	
	private String state;
	private Date date;
	private String comment;
	private String mem_id;
	private String modi_id;
	
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getModi_id() {
		return modi_id;
	}
	public void setModi_id(String modi_id) {
		this.modi_id = modi_id;
	}
	
	
	
	
	
	
}
