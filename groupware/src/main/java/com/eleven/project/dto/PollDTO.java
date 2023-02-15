package com.eleven.project.dto;

import org.apache.ibatis.type.Alias;

@Alias("poll")
public class PollDTO {


	private int prj_post_idx;
	private String end_date;
	private String anon;
	private String mem_id;
	private int sel_idx;
	
	
	public int getPrj_post_idx() {
		return prj_post_idx;
	}
	public void setPrj_post_idx(int prj_post_idx) {
		this.prj_post_idx = prj_post_idx;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getAnon() {
		return anon;
	}
	public void setAnon(String anon) {
		this.anon = anon;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public int getSel_idx() {
		return sel_idx;
	}
	public void setSel_idx(int sel_idx) {
		this.sel_idx = sel_idx;
	}
	
	
	
	
	
	
	
	
	
	
}
