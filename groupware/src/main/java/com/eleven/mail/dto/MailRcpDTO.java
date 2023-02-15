package com.eleven.mail.dto;

import java.sql.Date;
import java.util.ArrayList;

import org.apache.ibatis.type.Alias;

import com.eleven.appr.dto.ApprLineDTO;

@Alias("MailRcpDTO")
public class MailRcpDTO {
	private int mail_idx;
	private String receiver_id;
	private String state;
	private String hide;
	private String title;
	private String date;

	private String name;
	private int dep_idx;
	private int pos_idx;
	
	
	private String mem_name;
	private String dept_name;
	private String pos_name;
	
	private String list_readList;
	private String list_ttlList;
	private String cat;
	
	private ArrayList<ApprLineDTO> rcpList;
	
	public int getMail_idx() {
		return mail_idx;
	}
	public void setMail_idx(int mail_idx) {
		this.mail_idx = mail_idx;
	}
	public String getReceiver_id() {
		return receiver_id;
	}
	public void setReceiver_id(String receiver_id) {
		this.receiver_id = receiver_id;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getHide() {
		return hide;
	}
	public void setHide(String hide) {
		this.hide = hide;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getDep_idx() {
		return dep_idx;
	}
	public void setDep_idx(int dep_idx) {
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
	public String getList_readList() {
		return list_readList;
	}
	public void setList_readList(String list_readList) {
		this.list_readList = list_readList;
	}
	public String getList_ttlList() {
		return list_ttlList;
	}
	public void setList_ttlList(String list_ttlList) {
		this.list_ttlList = list_ttlList;
	}
	public String getCat() {
		return cat;
	}
	public void setCat(String cat) {
		this.cat = cat;
	}
	public ArrayList<ApprLineDTO> getRcpList() {
		return rcpList;
	}
	public void setRcpList(ArrayList<ApprLineDTO> rcpList) {
		this.rcpList = rcpList;
	}
	
	

		

	
	
	

	
	
}
