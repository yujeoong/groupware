package com.eleven.post.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentDAO {

	int comtRegist(String content, String post_idx, String mem_id); //댓글 등록

	ArrayList<HashMap<String, Object>> comListCall(HashMap<String, Object> map); //댓글 불러오기

	int listTotal(String post_idx); //댓글 수
	
	int comEdit(String content, String com_idx); //댓글 수정
	
	int comDelete(String com_idx); //댓글 삭제
	

}
