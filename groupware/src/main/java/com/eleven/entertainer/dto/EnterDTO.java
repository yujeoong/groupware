package com.eleven.entertainer.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias("enter")
public class EnterDTO {
	// entertainer
	private int ent_idx;
	private String name;
	private String birth;
	private String gender;
	private String height;
	private String weight;
	private String blood;
	private String hobby;
	private String skill;
	private String enter_com;
	private String language;
	private String state;
	private int test_idx;

	// career
	private int ent_career_idx;
	private String start_date;
	private String end_date;
	private String content;

	// art_group
	private int artg_idx;
	private String artg_name;

	// test
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
	
	// artist
	private String debut_date;
	private String mem_id;
	private String stage_name;

	public String getDebut_date() {
		return debut_date;
	}

	public void setDebut_date(String debut_date) {
		this.debut_date = debut_date;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getStage_name() {
		return stage_name;
	}

	public void setStage_name(String stage_name) {
		this.stage_name = stage_name;
	}

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

	public int getEnt_career_idx() {
		return ent_career_idx;
	}

	public void setEnt_career_idx(int ent_career_idx) {
		this.ent_career_idx = ent_career_idx;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getEnt_idx() {
		return ent_idx;
	}

	public void setEnt_idx(int ent_idx) {
		this.ent_idx = ent_idx;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getHeight() {
		return height;
	}

	public void setHeight(String height) {
		this.height = height;
	}

	public String getWeight() {
		return weight;
	}

	public void setWeight(String weight) {
		this.weight = weight;
	}

	public String getBlood() {
		return blood;
	}

	public void setBlood(String blood) {
		this.blood = blood;
	}

	public String getHobby() {
		return hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

	public String getSkill() {
		return skill;
	}

	public void setSkill(String skill) {
		this.skill = skill;
	}

	public String getEnter_com() {
		return enter_com;
	}

	public void setEnter_com(String enter_com) {
		this.enter_com = enter_com;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public int getTest_idx() {
		return test_idx;
	}

	public void setTest_idx(int test_idx) {
		this.test_idx = test_idx;
	}

	public int getArtg_idx() {
		return artg_idx;
	}

	public void setArtg_idx(int artg_idx) {
		this.artg_idx = artg_idx;
	}

	public String getArtg_name() {
		return artg_name;
	}

	public void setArtg_name(String artg_name) {
		this.artg_name = artg_name;
	}

}
