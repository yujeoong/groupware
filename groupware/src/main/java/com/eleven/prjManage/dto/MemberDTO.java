package com.eleven.prjManage.dto;

import org.apache.ibatis.type.Alias;

@Alias("mem_simple")
public class MemberDTO {
	private String mem_id;
	private String name;
	private String dep_idx;
	private String dep_name;
	private String pos_name;
	private String duty_name;
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDep_name() {
		return dep_name;
	}
	public void setDep_name(String dep_name) {
		this.dep_name = dep_name;
	}
	public String getPos_name() {
		return pos_name;
	}
	public void setPos_name(String pos_name) {
		this.pos_name = pos_name;
	}
	public String getDuty_name() {
		return duty_name;
	}
	public void setDuty_name(String duty_name) {
		this.duty_name = duty_name;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	private int level;
	public String getDep_idx() {
		return dep_idx;
	}
	public void setDep_idx(String dep_idx) {
		this.dep_idx = dep_idx;
	}
	
}
