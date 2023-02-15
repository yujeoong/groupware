package com.eleven.admin.dto;

import org.apache.ibatis.type.Alias;

@Alias("DepartmentDTO")
public class DepartmentDTO {
	private int dep_idx;
	private String name;
	private String active;
	
	public int getDep_idx() {
		return dep_idx;
	}
	public void setDep_idx(int dep_idx) {
		this.dep_idx = dep_idx;
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
