package com.eleven.schedule.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Service;

import com.eleven.schedule.dao.ScheDAO;
import com.eleven.schedule.dto.ScheDTO;
import com.eleven.schedule.dto.ScheMemberDTO;
import com.eleven.schedule.dto.SubsortDTO;

@Service
@EnableScheduling
@MapperScan(value= {"com.eleven.schedule"})
public class ScheService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired ScheDAO dao; 

	// 일정 조회 
	public ArrayList<ScheDTO> scheList(String option, String loginId) {
		logger.info("캘린더 통신 서비스!");
		//dao.scheIdx();
		return dao.scheList(option, loginId);
	}

	// 소분류 조회 
	public ArrayList<SubsortDTO> subList(String mainVal) {
		
		return dao.subList(mainVal);
	}

	// 일정 등록 
	public int scheRegist(HashMap<String, String> params) { 
		
		
		return dao.scheRegist(params);
	}
	
	// 부서원 
	public List<ScheMemberDTO> memberList(String loginId) {
		return dao.memberList(loginId);
	}

	// 일정 상세보기 
	public ArrayList<ScheDTO> scheDetail(String sche_idx) {
		
		return dao.scheDetail(sche_idx);
	}
	
	// 수정 데이터 불러오기 
	public ScheDTO scheUpdateForm(String idx) {
		
		return dao.scheUpdateForm(idx);
	}
	
	// 부서일정 조회 
	public ScheDTO depSchedule(String scheIdx) {
		
		return dao.depSchedule(scheIdx);
	}

	// 부서 일정 수정 
	public int depScheUpdate(HashMap<String, String> params) {
		
		return dao.depScheUpdate(params);
	}
	
	// 일정 수정하기 
	public int scheUpdate(HashMap<String, String> params) {
		
		return dao.scheUpdate(params);
	}
	
	// 일정의 시작일시에 등록/변경 해주기 
	// 상태-비고 등록 
//	public int stateRegist(HashMap<String, String> params) {
//		
//		return dao.stateRegist(params);
//	}

	// 일정 삭제 
	public int scheDelete(int sche_idx) {
		
		return dao.scheDelete(sche_idx);
	}

	// 관리자 > 일반 사원의 일정 등록 
	public int adminScheRegist(HashMap<String, String> params) {
	 
		return dao.adminScheRegist(params);
	}

	public ArrayList<String> memberIdList(String loginId) {

		return dao.memberIdList(loginId);
	}

	
}
