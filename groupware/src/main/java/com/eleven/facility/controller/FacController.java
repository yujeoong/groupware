package com.eleven.facility.controller;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eleven.admin.service.AdminFacService;
import com.eleven.facility.service.FacService;

@Controller
public class FacController {


	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired FacService facService; 
	@Autowired AdminFacService adminFacService;
	
	@ResponseBody
	@GetMapping(value = "/facility/faclist.ajax")
	public HashMap<String, Object>facList(@RequestParam int page, String option, String searchWhat) {
		logger.info("list 요청 : {} , {}, {}", page , option, searchWhat);
		return adminFacService.Faclist(page,option,searchWhat);
	}
	
	
	// 시설 상세보기
	@ResponseBody
	@GetMapping(value = "/facility/facDetail.ajax")
	public HashMap<String, Object> facDetail(int fac_idx){
		logger.info("fac 상세보기 :{}", fac_idx);
	
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("result", facService.facDetail(fac_idx));
		logger.info("map:{}", map);
		return map;
	}
}
