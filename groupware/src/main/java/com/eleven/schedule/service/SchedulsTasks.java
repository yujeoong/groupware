package com.eleven.schedule.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.eleven.schedule.dao.ScheDAO;
import com.eleven.schedule.dto.ScheDTO;


@Service
@EnableScheduling
public class SchedulsTasks {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired ScheDAO dao;

	// 직원 상태 변경 스케줄러  
	@Scheduled(cron = "0 * * * * ?") // "0 0 9 * * ?" : 아무 요일, 매월, 매일 오전 9:00:00
    public void task1() {
		logger.info("task1 실행 ");
		
		// 메서드 호출
		stateUpdateScheduled();

    }  
	
	// 직원 상태 업데이트 및 상태 로그 추가 
	private void stateUpdateScheduled() {
		logger.info("메서드 호출!"); 
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		Date now = new Date(); 
		SimpleDateFormat nowFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // 2023-01-11 17:01
		String strNow = nowFormat.format(now); 
		logger.info("now date :"+strNow); 
		
		ArrayList<ScheDTO> sche = dao.scheDatetime(strNow); // 스케줄러 실행된 일시와 동일한 데이터 가져오기 
		logger.info("sche :{}",sche);

		for(int i=0; i<sche.size(); i++) {
			logger.info("sche size :"+sche.size());
			String mem_id = sche.get(i).getMem_id();
			int sub_idx = sche.get(i).getSub_idx();
			String content = sche.get(i).getContent();
			String start_date = sche.get(i).getStart_date();
			String end_date = sche.get(i).getEnd_date();
			String modi_id = sche.get(i).getMem_id();
			logger.info("일정 정보 : {}, {}, {}, start: {}, end:{}, modi_id:{}", mem_id, sub_idx, content, start_date, end_date, modi_id); // 일정 정보
			
			map.put("mem_id", mem_id);	// 상태 변경된 해당 아이디 
			map.put("sub_idx", sub_idx);
			map.put("content", content);
			map.put("start_date", start_date);
			map.put("end_date", end_date);
			map.put("strNow", strNow);	// 변경일 
			map.put("modi_id", modi_id);// 변경인(로그인 아이디)
			logger.info("map:{}", map);
			 
			int success = dao.stateUpdate(map);  // sub_name 으로 업데이트 해야함! 
			sche.get(i).getEnd_date();
			if(success>0) {
				dao.stateRegist(map);
			} 
		} // end -for문  
	}
	
}
