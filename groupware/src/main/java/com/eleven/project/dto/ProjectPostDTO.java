package com.eleven.project.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias("prj")
public class ProjectPostDTO {

	private int prj_post_idx;
	private String prj_subject;
	private String subject;
	private String content;
	private String date;
	private String mem_id;
	private int prj_idx;
	private int prj_cat_idx;
	private int state;
	private String plan_start;
	private String plan_end;
	private String prj_cat_name;
	private String end_date;
	private String anon;
	private String name;
	private String position;
	private Date prj_end_date;
	private String depart; //부서이름
	private String posit; //직급 이름
	private String charge; //담당자 이름
	private String writer; //작성자 이름
	
	
	
	
	
	
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getCharge() {
		return charge;
	}
	public void setCharge(String charge) {
		this.charge = charge;
	}
	public String getDepart() {
		return depart;
	}
	public void setDepart(String depart) {
		this.depart = depart;
	}
	public String getPosit() {
		return posit;
	}
	public void setPosit(String posit) {
		this.posit = posit;
	}
	public Date getPrj_end_date() {
		return prj_end_date;
	}
	public void setPrj_end_date(Date prj_end_date) {
		this.prj_end_date = prj_end_date;
	}
	public String getPrj_subject() {
		return prj_subject;
	}
	public void setPrj_subject(String prj_subject) {
		this.prj_subject = prj_subject;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getName() {
		return name;
	}
	
	public int getPrj_post_idx() {
		return prj_post_idx;
	}
	public void setPrj_post_idx(int prj_post_idx) {
		this.prj_post_idx = prj_post_idx;
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

	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public int getPrj_idx() {
		return prj_idx;
	}
	public void setPrj_idx(int prj_idx) {
		this.prj_idx = prj_idx;
	}
	public int getPrj_cat_idx() {
		return prj_cat_idx;
	}
	public void setPrj_cat_idx(int prj_cat_idx) {
		this.prj_cat_idx = prj_cat_idx;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getPlan_start() {
		return plan_start;
	}
	public void setPlan_start(String plan_start) {
		this.plan_start = plan_start;
	}
	public String getPlan_end() {
		return plan_end;
	}
	public void setPlan_end(String plan_end) {
		this.plan_end = plan_end;
	}
	public String getPrj_cat_name() {
		return prj_cat_name;
	}
	public void setPrj_cat_name(String prj_cat_name) {
		this.prj_cat_name = prj_cat_name;
	}

	public String getAnon() {
		return anon;
	}
	public void setAnon(String anon) {
		this.anon = anon;
	}
	
	
	
}
