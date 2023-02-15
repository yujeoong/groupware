package com.eleven.entertainer.dto;

import org.apache.ibatis.type.Alias;

@Alias("depp")
public class DepDTO {

	private String dep_idx;
	private String dep_name;
	public String getDep_idx() {
		return dep_idx;
	}
	public void setDep_idx(String dep_idx) {
		this.dep_idx = dep_idx;
	}
	public String getDep_name() {
		return dep_name;
	}
	public void setDep_name(String dep_name) {
		this.dep_name = dep_name;
	}
	
	
}
