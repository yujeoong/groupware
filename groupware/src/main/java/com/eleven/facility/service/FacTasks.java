package com.eleven.facility.service;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.eleven.facility.dao.FacDAO;

@Service
@EnableScheduling
public class FacTasks {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired FacDAO dao;
	
	// 직원 상태 변경 스케줄러  
	@Scheduled(cron = "0 * * * * ?") // "0 0 9 * * ?" : 아무 요일, 매월, 매일 오전 9:00:00
    public void facTask() {
		logger.info("facTask 실행 ");
		
		// 메서드 호출
		facStateUpdate();
    }  
	
	private void facStateUpdate() {
		// start_date가 오늘날짜랑 같으면 상태 사용중으로 변경 
		// end_date가 오늘날짜랑 같으면 사용가능으로 변경  
		Date now = new Date(); 
		SimpleDateFormat nowFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // 2023-01-11 17:01
		String strNow = nowFormat.format(now); 
		logger.info("now date :"+strNow);
		
		// 사용불가 아닌 시설 cnt 
		dao.facStateUpdate(strNow); 
//		int cnt = dao.facListAll();
//		if(cnt>0) {
//			for(int i=0; i<cnt; i++) {
//			}			
//		}
	}
	
}
