package com.eleven.prjManage.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.eleven.prjManage.dto.AuthorityDTO;
import com.eleven.prjManage.dto.ProjectDTO;
import com.eleven.prjManage.service.PrjManageService;



@Controller
public class PrjManageController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired PrjManageService service;
	
	//프로젝트 페이지이동
	@GetMapping(value="/prjManage/{page}.move")
	public String registForm(@PathVariable String page) {
		return "prjManage/"+page;
	}

	//프로젝트 등록
	@PostMapping(value="/prjManage/regist.do")
	public String write(@RequestParam HashMap<String, String> params, AuthorityDTO authorityDTO){
		logger.info("값들~~~~~~~~~~~~~{}",params);
		return service.regist(params, authorityDTO);
	}
	
	
	//프로젝트 수정폼
	@GetMapping(value="/prjManage/projectEdit.move")
	public ModelAndView editForm(String prj_idx, HttpSession session) {
		logger.info(prj_idx+"번 글 수정 요청");

		return service.editForm(prj_idx, session);
	}
	
	//프로젝트 수정
	@PostMapping(value="/prjManage/edit.do")
	public String edit(ProjectDTO dto, AuthorityDTO authorityDTO) {
		return service.edit(dto, authorityDTO);
	}

	
	//프로젝트 삭제 -> 삭제는 사용 안함
	@GetMapping(value="/prjManage/delete.do")
	public ModelAndView delete(String prj_idx) {
		logger.info(prj_idx+"번 프로젝트 삭제 요청");
		return service.delete(prj_idx);
	}

	
	//사원 리스트 호출
	@GetMapping(value="/prjManage/memList.ajax")
	@ResponseBody
	public HashMap<String, Object> memList() {
		logger.info("list 요청");
		return service.memList();
	}

	//참여자 리스트 호출
	@GetMapping(value="/prjManage/authList.ajax")
	@ResponseBody
	public ArrayList<AuthorityDTO> authList(String prj_idx) {
		logger.info("authList 요청", prj_idx);
		return service.authList(prj_idx);
	}

	//참여중인 프로젝트 리스트 페이지 이동
	@GetMapping(value="/prjManage/myProjectList.move")
	public String myProjectList() {
		return "/prjManage/projectList";
	}
	
	//프로젝트 리스트 호출
	@PostMapping(value="/prjManage/list.ajax")
	@ResponseBody
	public HashMap<String, Object> prjList(HttpServletRequest req, HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		logger.info("list 요청:"+loginId);
		return service.prjList(req, loginId);
	}
}
