package com.eleven.project.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class PrjGanttService {
	
	Logger logger = LoggerFactory.getLogger(getClass());

	// 간트차트 캘린더
	public ArrayList<HashMap<String, Object>> calendar() {
		logger.info("service");
		
		HashMap<String, Object> map = null;
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		// 캘린더 인스턴스 생성 
		Calendar cal = Calendar.getInstance();
		
		// 날짜 데이터 배열
		//String[][] calDate = new String[6][7];
		
		int startDay;   // 월 시작 요일
		int lastDay;    // 월 마지막 날짜
		int inputDate;  // 입력 날짜
		
		int month;
		int year=2023;
		
		for(month = 1; month <= 12; month++) {
			map = new HashMap<String, Object>();
			cal.set(Calendar.YEAR, year);
			cal.set(Calendar.MONTH, month-1);
			cal.set(Calendar.DATE, 1);

			startDay = cal.get(Calendar.DAY_OF_WEEK); // 요일을 알아내는 함수 
			lastDay = cal.getActualMaximum(Calendar.DATE); // 해당월의 마지막 날짜를 알아내는 함수
			//logger.info("month:{}", month);
			//logger.info("lastDay:{}", lastDay);

			map.put("month", month);
			map.put("day", lastDay);
			
			list.add((month-1), map);
		}
		logger.info("list :{}", list); 
		return list;
	} 

}
