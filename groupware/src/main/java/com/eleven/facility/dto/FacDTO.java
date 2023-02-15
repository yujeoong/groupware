package com.eleven.facility.dto;

public class FacDTO {
	
	private int fac_idx;
	private String type;
	private String name;
	private String state;
	private String comment;
	
	public int getFac_idx() {
		return fac_idx;
	}
	public void setFac_idx(int fac_idx) {
		this.fac_idx = fac_idx;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}

}
