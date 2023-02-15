package com.eleven.appr.dto;

import org.apache.ibatis.type.Alias;

@Alias("docForm")
public class DocFormDTO {
	private String form_idx;
	private String subject;
	private String content;
	private String use;
	public String getForm_idx() {
		return form_idx;
	}
	public void setForm_idx(String form_idx) {
		this.form_idx = form_idx;
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
	public String getUse() {
		return use;
	}
	public void setUse(String use) {
		this.use = use;
	}

	
}
