package com.eleven.project.dto;

import org.apache.ibatis.type.Alias;

@Alias("sel")
public class SelDTO {

	private int sel_idx;
	private int prj_post_idx;
	private String sel_content;
	private String totalCount;
	private int pollcount;
	private String depart;
	private String posit;
	private String name;
	private int offset;
	
	
	
	
	

	
	
	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPollcount() {
		return pollcount;
	}
	public void setPollcount(int pollcount) {
		this.pollcount = pollcount;
	}
	public String getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(String totalCount) {
		this.totalCount = totalCount;
	}
	public int getPrj_post_idx() {
		return prj_post_idx;
	}
	public void setPrj_post_idx(int poll_prj_post_idx) {
		this.prj_post_idx = poll_prj_post_idx;
	}
	public int getSel_idx() {
		return sel_idx;
	}
	public void setSel_idx(int sel_idx) {
		this.sel_idx = sel_idx;
	}
	public String getSel_content() {
		return sel_content;
	}
	public void setSel_content(String sel_content) {
		this.sel_content = sel_content;
	}
	

}
