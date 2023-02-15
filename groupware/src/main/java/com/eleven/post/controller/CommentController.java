package com.eleven.post.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eleven.post.dto.CommentDTO;
import com.eleven.post.service.CommentService;

@Controller
public class CommentController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired CommentService service; 
	

	//댓글 작성
	@RequestMapping(value="/post/detail/comtRegist.ajax")
	@ResponseBody
	public HashMap<String, Object> comtRegist(HttpSession session, @RequestParam HashMap<String, String> params){
		
		String content = params.get("content");
		String post_idx = params.get("post_idx");
		String mem_id = (String) session.getAttribute("loginId");
		
		logger.info("컨트롤러 content : "+content);
		logger.info("컨트롤러 post_idx : "+post_idx);
		logger.info("컨트롤러 loginId : "+mem_id);
		
		int row = service.comtRegist(content, post_idx, mem_id);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success",row);
		
		return map;
	}
	
	
	
	//댓글 리스트 불러오기
	@RequestMapping(value="/post/detail/comtListCall.ajax")
	@ResponseBody
	public HashMap<String, Object> comtListCall(@RequestParam(value="post_idx") String post_idx, @RequestParam(value="page") int page){
		logger.info("post_idx : "+post_idx);
		logger.info("page : "+page);
		
		return service.comtListCall(post_idx, page);
	}
	
	
	//댓글 수정
	@RequestMapping(value="/post/detail/comEdit.ajax")
	@ResponseBody
	public HashMap<String, Object> comEdit(HttpSession session, @RequestParam HashMap<String, String> params){
		String com_idx = params.get("com_idx");
		String content = params.get("content");
		logger.info("댓글 수정 controller, content : "+content);
		int row = service.comEdit(com_idx, content);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", row);
	
		return map;
	}
	
	//댓글 삭제
	@RequestMapping(value="/post/detail/comDelete.ajax")
	@ResponseBody
	public HashMap<String, Object> comDelete(HttpSession session, @RequestParam HashMap<String, String> params){
		String com_idx = params.get("com_idx");
		int row = service.comDelete(com_idx);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", row);
	
		return map;
	}
	
	
}
