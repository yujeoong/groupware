package com.eleven.entertainer.dto;

import org.apache.ibatis.type.Alias;

@Alias("ent_career")
public class Ent_careerDTO {

	private int ent_idx;
	private int ent_career_idx;
	private String start_date;
	private String end_date;
	private String content;
	private Ent_careerDTO careerList;
	
	public Ent_careerDTO getCareerList() {
		return careerList;
	}
	public void setCareerList(Ent_careerDTO careerList) {
		this.careerList = careerList;
	}
	public int getEnt_idx() {
		return ent_idx;
	}
	public void setEnt_idx(int ent_idx) {
		this.ent_idx = ent_idx;
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
}
