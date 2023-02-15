package com.eleven.adminMem.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.eleven.admin.dto.MemberListDTO;
import com.eleven.adminMem.dto.MemAuthDTO;
import com.eleven.adminMem.dto.MemCareerDTO;
import com.eleven.adminMem.dto.MemChangeDTO;
import com.eleven.adminMem.dto.MemFileDTO;
import com.eleven.adminMem.dto.MemStateDTO;

@Mapper
public interface MemDetailDAO {

	// 이력 조회 
	ArrayList<MemCareerDTO> careerList(String mem_id);

	// 이력 등록 
	int careerRegist(HashMap<String, String> params);

	// 이력 삭제
	int careerDelete(int car_idx);

	// 부서,직급,직책 변경 로그 
	ArrayList<MemChangeDTO> changeList(String mem_id);

	// 상태 변경 로그
	ArrayList<MemStateDTO> stateList(String mem_id);

	// 조회 권한 수 
	ArrayList<String> authCnt(String mem_id);

	// 조회권한 리스트 
	ArrayList<MemAuthDTO> authList(String mem_id);
	
	// 소분류 리스트
	ArrayList<MemAuthDTO> cateList(String category);

	// 조회권한 등록 
	int authRegist(HashMap<String, Object> params);
	
	// 조회권한 삭제
	int authDelete(HashMap<String, Object> map);

	// 마이페이지 
	HashMap<String, Object> memDetail(String mem_id);

	// 마이페이지 -파일 여부 확인 
	int picFileChk(String mem_id, int cate);

	// 마이페이지 사진 가져오기 
	MemFileDTO picFile(String mem_id, int cate);

	
	// 사원 리스트 - 관리자 권한 관리
	int totalCount(String idCheck, String searchWhat, String searchOption, String depOption, String posOption,
			String dutyOption);
	ArrayList<MemberListDTO> memList(int offset, String searchWhat, String searchOption, String depOption,
			String posOption, String dutyOption);

	// 사원 관리자 권한 수정 
	int memAuthUpdate(HashMap<String, Object> map);

}
