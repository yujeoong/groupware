package com.eleven.entertainer.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias("test")
public class TestDTO {

	// test
	private int ent_idx;
	private Date test_date;
	private int tune;
	private int beat;
	private int sing;
	private int tone;
	private int rap;
	private int face;
	private int gesture;
	private int dance;
	private int acting;
	private String test_com;
	
	public Date getTest_date() {
		return test_date;
	}
	public void setTest_date(Date test_date) {
		this.test_date = test_date;
	}
	public int getTune() {
		return tune;
	}
	public void setTune(int tune) {
		this.tune = tune;
	}
	public int getBeat() {
		return beat;
	}
	public void setBeat(int beat) {
		this.beat = beat;
	}
	public int getSing() {
		return sing;
	}
	public void setSing(int sing) {
		this.sing = sing;
	}
	public int getTone() {
		return tone;
	}
	public void setTone(int tone) {
		this.tone = tone;
	}
	public int getRap() {
		return rap;
	}
	public void setRap(int rap) {
		this.rap = rap;
	}
	public int getFace() {
		return face;
	}
	public void setFace(int face) {
		this.face = face;
	}
	public int getGesture() {
		return gesture;
	}
	public void setGesture(int gesture) {
		this.gesture = gesture;
	}
	public int getDance() {
		return dance;
	}
	public void setDance(int dance) {
		this.dance = dance;
	}
	public int getActing() {
		return acting;
	}
	public void setActing(int acting) {
		this.acting = acting;
	}
	public String getTest_com() {
		return test_com;
	}
	public void setTest_com(String test_com) {
		this.test_com = test_com;
	}
	public int getEnt_idx() {
		return ent_idx;
	}
	public void setEnt_idx(int ent_idx) {
		this.ent_idx = ent_idx;
	}
	
}
