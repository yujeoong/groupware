package com.eleven.admin.dto;

import org.apache.ibatis.type.Alias;

@Alias("PosDTO")
public class PosDTO {
	private int pos_idx;
	private String name;
	private String active;
	

	public int getPos_idx() {
		return pos_idx;
	}
	public void setPos_idx(int pos_idx) {
		this.pos_idx = pos_idx;
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
