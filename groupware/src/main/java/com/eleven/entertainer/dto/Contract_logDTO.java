package com.eleven.entertainer.dto;

import org.apache.ibatis.type.Alias;
@Alias("contract_log")
public class Contract_logDTO {

	//contract_log
	private String cont_change;
	private String cont_start_date;
	private String cont_end_date;
	private String con_com;
	
	public String getCont_change() {
		return cont_change;
	}
	public void setCont_change(String cont_change) {
		this.cont_change = cont_change;
	}
	public String getCont_start_date() {
		return cont_start_date;
	}
	public void setCont_start_date(String cont_start_date) {
		this.cont_start_date = cont_start_date;
	}
	public String getCont_end_date() {
		return cont_end_date;
	}
	public void setCont_end_date(String cont_end_date) {
		this.cont_end_date = cont_end_date;
	}
	public String getCon_com() {
		return con_com;
	}
	public void setCon_com(String con_com) {
		this.con_com = con_com;
	}
	public int getEnt_idx() {
		return ent_idx;
	}
	public void setEnt_idx(int ent_idx) {
		this.ent_idx = ent_idx;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	private int ent_idx;
	private String mem_id;
	
	
}
