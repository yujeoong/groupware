package com.eleven.project.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.eleven.project.service.PrjPollService;

@Controller
public class PrjPollController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired PrjPollService service;
	
	//투표글 작성하기
	@PostMapping(value="/project/pollWrite.do")
	public String pollWrite(HttpSession session, Model model,  HttpServletRequest req,
				@RequestParam HashMap<String,String> params,
				MultipartFile[] multipartFiles, int prj_idx) {
		String[] select = req.getParameterValues("ext[]");
		String loginId = (String) session.getAttribute("loginId");
		return service.pollWrite(multipartFiles,loginId, params, select, prj_idx);
	}
	
	
	//투표글 리스트 불러오기
	@GetMapping(value="/project/pollList.ajax")
	@ResponseBody
	public HashMap<String, Object>pollList(HttpSession session, String prj_idx, String prj_post_idx){
		String loginId= "";
		if(session.getAttribute("loginId") != null) {
			loginId = (String) session.getAttribute("loginId");
		}else {
			loginId= "noLogin";
		}
		
		logger.info("투표글 리스트 요청");
		logger.info("ajax prj_idx : " + prj_idx);
		HashMap<String, Object>map = new HashMap<String, Object>();
		return service.pollList(prj_idx, loginId);
		}
	
	//글번호 가져와서 투표창 그리기
	@GetMapping(value="/project/drawDoPoll.ajax")
	@ResponseBody
	public HashMap<String, Object>drawDoPoll(HttpSession session, String prj_idx, String prj_post_idx){
		String loginId = "";
		if(session.getAttribute("loginId") !=null) {
			loginId = (String) session.getAttribute("loginId");
		}else {
			loginId ="noLogin";
		}
		logger.info("투표창 만들기 요청 prj_post_idx :" + prj_post_idx);
		HashMap<String, Object>map = new HashMap<String, Object>();
		return service.drawDoPoll(prj_idx, loginId,prj_post_idx);
		
	}
	
	//투표하기
	@GetMapping(value="/project/doPoll.ajax")
	@ResponseBody
	public HashMap<String, Object>doPoll(HttpSession session, String sel_idx){
		
		String loginId = (String) session.getAttribute("loginId");
		
		logger.info("고른 선택지 idx :" + sel_idx);
		HashMap<String, Object>map = new HashMap<String, Object>();
		return service.doPoll(loginId,sel_idx);
		
	}
	
	//투표 취소하기
	@GetMapping(value="/project/cancelPoll.ajax")
	@ResponseBody
	public HashMap<String, Object>cancelPoll(HttpSession session, String prj_post_idx){
		
		String loginId = (String) session.getAttribute("loginId");
		
		logger.info("투표 취소 글번호 idx :" + prj_post_idx);
		HashMap<String, Object>map = new HashMap<String, Object>();
		return service.cancelPoll(loginId,prj_post_idx);
		
	}
	
	
	//선택지 투표멤버 불러오기
	@GetMapping(value="/project/pollMem.ajax")
	@ResponseBody
	public HashMap<String, Object>pollMem(String sel_idx){
		
		logger.info("투표멤버 리스트 요청 선택지 : " + sel_idx);
		return service.pollMem(sel_idx);
	}
	
	//투표글 상세보기 참여자수 체크
	@GetMapping(value="/project/pollDetail.ajax")
	@ResponseBody
	public HashMap<String, Object>pollDetail(String prj_post_idx){
		
		logger.info("투표 상세보기 요청 idx : " + prj_post_idx);
		return service.pollDetail(prj_post_idx);
	}

	
	@PostMapping(value= "/project/pollUpdate.do")
	public String pollUpdate(Model model, HttpServletRequest req, String prj_idx,
			String subject, String content, String poll_end, String anon, String poll_prj_post_idx) {
		
		String[] select = req.getParameterValues("ext[]");
		logger.info("selections{}: "+select);
		logger.info("수정할 투표글 idx : " + poll_prj_post_idx);
		return service.pollUpdate(prj_idx, poll_prj_post_idx, subject, content, poll_end, anon, select);
	}
	
	
}





