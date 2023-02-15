package com.eleven.home.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.eleven.home.dao.HomeDAO;

@Service
@EnableScheduling
public class TodoTasks {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired HomeDAO dao;

	// 직원 상태 변경 스케줄러  
	@Scheduled(cron = "0 0 0 * * ?") // "0 0 9 * * ?" : 아무 요일, 매월, 매일 오전 9:00:00
    public void todoTask() {
		logger.info("todoTask 실행 ");
		
		// 메서드 호출
		todoDelete(); 
    }  
	
	private void todoDelete() {
		dao.todoDeleteSchedule();
	}
}
