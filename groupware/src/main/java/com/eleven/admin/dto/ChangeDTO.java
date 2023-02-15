package com.eleven.admin.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias("ChangeDTO")
public class ChangeDTO {
	
	private String mem_id;
	private int dep_idx;
	private int pos_idx;
	private int duty_idx;
	private String modi_idx;
	private Date date;
	private String comment;
	
	private String depName; //as 
	private String posName; //as
	private String dutyName; //as
	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public int getDep_idx() {
		return dep_idx;
	}
	public void setDep_idx(int dep_idx) {
		this.dep_idx = dep_idx;
	}
	public int getPos_idx() {
		return pos_idx;
	}
	public void setPos_idx(int pos_idx) {
		this.pos_idx = pos_idx;
	}
	public int getDuty_idx() {
		return duty_idx;
	}
	public void setDuty_idx(int duty_idx) {
		this.duty_idx = duty_idx;
	}

	public String getModi_idx() {
		return modi_idx;
	}
	public void setModi_idx(String modi_idx) {
		this.modi_idx = modi_idx;
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
	public String getDepName() {
		return depName;
	}
	public void setDepName(String depName) {
		this.depName = depName;
	}
	public String getPosName() {
		return posName;
	}
	public void setPosName(String posName) {
		this.posName = posName;
	}
	public String getDutyName() {
		return dutyName;
	}
	public void setDutyName(String dutyName) {
		this.dutyName = dutyName;
	}
	
	
	
	
	
	
	
	
	
	
	
}
