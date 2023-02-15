package com.eleven.adminMem.dto;

public class MemAuthDTO {

	private String mem_id;
	private String category;
	private String num;
	private String parti;
	private String prj_subject;
	private String dep_idx;
	private String name; 
	private String prj_idx;
	
	public String getPrj_idx() {
		return prj_idx;
	}
	public void setPrj_idx(String prj_idx) {
		this.prj_idx = prj_idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPrj_subject() {
		return prj_subject;
	}
	public void setPrj_subject(String prj_subject) {
		this.prj_subject = prj_subject;
	}
	public String getDep_idx() {
		return dep_idx;
	}
	public void setDep_idx(String dep_idx) {
		this.dep_idx = dep_idx;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getParti() {
		return parti;
	}
	public void setParti(String parti) {
		this.parti = parti;
	}
	
	
}
