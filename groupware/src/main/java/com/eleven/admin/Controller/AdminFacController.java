package com.eleven.admin.Controller;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eleven.admin.service.AdminFacService;

@Controller
public class AdminFacController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired AdminFacService service;
	
	
	/*시설 리스트+페이지네이션*/
	@ResponseBody
	@GetMapping(value = "/admin/facList.ajax")
	public HashMap<String, Object>facList(@RequestParam int page, String option, String searchWhat) {
		logger.info("list 요청 : {} , {}, {}", page , option,searchWhat);
		return service.Faclist(page,option,searchWhat);
	}
	
	/*시설 등록*/
	@ResponseBody
	@PostMapping(value = "/admin/facRegist.ajax")
	public HashMap<String, String> facRegist(@RequestParam HashMap<String, String> params) {
		logger.info("등록 params :"+params);
		
		String msg = "fail";
		int row = service.facRegist(params);
		logger.info("등록 성공실패 : "+row);
		if(row == 1) {
			msg = "success";	
		}
		logger.info("등록 성공실패 : "+msg);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fac", msg);
		
		return map;
	}
	
	/*시설 수정*/
	@ResponseBody
	@PostMapping(value = "/admin/facUpdate.ajax")
	public HashMap<String, String> facUpdate(@RequestParam HashMap<String, String> params) {
		logger.info("수정 params :"+params);
		
		String msg = "fail";
		int row = service.facUpdate(params);
		logger.info("수정 성공실패 : "+row);
		if(row == 1) {
			msg = "success";	
		}
		logger.info("수정 성공실패 : "+msg);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fac", msg);
		
		return map;
	}
	 

}
