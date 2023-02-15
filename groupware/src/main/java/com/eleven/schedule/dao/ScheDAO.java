package com.eleven.schedule.dao;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eleven.schedule.dto.ScheDTO;
import com.eleven.schedule.dto.ScheMemberDTO;
import com.eleven.schedule.dto.ScheNotiDTO;
import com.eleven.schedule.dto.SubsortDTO;

@Mapper
public interface ScheDAO {
	// 스케줄러 :일정 조회 
	ArrayList<ScheDTO> scheDatetime(String strNow);
	
	// 아이디 상태 변경
	int stateUpdate(HashMap<String, Object> map);
	
	// 상태 로그 
	int stateRegist(HashMap<String, Object> map);

	ArrayList<ScheDTO> scheList(String option, String loginId);

	ArrayList<SubsortDTO> subList(String mainVal);

	int scheRegist(HashMap<String, String> params);


	List<ScheMemberDTO> memberList(String loginId);

	ArrayList<ScheDTO> scheDetail(String sche_idx);

	ScheDTO scheUpdateForm(String idx);

	ScheDTO depSchedule(String scheIdx);

	int depScheUpdate(HashMap<String, String> params);

	int scheUpdate(HashMap<String, String> params);

	int scheDelete(int sche_idx);
 
	// 스케줄 알림 등록
	int sendNoti(ScheNotiDTO dto);

	// 알림 수신자 등록
	void sendNotiRcp(String noti_idx, String rcp);

	// 관리자 > 일반 사원의 일정 등록 
	int adminScheRegist(HashMap<String, String> params);

	ArrayList<String> memberIdList(String loginId);

	

	






	

	

}

