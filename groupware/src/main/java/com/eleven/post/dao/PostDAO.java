package com.eleven.post.dao;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.eleven.mail.dto.FileDTO;
import com.eleven.post.dto.PostDTO;

@Mapper
public interface PostDAO {

	int regist(PostDTO dto); //글작성
	
	//ArrayList<HashMap<String, Object>> editForm(String post_idx); //수정 form
	HashMap<String, Object> editForm(String post_idx);	
	
	int edit(HashMap<String, String> params); //글 수정 

	ArrayList<HashMap<String, Object>> postList(HashMap<String, Object> map); //게시판 불러오기
	
	PostDTO detail(String post_idx); //상세보기

	void upHit(String post_idx); //조회수 올리기

	int listTotal(String dep_idx, String searchType, String searchInput); //post 수 

	void fileUpload(int post_idx, String ori_file_name, String new_file_name);

	ArrayList<FileDTO> fileList(String post_idx);

	int comDelete(String post_idx);

	int postDelete(String post_idx);

	int fileDelete(File file);

	void fileUpload(String post_idx, String ori_file_name, String new_file_name);







}
