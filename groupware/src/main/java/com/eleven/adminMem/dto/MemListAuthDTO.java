package com.eleven.adminMem.dto;

public class MemListAuthDTO {

	private String mem_id;
	private String state;
	private int level;
	private String name;
	private String email;
	private String depname; //부서명 alias
	private String dutyname; //직책명 alias
	private String posname; //직급명 alias
	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDepname() {
		return depname;
	}
	public void setDepname(String depname) {
		this.depname = depname;
	}
	public String getDutyname() {
		return dutyname;
	}
	public void setDutyname(String dutyname) {
		this.dutyname = dutyname;
	}
	public String getPosname() {
		return posname;
	}
	public void setPosname(String posname) {
		this.posname = posname;
	}
	
}
