package com.eleven.orgChart.controller;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eleven.orgChart.service.OrgChartService;

@Controller
public class OrgChartController {
	
	@Autowired OrgChartService service;

	Logger logger = LoggerFactory.getLogger(getClass());

	
	//페이지 이동
	@GetMapping(value="/orgChart.move")
	public String orgChartMove() {
		return "orgChart/orgChart";
	}
	
	
	//org 리스트 불러오기
	@ResponseBody //ajax는 Responsebody 사용
	@GetMapping(value="/orgChart.ajax")
	public HashMap<String, Object> org(){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("list", service.orgList());
		logger.info("map {} ",map);
		return map;
	}




}
