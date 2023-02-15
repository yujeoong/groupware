package com.eleven.entertainer.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias("album")
public class AlbumDTO {

	// Album
	private int alb_idx;
	private String alb_name;
	private String alb_title;
	
	public int getAlb_idx() {
		return alb_idx;
	}
	public void setAlb_idx(int alb_idx) {
		this.alb_idx = alb_idx;
	}
	public String getAlb_name() {
		return alb_name;
	}
	public void setAlb_name(String alb_name) {
		this.alb_name = alb_name;
	}
	public String getAlb_title() {
		return alb_title;
	}
	public void setAlb_title(String alb_title) {
		this.alb_title = alb_title;
	}
	public Date getAlb_date() {
		return alb_date;
	}
	public void setAlb_date(Date alb_date) {
		this.alb_date = alb_date;
	}
	public String getAlb_state() {
		return alb_state;
	}
	public void setAlb_state(String alb_state) {
		this.alb_state = alb_state;
	}
	public int getAlb_num() {
		return alb_num;
	}
	public void setAlb_num(int alb_num) {
		this.alb_num = alb_num;
	}
	private Date alb_date;
	private String alb_state;
	private int alb_num;
}
