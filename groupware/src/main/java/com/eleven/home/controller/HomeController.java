package com.eleven.home.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.eleven.home.dto.HomeDocDTO;
import com.eleven.home.dto.HomeTodoDTO;
import com.eleven.home.service.HomeService;

@Controller
public class HomeController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired HomeService homeService;
	
	@GetMapping(value = "/")
	public ModelAndView crawling(HttpSession session) throws IOException{
		logger.info("크롤링 요청..");
		
		ModelAndView mav = new ModelAndView(); 
	
		String page = "redirect:/login";
		if(session.getAttribute("loginId") != null) {			
			page="/home/home";
		}
		
		// 캘린더 
		Calendar today = Calendar.getInstance();
		int todayDate = today.get(Calendar.DATE); 	
		int days = homeService.calendar(); // 전체 일수 
		mav.addObject("days", days);
		mav.addObject("today", todayDate);
		
		// 음원차트 크롤링
		String chrart_url = "https://www.melon.com/chart/index.htm";
		ArrayList<HashMap<String, String>> list = homeService.chart(chrart_url);
		mav.addObject("list", list);
		
		// 주식 크롤링
		String finance_url = "https://finance.naver.com/item/main.naver?code=041510";
		//String finance_url = "https://www.google.com/finance/quote/352820:KRX?sa=X&ved=2ahUKEwicl9z95Mn8AhWRr1YBHZLJBGMQ_AUoAXoECAEQAw"; // 구글 금융
		HashMap<String, Object> finance = homeService.finance(finance_url);
		mav.addObject("finance", finance);
		
		mav.setViewName(page);
		return mav; 
	}
	
	
	// 리스트 호출
	@GetMapping(value="/home/list.ajax")
	@ResponseBody
	public HashMap<String, Object> todoList(HttpSession session) {
		logger.info("todo list 요청");
		
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		String loginId = (String) session.getAttribute("loginId");

		// todo 
		ArrayList<HomeTodoDTO> todoList = homeService.todoList(loginId);
		map.put("todoList", todoList);
		
		// 결재 문서 
		ArrayList<HomeDocDTO> appr_docList = homeService.appr_docList(loginId);
		map.put("appr_docList", appr_docList);
		map.put("lineCnt", appr_docList.size()); // 진행중인 결재 차수
		
		// 업무 리스트 
		ArrayList<HashMap<String, Object>> prj_taskList = homeService.prj_taskList(loginId);
		map.put("prj_taskList", prj_taskList); 
		
		
		//logger.info("map:{}", map);
		return map;
	}
	
	// 투두 등록 
	@GetMapping(value="/home/todoRegist.ajax")
	@ResponseBody
	public HashMap<String, Object> todoRegist(HttpSession session, String content) {
		logger.info("todo regist 요청	");
		
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		String loginId = (String) session.getAttribute("loginId");
		
		map.put("loginId", loginId);
		map.put("content", content);
		int success = homeService.todoRegist(map);
		map.clear();
		map.put("success", success);
		return map;
	}
	
	// 투두 수정 
	@GetMapping(value="/home/todoEdit.ajax")
	@ResponseBody
	public HashMap<String, Object> todoEdit(String content, String done, int idx) {
		logger.info("todo edit 요청 :{}", idx);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("content", content);
		map.put("done", done);
		map.put("idx", idx);
		int success = homeService.todoEdit(map);
		map.clear();
		map.put("success", success);
		return map;
	}
	
	// done 수정 /home/todoDoneEdit.ajax
	@GetMapping(value="/home/todoDoneEdit.ajax")
	@ResponseBody
	public HashMap<String, Object> todoDoneEdit(String done, int idx) {
		logger.info("todo edit 요청 :{}", done);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("done", done);
		map.put("idx", idx);
		int success = homeService.todoDoneEdit(map);
		map.clear();
		map.put("success", success);
		return map;
	}
	
	//투두 삭제 
	@GetMapping(value="/home/todoDelete.ajax")
	@ResponseBody
	public HashMap<String, Object> todoDelete(int todo_idx) {
		logger.info("todo delete 요청 :"+todo_idx);
		
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		int success = homeService.todoDelete(todo_idx);
		map.put("success", success);
		return map;
	}
	

}
