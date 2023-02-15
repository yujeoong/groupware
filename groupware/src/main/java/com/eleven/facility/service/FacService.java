package com.eleven.facility.service;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eleven.facility.dao.FacDAO;

@Service
public class FacService {
	
	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired FacDAO dao;
	
	/*시설 리스트+페이지네이션*/
	public HashMap<String, Object> facList(int page, String option) { 
	
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map = paging(page, option);	// 페이징 메서드 호출 
		map.put("option", option);
		map.put("list", dao.facList(map));	
		logger.info("map:{}", map);
		
		return map;
	}

	// 페이징 처리 메서드 
	public HashMap<String, Object> paging(int page, String option){
		logger.info("페이징처리 요청");
		// page = 1 -> offset= 0부터 보여줘야함
		// page = 2 -> offset= 10부터 보여줘야함
		int offset = (page-1)*10;
		logger.info("offset:{}", offset);
		
		// 총 페이지 수 = 게시물 총 갯수(=totalCount)/페이지당 보여줄 수
		int totalCount= dao.totalCount(option);	// 저장된 데이터 갯수
		logger.info("totalCount : "+totalCount);
		
		// 이 경우 나머지가 생기면 page+1
		int totalPages = totalCount%10 > 0 ? (totalCount/10)+1 : (totalCount/10);
		logger.info("총 페이지 수 : " + totalPages);
		logger.info("총 페이지 수2 : "+ Math.ceil(totalCount/10));
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("offset", offset);
		map.put("total",totalPages);
		return map;
	}
	
	// 시설 상세보기 
	public HashMap<String, Object> facDetail(int fac_idx) {
		
		return dao.facDetail(fac_idx);
	}

}
