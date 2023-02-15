package com.eleven.appr.dto;

import java.util.ArrayList;

import org.apache.ibatis.type.Alias;

@Alias("apprDoc")
public class ApprDocDTO {
	
	private String doc_idx;
	private String subject;
	private String content;
	private String reg_date;
	private String state;
	private String open;
	private String mem_id;
	private String comment;
	private String form_idx;
	private String form_name;
	
	private ArrayList<ApprLineDTO> apprLineDTOList;

	public String getDoc_idx() {
		return doc_idx;
	}

	public void setDoc_idx(String doc_idx) {
		this.doc_idx = doc_idx;
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

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getOpen() {
		return open;
	}

	public void setOpen(String open) {
		this.open = open;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getForm_idx() {
		return form_idx;
	}

	public void setForm_idx(String form_idx) {
		this.form_idx = form_idx;
	}
	
	public String getForm_name() {
		return form_name;
	}

	public void setForm_name(String form_name) {
		this.form_name = form_name;
	}

	public ArrayList<ApprLineDTO> getApprLineDTOList() {
		return apprLineDTOList;
	}

	public void setApprLineDTOList(ArrayList<ApprLineDTO> apprLineDTOList) {
		this.apprLineDTOList = apprLineDTOList;
	}

	
	
}
