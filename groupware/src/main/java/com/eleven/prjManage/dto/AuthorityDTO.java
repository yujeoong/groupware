package com.eleven.prjManage.dto;

import java.util.List;

import org.apache.ibatis.type.Alias;

@Alias("authority")
public class AuthorityDTO {
	private String mem_id;
	private int category;
	private int num;
	private String parti;
	private String name;
	private String dep_name;
	private String duty_name;
	private String pos_name;
	
	private List<AuthorityDTO> authorityDTOList;
	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getParti() {
		return parti;
	}
	public void setParti(String parti) {
		this.parti = parti;
	}
	public List<AuthorityDTO> getAuthorityDTOList() {
		return authorityDTOList;
	}
	public void setAuthorityDTOList(List<AuthorityDTO> authorityDTOList) {
		this.authorityDTOList = authorityDTOList;
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
	
	
	
	
	
}
