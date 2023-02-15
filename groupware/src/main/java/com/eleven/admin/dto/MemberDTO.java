package com.eleven.admin.dto;

import java.sql.Date;
import java.time.LocalDate;

import org.apache.ibatis.type.Alias;

@Alias("MemberDTO")
public class MemberDTO {
	
	private String mem_id; 
	private String pw; //defalut 0000
	private String name;
	private int dep_idx;
	private int pos_idx;
	private int duty_idx;
	private String parent_id;
	private Date join_date;
	private String email;
	private int level; //defalut 2
	private String stack; // defalut Y
	private String phone;
	private String address;
	private String birthday;
	
	private String comment; //각종 비고
	private LocalDate todayKor; //일자
	private String state; //상태
	private int cate; //권한 - 카테고리
	private String auth; //조회 권한 / Y-N
	private String sessionId; //modi id
	
	public String getBirthday() {
		return birthday;
	}
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public LocalDate getTodayKor() {
		return todayKor;
	}
	public void setTodayKor(LocalDate todayKor) {
		this.todayKor = todayKor;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public int getCate() {
		return cate;
	}
	public void setCate(int cate) {
		this.cate = cate;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
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
	public int getDuty_idx() {
		return duty_idx;
	}
	public void setDuty_idx(int duty_idx) {
		this.duty_idx = duty_idx;
	}
	public String getParent_id() {
		return parent_id;
	}
	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
	public Date getJoin_date() {
		return join_date;
	}
	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public String getStack() {
		return stack;
	}
	public void setStack(String stack) {
		this.stack = stack;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	
}
