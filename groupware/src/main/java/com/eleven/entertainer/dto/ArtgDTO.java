package com.eleven.entertainer.dto;

import org.apache.ibatis.type.Alias;

@Alias("artg")
public class ArtgDTO {

	private int artg_idx;
	private String artg_name;

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
