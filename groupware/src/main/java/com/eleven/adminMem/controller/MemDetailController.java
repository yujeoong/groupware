package com.eleven.adminMem.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.eleven.adminMem.dto.MemAuthDTO;
import com.eleven.adminMem.dto.MemCareerDTO;
import com.eleven.adminMem.dto.MemChangeDTO;
import com.eleven.adminMem.dto.MemStateDTO;
import com.eleven.adminMem.service.MemDetailService;

@Controller
public class MemDetailController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MemDetailService service;
	
	// 사원상세보기 -마이페이지 
	@GetMapping(value="/member/mem_detail.move") 
	public ModelAndView mem_detail(HttpSession session) {
		String mem_id = (String) session.getAttribute("loginId"); 
		
		return service.memDetail(mem_id);
	}
	
	@ResponseBody
	@GetMapping(value = "/admin/memDetail.ajax")
	public HashMap<String, Object> adminMemDetail(String mem_id){
		logger.info("상세보기 요청 :"+mem_id);
		
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		
		// 조회권한 리스트 
		ArrayList<MemAuthDTO> authList = service.authList(mem_id);
		map.put("authList", authList);
		
		// 이력 조회
		ArrayList<MemCareerDTO> careerList = service.careerList(mem_id);
		logger.info("careerList :{}", careerList);
		map.put("careerList", careerList);
	
		// 부서,직급,직책 변경 로그  
		ArrayList<MemChangeDTO> changeList = service.changeList(mem_id);
		logger.info("changeList :{}", changeList); 
		map.put("changeList", changeList);
		
		// 상태 변경 로그    0: 재직중 1: 반차 2: 휴가 3: 병가 4: 출장 5: 기타 6: 퇴사
		ArrayList<MemStateDTO> stateList = service.stateList(mem_id);
		logger.info("stateList :{}", stateList); 
		for(int i=0; i<stateList.size(); i++) {
			String state= stateList.get(i).getState(); 
			if(state.equals("0")) { stateList.get(i).setState("재직중"); } 
			else if(state.equals("1")) { stateList.get(i).setState("반차"); } 
			else if(state.equals("2")) { stateList.get(i).setState("휴가"); } 	
			else if(state.equals("3")) { stateList.get(i).setState("병가"); } 	
			else if(state.equals("4")) { stateList.get(i).setState("출장"); } 	
			else if(state.equals("5")) { stateList.get(i).setState("기타"); } 	
			else if(state.equals("6")) { stateList.get(i).setState("퇴사"); } 	 
		}
		map.put("stateList", stateList);
		
		return map;
	}
	
	
	@ResponseBody
	@GetMapping(value = "/member/memDetail.ajax")
	public HashMap<String, Object> memMemDetail(String mem_id){
		logger.info("상세보기 요청 :"+mem_id);
		
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		
		// 조회권한 리스트 
		ArrayList<MemAuthDTO> authList = service.authList(mem_id);
		map.put("authList", authList);
		
		// 이력 조회
		ArrayList<MemCareerDTO> careerList = service.careerList(mem_id);
		logger.info("careerList :{}", careerList);
		map.put("careerList", careerList);
	
		// 부서,직급,직책 변경 로그  
		ArrayList<MemChangeDTO> changeList = service.changeList(mem_id);
		logger.info("changeList :{}", changeList); 
		map.put("changeList", changeList);
		
		// 상태 변경 로그    0: 재직중 1: 반차 2: 휴가 3: 병가 4: 출장 5: 기타 6: 퇴사
		ArrayList<MemStateDTO> stateList = service.stateList(mem_id);
		logger.info("stateList :{}", stateList); 
		for(int i=0; i<stateList.size(); i++) {
			String state= stateList.get(i).getState(); 
			if(state.equals("0")) { stateList.get(i).setState("재직중"); } 
			else if(state.equals("1")) { stateList.get(i).setState("반차"); } 
			else if(state.equals("2")) { stateList.get(i).setState("휴가"); } 	
			else if(state.equals("3")) { stateList.get(i).setState("병가"); } 	
			else if(state.equals("4")) { stateList.get(i).setState("출장"); } 	
			else if(state.equals("5")) { stateList.get(i).setState("기타"); } 	
			else if(state.equals("6")) { stateList.get(i).setState("퇴사"); } 	 
		}
		map.put("stateList", stateList);
		
		return map;
	}
	
	
	// 소분류 리스트
	@ResponseBody
	@GetMapping(value = "/admin/cateList.ajax")
	public HashMap<String, Object> cateList(String category){
		logger.info("cateList 요청 :{}"+category);
		
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		
		ArrayList<MemAuthDTO> cateList = service.cateList(category);
		logger.info("cateList :{}", cateList);
		map.put("cateList", cateList);
		return map;
	} 
	
	// 조회권한 등록
	@ResponseBody
	@GetMapping(value = "/admin/authRegist.ajax")
	public HashMap<String, Object> authRegist(@RequestParam HashMap<String, Object> params){
		logger.info("authRegist 요청 :{}"+params);
		
		HashMap<String, Object> map = new HashMap<String, Object>();  
		
		int success = service.authRegist(params);
		logger.info("success"+success);
		map.put("success", success);
	
		return map;
	}
	
	// 이력 등록   
	@ResponseBody
	@GetMapping(value = "/admin/careerRegist.ajax")
	public HashMap<String, Object> careerRegist(@RequestParam HashMap<String, String> params){
		logger.info("careerRegist 요청 :{}"+params);
		
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		
		int success = service.careerRegist(params);
		map.put("success", success);
		logger.info("success:"+success);
	
		return map;
	}
	
	@ResponseBody
	@GetMapping(value = "/member/careerRegist.ajax")
	public HashMap<String, Object> memberCareerRegist(@RequestParam HashMap<String, String> params){
		logger.info("careerRegist 요청 :{}"+params);
		
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		
		int success = service.careerRegist(params);
		map.put("success", success);
		logger.info("success:"+success);
	
		return map;
	}
	
	// 이력 삭제 
	@ResponseBody
	@GetMapping(value = "/admin/careerDelete.ajax")
	public HashMap<String, Object> careerDelete(int car_idx){
		logger.info("careerDelete 요청 :{}"+car_idx);
		
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		
		int success = service.careerDelete(car_idx);
		map.put("success", success);
	
		return map;
	}
	
	// 이력 삭제 
	@ResponseBody
	@GetMapping(value = "/member/careerDelete.ajax")
	public HashMap<String, Object> memberCareerDelete(int car_idx){
		logger.info("careerDelete 요청 :{}"+car_idx);
		
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		
		int success = service.careerDelete(car_idx);
		map.put("success", success);
	
		return map;
	}
	
	// 조회 권한 삭제 
	@ResponseBody
	@GetMapping(value = "/admin/authDelete.ajax")
	public HashMap<String, Object> authDelete(int num, String mem_id){
		logger.info("authDelete 요청 :{},{}",num,mem_id);
		
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		map.put("mem_id", mem_id);
		map.put("num", num);
		int success = service.authDelete(map);
		map.put("success", success);
	
		return map;
	}
	
	// 사원 리스트 - 관리자 권한 관리 
	@ResponseBody
	@RequestMapping(value = "/admin/authMemList.ajax")
	public HashMap<String, Object> authMemList(@RequestParam int page, String searchWhat, String searchOption, String depOption,String posOption,String dutyOption) {
		logger.info("list 요청1 : " + page);
		logger.info("list 요청2 : {} , {}",searchWhat,searchOption);
		logger.info("list 요청3 : {} , {} , {}",depOption,posOption,dutyOption);
		return service.authMemList(page,searchWhat,searchOption,depOption,posOption,dutyOption); 
	}
	
	// 사원 관리자 권한 수정  
	@ResponseBody
	@RequestMapping(value = "/admin/memAuthUpdate.ajax")
	public HashMap<String, Object> memAuthUpdate(String mem_id, int memAuth) {
		logger.info("memAuthUpdate 요청 :{}, {} ", mem_id, memAuth ); 
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("mem_id", mem_id);
		map.put("memAuth", memAuth);
		
		int success = service.memAuthUpdate(map);
		map.clear();
		map.put("success", success);
		return map; 
	}
}
