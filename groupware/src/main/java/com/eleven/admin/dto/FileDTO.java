package com.eleven.admin.dto;

import org.apache.ibatis.type.Alias;

@Alias("MyFileDTO")
public class FileDTO {
	private int file_idx;
	private String ori_file_name;
	private String new_file_name;
	private int file_cat;
	private String num;
	
	
	public int getFile_idx() {
		return file_idx;
	}
	public void setFile_idx(int file_idx) {
		this.file_idx = file_idx;
	}
	public String getOri_file_name() {
		return ori_file_name;
	}
	public void setOri_file_name(String ori_file_name) {
		this.ori_file_name = ori_file_name;
	}
	public String getNew_file_name() {
		return new_file_name;
	}
	public void setNew_file_name(String new_file_name) {
		this.new_file_name = new_file_name;
	}
	public int getFile_cat() {
		return file_cat;
	}
	public void setFile_cat(int file_cat) {
		this.file_cat = file_cat;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}

	
	
	
}
