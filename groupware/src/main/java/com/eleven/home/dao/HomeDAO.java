package com.eleven.home.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.eleven.home.dto.HomeTaskDTO;
import com.eleven.home.dto.HomeDocDTO;
import com.eleven.home.dto.HomeTodoDTO;

public interface HomeDAO {
	
	// 투두 리스트 
	ArrayList<HomeTodoDTO> todoList(String loginId);
	
	// 투두 등록
	int todoRegist(HashMap<String, Object> map);

	// 투두 삭제 
	int todoDelete(int todo_idx);
	
	// 투두 수정
	int todoEdit(HashMap<String, Object> map);
	
	// 투두 done 
	int todoDoneEdit(HashMap<String, Object> map);

	// done='Y'
	int todoCnt(); 
	void todoCron(int cnt);

	// 결재 문서 
	ArrayList<HomeDocDTO> appr_docList(String loginId);

	// 프로젝트 수 
	ArrayList<HomeTaskDTO> prjList();

	// 업무 리스트 
	ArrayList<HomeTaskDTO> taskList(HashMap<String, Object> map);

	// 매일12시 완료된 업무 삭제 
	void todoDeleteSchedule();
	










}
