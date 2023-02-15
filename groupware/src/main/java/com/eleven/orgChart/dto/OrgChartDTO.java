package com.eleven.orgChart.dto;

import org.apache.ibatis.type.Alias;

@Alias("OrgChartDTO")
public class OrgChartDTO {

	private String mem_id;
	private String email;
	private String phone;
	private String dept_name;
	private String parent_id;
	private String mem_name;
	private String duty_name;
	private String pos_name;

	private String new_file_name;
	private String file_cat;
	
	private String stack; 
	private int level = 0;
	
	
	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public String getParent_id() {
		return parent_id;
	}
	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getDuty_name() {
		return duty_name;
	}
	public void setDuty_name(String duty_name) {
		this.duty_name = duty_name;
	}
	public String getPos_name() {
		return pos_name;
	}
	public void setPos_name(String pos_name) {
		this.pos_name = pos_name;
	}
	public String getNew_file_name() {
		return new_file_name;
	}
	public void setNew_file_name(String new_file_name) {
		this.new_file_name = new_file_name;
	}
	public String getFile_cat() {
		return file_cat;
	}
	public void setFile_cat(String file_cat) {
		this.file_cat = file_cat;
	}
	public String getStack() {
		return stack;
	}
	public void setStack(String stack) {
		this.stack = stack;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	
	
	
	
	
	
	
	
	
	
}
