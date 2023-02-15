package com.eleven.facBook.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eleven.facBook.dto.FacBookDTO;
import com.eleven.facBook.service.FacBookService;

@Controller
public class FacBookController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired FacBookService fbService;
	
	// 시설 예약 조회
	@ResponseBody
	@RequestMapping(value = "/fac_book/fac_bookList.ajax")
	public HashMap<String, Object> fbList(){
		logger.info("예약 조회 요청..");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<FacBookDTO> list = fbService.fbList();
		logger.info("list :{}", list);
		
		map.put("list", list);
		return map;
	}
	
	// 상세보기
	@ResponseBody
	@RequestMapping(value = "/fac_book/fbDetail.ajax")
	public HashMap<String, Object> fbDetail(String fb_idx, HttpSession session){
		logger.info("예약 조회 요청..");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<FacBookDTO> fbDetail = fbService.fbDetail(fb_idx);
		logger.info("list :{}", fbDetail);
		// 예약자 
		String reserveId = fbService.reserveId(fb_idx);
		logger.info("reserveId :{}", reserveId);
		
		map.put("list", fbDetail); 
		map.put("reserveId", reserveId);
		logger.info("list :{}", map);
		
		// 로그인 된 아이디 불러와야함 
		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId:{}", loginId);
		
		//0번째 row에서 mem_id 컬럼의 값을 String 으로 가져옴
		String name = fbDetail.get(0).getMem_id().toString();
		logger.info("name:{}", name);
		
		if(name.equals(loginId)) { // 로그인 아이디와 작성자 아이디 비교해서 true/false 반환하기 (-> true 일 때만 수정버튼 보임 )
			map.put("loginId", true);
		} else {
			map.put("loginId", false);
		}
		
		return map;
	}
	
	// type에 따른 사용 가능한 시설명 가져오기 
	@ResponseBody
	@RequestMapping(value = "/fac_book/nameList.ajax")
	public HashMap<String, Object> nameList(int type){
		logger.info("시설리스트 요청..:{}", type);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("nameList", fbService.nameList(type));
		logger.info("map:{}", map);
		return map;
	}
	
	// 삭제하기
	@ResponseBody
	@RequestMapping(value = "/fac_book/fbDelete.ajax")
	public HashMap<String, Object> fbDelete(int fb_idx){
		logger.info("예약 삭제 요청..:{}", fb_idx);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int success=fbService.fbDelete(fb_idx);
		logger.info("delete success:{}",success);
		map.put("success", success);
		return map;
	}
	
	// 예약 시간 중복 체크 
	@ResponseBody
	@RequestMapping(value = "/fac_book/overlapCheck.ajax")
	public HashMap<String, Object> overlapCheck(String start_date, String end_date, String name){
		logger.info("예약시간 확인 start_date:{}, end_date:{}, name:{}", start_date, end_date, name);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start_date", start_date);
		map.put("end_date", end_date);
		map.put("name", name);
		
		int overlapCheck =  fbService.overlapCheck(map);
		logger.info("timsList:{}", overlapCheck);
		map.put("overlapCheck", overlapCheck);
		
		return map;
	}
	
	// 수정하기
	@ResponseBody
	@RequestMapping(value = "/fac_book/update.ajax")
	public HashMap<String, Object> fbUpdate(@RequestParam HashMap<String, String> params, String fb_idx){
		logger.info("수정 요청..:{}", fb_idx);
		logger.info("params:{}", params);
	
		HashMap<String, Object> map = new HashMap<String, Object>();
		params.put("fb_idx", fb_idx);
		
		int success = fbService.fbUpdate(params);
		logger.info("success: {}", success);
		
		if(success >0) {
			ArrayList<FacBookDTO> fbReDetail = fbService.fbDetail(fb_idx);
			//상세보기위한 데이터 다시 보내기 
			map.put("fbDetail", fbReDetail);
		}
		
		return map;
	}
	
	// 예약 등록 
	@ResponseBody
	@RequestMapping(value = "/fb_book/fbRegist.ajax")
	public HashMap<String, Object> fbRegist(@RequestParam HashMap<String, String> params, HttpSession session){
		logger.info("등록 요청 .. :{}", params);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		String loginId = (String) session.getAttribute("loginId"); 
		logger.info("loginId :"+loginId);
		
		params.put("loginId", loginId);
		logger.info("params:{}",params);
		int success = fbService.fbRegist(params);
		map.put("success", success);
		return map;
	}
}
