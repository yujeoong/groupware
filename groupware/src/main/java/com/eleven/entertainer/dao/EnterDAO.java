package com.eleven.entertainer.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.eleven.entertainer.dto.ArtgDTO;
import com.eleven.entertainer.dto.ArtistDTO;
import com.eleven.entertainer.dto.Contract_logDTO;
import com.eleven.entertainer.dto.Ent_careerDTO;
import com.eleven.entertainer.dto.EnterDTO;
import com.eleven.entertainer.dto.FileDTO;
import com.eleven.entertainer.dto.TestDTO;

public interface EnterDAO {
	
	 ArrayList<ArtgDTO> enterWriteForm();

	 int enterRegist(EnterDTO dto);

	 void fileWrite(int entIdx, String oriFileName, String newFileName);

	 void fileWrite2(int entIdx, String oriFileName2, String newFileName2);

	 void artistRegist(int entIdx, String debut_date, String mem_id, String stage_name, String art_group);

	 void contract_log(int entIdx, String cont_start_date, String cont_end_date, String con_com);

	 void careerRegist(int entIdx, String string, String string2, String string3);

	 int enterEdit(HashMap<String, String> params);
	  
	 void artEdit(String entIdx, String debut_date, String stage_name);

	 void logEdit(String entIdx, String cont_start_date, String cont_end_date, String con_com);

	 void careerEdit(String entIdx, String string, String string2, String string3);
	 
	 void fileUpdate(int entIdx, String oriFileName, String newFileName);

	 void test_Regist1(int entIdx, int tune, int beat, int sing, int tone, int rap, int face, int gesture, int dance,
			int acting, String test_com);

	 void test_Regist2(HashMap<String, String> params);

	ArrayList<EnterDTO> enterList();

	ArrayList<FileDTO> enterFileList();
	
	ArrayList<String> art_count();
	

	ArrayList<EnterDTO> artistrList(String string);

	ArrayList<FileDTO> artistFileList();
	
	ArrayList<EnterDTO> enterSearchList(HashMap<String, String> params);
	
	ArrayList<FileDTO> enterSearchFileList(HashMap<String, String> params);

	ArrayList<EnterDTO> artSearchList(HashMap<String, String> params);

	ArrayList<FileDTO> artistSearchFileList(HashMap<String, String> params);
	
	//아티스트 그룹 이름 등록
	void artistGroup(String artg_name);
	
	// 연습생 상세보기 프로필사진
	FileDTO enterProFile(String ent_idx);
	// 연습생 상세보기 기본정보
	EnterDTO enter_list(String ent_idx);
	// 아티스트 추가 정보
	ArtistDTO art_list(String ent_idx);
	// 연습생 상세보기 평가내역
	ArrayList<TestDTO> enterTest(String ent_idx);
	// 연습생 상세보기 활동이력
	ArrayList<Ent_careerDTO> enterCareer(String ent_idx);
	// 연습생 상세보기 계약로그
	ArrayList<Contract_logDTO> enterLog(String ent_idx);
	// 연습생 상세보기 첨부파일
	ArrayList<FileDTO> enterFiles(String ent_idx);

	TestDTO enterTestForm(String ent_idx);

	ArrayList<TestDTO> enterTestRegist(HashMap<String, String> params);

	//사원리스트
	Object memList();

	Object depList();

	int artG(String ent_idx);

    int totalCount(String idCheck);
	

	

	

	


	

	//int fileDelete(int file_idx);

	




	
	
}
