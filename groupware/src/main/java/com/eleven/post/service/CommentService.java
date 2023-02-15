package com.eleven.post.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eleven.post.dao.CommentDAO;
import com.eleven.post.dto.CommentDTO;

@Service
@MapperScan(value= {"com.eleven.post"})
public class CommentService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired CommentDAO dao;
	
	
	//댓글 작성
	public int comtRegist(String content, String post_idx, String mem_id) {
		logger.info("댓글 작성 service");
		return dao.comtRegist(content, post_idx, mem_id);
	} 
	
	


	//댓글 리스트 불러오기
	public HashMap<String, Object> comtListCall(String post_idx, int page) {
		HashMap<String, Object>map = new HashMap<String, Object>();
		map=paging(post_idx, page);  //밑에 있는 map에서 return받아옴, map.put을 안하면 바로 아래에선 map 초기화..
		logger.info("map : {}", map);
		
		map.put("post_idx", post_idx);
		logger.info("service에서 보내는 post_idx : "+post_idx);
		
		logger.info("map : {}",map);
		map.put("comtList", dao.comListCall(map)); //post_idx와 offset map에 넣어주기 
		return map;
	}
	

	//페이징 처리 
	private HashMap<String, Object> paging(String post_idx, int page) {
		logger.info("페이징처리 요청");
		// page = 1 -> offset= 0부터 보여줘야함
		// page = 2 -> offset= 10부터 보여줘야함
		logger.info("page : "+page);
		int offset = (page-1)*10;
		logger.info("offset : {}", offset);
		
		// 총 페이지 수 = 게시물 총 갯수(=totalCount)/페이지당 보여줄 수
		int totalCount= dao.listTotal(post_idx);	// 저장된 데이터 갯수
		logger.info("totalCount : "+totalCount);
		logger.info("totalCount 셀때의 post_idx : "+post_idx );
		
		// 이 경우 나머지가 생기면 page+1
		int totalPages = totalCount%10 > 0 ? (totalCount/10)+1 : (totalCount/10);
		logger.info("총 페이지 수 : " + totalPages);
		logger.info("총 페이지 수2 : "+ Math.ceil(totalCount/10));
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("offset", offset);
		map.put("total",totalPages);
		return map;
	}


	public int comEdit(String com_idx, String content) {
		logger.info("댓글 수정 service");
		return dao.comEdit(content, com_idx);
	}


	public int comDelete(String com_idx) {
		logger.info("댓글 삭제 service");
		return dao.comDelete(com_idx);
	}





	
	

}
