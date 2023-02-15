package com.eleven.project.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eleven.project.service.PrjGanttService;

@Controller
public class PrjGanttController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired PrjGanttService service;
	
	// 간트차트 날짜 
	@GetMapping(value="/project/gantCalendar.ajax")
	@ResponseBody
	public HashMap<String, Object> todoEdit() {
		logger.info("gantCalendar 요청");
		
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		
		// 캘린더 
		Calendar today = Calendar.getInstance();
		int todayDate = today.get(Calendar.DATE); 	
		ArrayList<HashMap<String, Object>> calList = service.calendar(); // 월별 전체 일수 
		map.put("calList", calList);
		map.put("today", todayDate);
		return map;
	}
	
	
}
