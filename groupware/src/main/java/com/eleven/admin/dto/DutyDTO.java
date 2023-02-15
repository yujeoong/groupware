package com.eleven.admin.dto;

import org.apache.ibatis.type.Alias;

@Alias("DutyDTO")
public class DutyDTO {
	private int duty_idx;
	private int level;
	private String name;
	private String active;
	

	public int getDuty_idx() {
		return duty_idx;
	}
	public void setDuty_idx(int duty_idx) {
		this.duty_idx = duty_idx;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}
	
	
}
