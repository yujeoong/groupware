package com.eleven.schedule.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eleven.noti.service.NotiService;
import com.eleven.schedule.dto.ScheDTO;
import com.eleven.schedule.dto.ScheMemberDTO;
import com.eleven.schedule.dto.SubsortDTO;
import com.eleven.schedule.service.ScheService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;


@Controller
public class ScheController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired ScheService scheService;
	@Autowired NotiService notiService;

	
	// 일정 조회 
	@ResponseBody
	@RequestMapping(value = "/schedule/list.ajax")
	public HashMap<String, Object> scheListCall(HttpSession session, @RequestParam String option){
		logger.info("캘린더 통신 성공!!");
		logger.info("option :{}",option);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		// 로그인 아이디 
		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId: {}", loginId);
		
		ArrayList<ScheDTO> scheList = scheService.scheList(option, loginId);
		logger.info("scheList :{}", scheList);
		
		map.put("scheList", scheList);
		return map;
	}
	
	// 소분류 조회
	@ResponseBody
	@RequestMapping(value = "/schedule/regist/sub/list.ajax")
	public HashMap<String, Object> subList(@RequestParam String mainVal){
		logger.info("소분류 리스트 요청");
		logger.info("mainVal :{}", mainVal);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<SubsortDTO> subList = scheService.subList(mainVal);
		
		map.put("subList", subList);
		return map;
	}
	
	// 일정 등록
	@ResponseBody
	@RequestMapping(value = "/schedule/regist.ajax")
	public HashMap<String, Object> scheRegist(@RequestParam HashMap<String, String> params, HttpSession session) {
		logger.info("일정등록 요청..");
		logger.info("params :{}",params);
		 
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int main_sort = Integer.parseInt(params.get("main_sort")); // 중분류 
		logger.info("main_sort:{}", main_sort);

		// 로그인 아이디와 같은 부서원 
		String loginId = (String) session.getAttribute("loginId");
		
		int row=0; // 등록 성공 여부 	
		params.put("loginId", loginId); // 작성인 
		row = scheService.scheRegist(params);
		logger.info("일정 등록 row:{}", row);
		
		ScheDTO dto = new ScheDTO();
		dto.setSubject(params.get("subject"));    
		String subject = dto.getSubject(); 
		logger.info("subject:"+subject); 
		
		//List<ScheMemberDTO> idList = scheService.memberList(loginId); // 로그인 아이디와 같은 부서원 
		ArrayList<String> idList = scheService.memberIdList(loginId);
		logger.info("idList:{}", idList);
		
		if(row>0) {
			notiService.sendNoti("["+subject+"] 일정이 등록되었습니다.", loginId, idList);	 
		}

		map.put("success", row); 
		return map;
	}
	
	// 관리자 > 일반 사원의 일정 등록 
	@ResponseBody
	@RequestMapping(value = "/schedule/adminRegist.ajax")
	public HashMap<String, Object> adminScheRegist(@RequestParam HashMap<String, String> params) {
		logger.info("일정등록 요청..");
		logger.info("params :{}",params);
		 
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		String mem_id = params.get("mem_id");
		String subject = params.get("subject");
		logger.info("mem_id:"+mem_id);
		logger.info("subject:"+subject);

		int row=0; // 등록 성공 여부 	 
		row = scheService.adminScheRegist(params);
		logger.info("일정 등록 row:{}", row);
		
		//List<ScheMemberDTO> idList = scheService.memberList(mem_id); // 로그인 아이디와 같은 부서원 
		ArrayList<String> idArrayList = scheService.memberIdList(mem_id);
		logger.info("idArrayList :{}", idArrayList);
		
		if(row>0) {
			notiService.sendNoti("관리자 : ["+subject+"] 일정이 등록되었습니다.", mem_id, idArrayList);	 
		}
 

		map.put("success", row); 
		return map;
	}
	
	
	// 상세보기
	@ResponseBody
	@RequestMapping(value = "/schedule/detail.ajax")
	public HashMap<String, Object> scheDetail(HttpSession session, String sche_idx){
		logger.info("상세보기 요청 idx :{}", sche_idx);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<ScheDTO> scheDetail = scheService.scheDetail(sche_idx);
		//logger.info("scheDetail :{}", scheDetail);
		map.put("detail", scheDetail);
		
		// 로그인 된 아이디
		String loginId = (String) session.getAttribute("loginId");;
		logger.info("loginId:{}", loginId);
		
		//0번째 row에서 mem_id 컬럼의 값을 String 으로 가져옴
		String name = scheDetail.get(0).getMem_id().toString();
		logger.info("name:{}", name);
		
		if(name.equals(loginId)) { // 로그인 아이디와 작성자 아이디 비교해서 true/false 반환하기 (-> true 일 때만 수정버튼 보임 )
			map.put("loginId", true);
		} else {
			map.put("loginId", false);
		}
		
		logger.info("detail :{}", map);
		return map;
	}

	
	// 수정 폼 이동
	@RequestMapping(value = "/schedule/updateForm")
	public String scheUpdateForm(Model model, String sche_idx) {
		logger.info("수정 이동 요청 idx :{}", sche_idx);
		
		ScheDTO dto = scheService.scheUpdateForm(sche_idx);
		logger.info("dto:{}", dto);
		model.addAttribute("dto", dto);
		
		return "schedule/scheUpdateForm";
	}
		
	// 수정하기
	@ResponseBody
	@RequestMapping(value = "/schedule/update.do")
	public HashMap<String, Object> scheUpdate(HttpSession session, @RequestParam HashMap<String, String> params, String scheIdx) {
		logger.info("일정수정 요청..");
		logger.info("params :{}",params);
		logger.info("scheIdx :{}", scheIdx);
		
		ObjectMapper mapper = new ObjectMapper(); // 객체를 JSON 스트링으로 변환하기
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("YYYY-MM-DD");
		int main_sort = Integer.parseInt(params.get("param[main_sort]")); // 중분류 
		logger.info("main_sort:{}", main_sort);

		// 로그인 아이디 (수정인)
		String loginId = (String) session.getAttribute("loginId");
		
//		sche_idx가 모두 달라서 한번에 바꿀수 없음........############## 일단 모든 내용이 같은 항목만 바꾸는 걸로 /..... 
		int row=0; // 등록 성공 여부 	
		List<ScheMemberDTO> idList = scheService.memberList(loginId); // 로그인 아이디와 같은 부서원
		logger.info("부서원 :{}", idList); 	
		if(main_sort==1) { // 부서 일정일 경우 모든 부서원의 일정으로 등록 
			
			for(int i=0; i<idList.size(); i++) {
				try {
					String id =  mapper.writeValueAsString(idList.get(i)).replaceAll("[^0-9]", ""); // 숫자만 남김 
					logger.info("id:{}", id);
					
					params.put("loginId", id); // 부서원 아이디 
					params.put("scheIdx", scheIdx);
					
					ScheDTO depSche = scheService.depSchedule(scheIdx);
					logger.info("부서 일정:{}",depSche);
					String old_sub_idx = String.valueOf(depSche.getSub_idx());
					String old_main_idx = String.valueOf(depSche.getMain_idx());
					String old_subject = depSche.getSubject();
					String old_location = depSche.getLocation();
					String old_start_date = depSche.getStart_date();
					String old_end_date = depSche.getEnd_date();
					String old_content = depSche.getContent();
					
					params.put("old_sub_idx", old_sub_idx);
					params.put("old_main_idx", old_main_idx);
					params.put("old_subject", old_subject);
					params.put("old_location", old_location);
					params.put("old_start_date", old_start_date);
					params.put("old_end_date", old_end_date);
					params.put("old_content", old_content);
	
					params.put("subject", params.get("param[subject]"));
					params.put("start_date", params.get("param[start_date]"));
					params.put("end_date", params.get("param[end_date]"));
					params.put("main_sort", params.get("param[main_sort]"));
					params.put("sub_sort", params.get("param[sub_sort]"));
					params.put("location", params.get("param[location]"));
					params.put("content", params.get("param[content]"));
					params.put("comment", params.get("param[comment]"));
					
					logger.info("params:{}", params);
					row = scheService.depScheUpdate(params);	// 같은 부서원 모두 일정으로 등록 
					logger.info("일정 수정 row:{}", row); 
					 
				  
					
					map.put("success", row); 
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
			} // for
			String subject = params.get("subject");
			logger.info("subject:"+subject); 
			ArrayList<String> idArrayList = scheService.memberIdList(loginId);
			logger.info("idArrayList:{}",idArrayList); 
			if(row>0) {
				notiService.sendNoti("["+subject+"] 부서 일정이 수정되었습니다.", loginId, idArrayList);	 
			} 
		} else if(main_sort==2) { // 개인일정 등록, 상태 등록
			logger.info("개인일정 수정 요청.. ");
			logger.info("상태 등록일 :{}", simpleDateFormat.format(System.currentTimeMillis()));
			
			params.put("loginId", loginId); // 수정인(수정은 관리자, 본인만 가능 여기서는 본인만 다룸, 관리자는 민정언니)
			params.put("subject", params.get("param[subject]"));
			params.put("start_date", params.get("param[start_date]"));
			params.put("end_date", params.get("param[end_date]"));
			params.put("main_sort", params.get("param[main_sort]"));
			params.put("sub_sort", params.get("param[sub_sort]"));
			params.put("location", params.get("param[location]"));
			params.put("content", params.get("param[content]"));
			params.put("comment", params.get("param[comment]"));
			params.put("scheIdx", scheIdx);
			params.put("date", simpleDateFormat.format(System.currentTimeMillis())); 
			row = scheService.scheUpdate(params); // 일정등록  
			
			
			String subject = params.get("param[subject]"); 
			logger.info("subject:"+subject);  
			
			ArrayList<String> idArrayList = scheService.memberIdList(loginId);
			logger.info("idArrayList:{}",idArrayList); 
			if(row>0) {
				notiService.sendNoti("["+subject+"] 일정이 수정되었습니다.", loginId, idArrayList);	 
			}  
			map.put("success", row);
		}
		
		return map;
	}
	
	// 일정 삭제
	@ResponseBody
	@RequestMapping(value = "/schedule/delete.ajax")
	public HashMap<String, Object> scheDelete(HttpSession session, int sche_idx){
		logger.info("일정 삭제 요청 : {}",sche_idx);
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		String loginId = (String) session.getAttribute("loginId");
		String name = (String) session.getAttribute("name");
		int success=scheService.scheDelete(sche_idx);
		logger.info("delete success:{}",success);
		
		ArrayList<String> idArrayList = scheService.memberIdList(loginId);
		logger.info("idArrayList:{}",idArrayList);
		if(success>0) {
			notiService.sendNoti("["+name+"]님 일정이 삭제되었습니다.", loginId, idArrayList); 
		}   
		
		map.put("success", success);
		return map;
	}
		

}










