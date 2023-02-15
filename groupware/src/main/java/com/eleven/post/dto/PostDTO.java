package com.eleven.post.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias("PostDTO")
public class PostDTO {
	
	private String	post_idx;
	private String subject;
	private String content;
	private int	cnt;
	private String date;
	private String mem_id;
	private String	 dep_idx;
	private int pos_idx;
	
	
	private String mem_name;
	private String dept_name;
	private String pos_name;
	
	
	
	
	public String getPost_idx() {
		return post_idx;
	}
	public void setPost_idx(String post_idx) {
		this.post_idx = post_idx;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getDep_idx() {
		return dep_idx;
	}
	public void setDep_idx(String dep_idx) {
		this.dep_idx = dep_idx;
	}
	public int getPos_idx() {
		return pos_idx;
	}
	public void setPos_idx(int pos_idx) {
		this.pos_idx = pos_idx;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public String getPos_name() {
		return pos_name;
	}
	public void setPos_name(String pos_name) {
		this.pos_name = pos_name;
	}
	
	
	
	
	
	
	
	
	
	

	
}
