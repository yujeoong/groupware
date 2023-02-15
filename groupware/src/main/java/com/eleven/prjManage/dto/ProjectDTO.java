package com.eleven.prjManage.dto;

import java.util.List;

import org.apache.ibatis.type.Alias;

@Alias("project")
public class ProjectDTO {
	private int prj_idx;
	private String prj_subject;
	private String prj_content;
	private String prj_start_date;
	private String prj_end_date;
	private String mem_id;
	private String taskPercent;
	
	private List<AuthorityDTO> authorityDTOList;
	
	
	public List<AuthorityDTO> getAuthorityDTOList() {
		return authorityDTOList;
	}
	public void setAuthorityDTOList(List<AuthorityDTO> authorityDTOList) {
		this.authorityDTOList = authorityDTOList;
	}
	public int getPrj_idx() {
		return prj_idx;
	}
	public void setPrj_idx(int prj_idx) {
		this.prj_idx = prj_idx;
	}
	public String getPrj_subject() {
		return prj_subject;
	}
	public void setPrj_subject(String prj_subject) {
		this.prj_subject = prj_subject;
	}
	public String getPrj_content() {
		return prj_content;
	}
	public void setPrj_content(String prj_content) {
		this.prj_content = prj_content;
	}
	public String getPrj_start_date() {
		return prj_start_date;
	}
	public void setPrj_start_date(String prj_start_date) {
		this.prj_start_date = prj_start_date;
	}
	public String getPrj_end_date() {
		return prj_end_date;
	}
	public void setPrj_end_date(String prj_end_date) {
		this.prj_end_date = prj_end_date;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getTaskPercent() {
		return taskPercent;
	}
	public void setTaskPercent(String taskPercent) {
		this.taskPercent = taskPercent;
	}
	
	
}
