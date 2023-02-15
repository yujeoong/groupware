package com.eleven.admin.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias("CareerDTO")
public class CareerDTO {
	
	private int car_idx;
	private String mem_id; 
	private String car_category; //이력 학력 구분
	private Date start_date; //시작
	private Date end_date; //종료
	private String car_name; //회사 or 학교명
	private String detail; //비고
	
	public int getCar_idx() {
		return car_idx;
	}
	public void setCar_idx(int car_idx) {
		this.car_idx = car_idx;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getCar_category() {
		return car_category;
	}
	public void setCar_category(String car_category) {
		this.car_category = car_category;
	}
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public String getCar_name() {
		return car_name;
	}
	public void setCar_name(String car_name) {
		this.car_name = car_name;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	
	


	
	
}
