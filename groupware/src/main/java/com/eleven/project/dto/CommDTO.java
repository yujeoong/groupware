package com.eleven.project.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias("comm")
public class CommDTO {

	private int prj_com_idx;
	private int prj_post_idx;
	private String mem_id;
	private String com_content;
	private String com_date;
	private String name;
	
	
	
	
	public String getCom_date() {
		return com_date;
	}
	public void setCom_date(String com_date) {
		this.com_date = com_date;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrj_com_idx() {
		return prj_com_idx;
	}
	public void setPrj_com_idx(int prj_com_idx) {
		this.prj_com_idx = prj_com_idx;
	}
	public int getPrj_post_idx() {
		return prj_post_idx;
	}
	public void setPrj_post_idx(int prj_post_idx) {
		this.prj_post_idx = prj_post_idx;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getCom_content() {
		return com_content;
	}
	public void setCom_content(String com_content) {
		this.com_content = com_content;
	}

	
}
