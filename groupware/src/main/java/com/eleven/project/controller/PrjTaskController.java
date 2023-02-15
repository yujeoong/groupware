package com.eleven.project.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.eleven.prjManage.dto.ProjectDTO;
import com.eleven.project.dto.ProjectPostDTO;
import com.eleven.project.service.PrjTaskService;

@Controller
public class PrjTaskController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired PrjTaskService service;
	
	
	//업무글 작성하기
	@PostMapping(value="/project/taskWrite.do")
	public String taskWrite(HttpSession session, Model model, ProjectPostDTO dto, MultipartFile[] multipartFiles, String prj_idx) {
		logger.info("업무 글쓰기 컨트롤러 접근");
		logger.info("task_subject : " + dto.getSubject());
		logger.info("task_content : " + dto.getContent());
		logger.info("mem_id : " + dto.getMem_id());
		logger.info("plan_start : " + dto.getPlan_start());
		logger.info("plan_end : " + dto.getPlan_end());
		logger.info("idx : " + dto.getPrj_idx());
		
		//담당자 아이디
		String chargeId = dto.getMem_id();
		logger.info("chargeId : " + chargeId);
		
		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId느느느는" + loginId);
		dto.setMem_id(loginId);
		
		
		
		service.taskWrite(multipartFiles,dto,prj_idx,chargeId);
		return "redirect:/project/projectTask.move?prj_idx="+prj_idx;
	}
	
	//업무글 리스트 불러오기
	@GetMapping(value="/project/taskList.ajax")
	@ResponseBody
	public HashMap<String, Object>taskList(String prj_idx, String prj_post_idx){
		logger.info("업무글 리스트 요청");
		logger.info("ajax prj_idx : " + prj_idx);
		HashMap<String, Object>map = new HashMap<String, Object>();
		return service.taskList(prj_idx);
	}
	
	//업무상태 준비중으로 바꾸기
	@GetMapping(value="/project/stateUpdate_task_ready.ajax")
	@ResponseBody
	public HashMap<String, Object>stateUpdate_task_ready(HttpSession session, String prj_post_idx){
		logger.info("업무상태 준비중으로 변경 요청");
		String loginId = (String) session.getAttribute("loginId");
		String name = (String) session.getAttribute("name");
		HashMap<String, Object>map = new HashMap<String, Object>();
		return service.stateUpdate_task_ready(prj_post_idx, loginId, name);
	}
	
	//업무상태 진행중으로 바꾸기
	@GetMapping(value="/project/stateUpdate_task_ing.ajax")
	@ResponseBody
	public HashMap<String, Object>stateUpdate_task_ing(HttpSession session, String prj_post_idx){
		logger.info("업무상태 진행중으로 변경 요청");
		String loginId = (String) session.getAttribute("loginId");
		String name = (String) session.getAttribute("name");
		HashMap<String, Object>map = new HashMap<String, Object>();
		return service.stateUpdate_task_ing(prj_post_idx, loginId,name);
	}
	
	//업무상태 완료로 바꾸기
	@GetMapping(value="/project/stateUpdate_task_fin.ajax")
	@ResponseBody
	public HashMap<String, Object>stateUpdate_task_fin(HttpSession session, String prj_post_idx){
		logger.info("업무상태 완료로 변경 요청");
		String loginId = (String) session.getAttribute("loginId");
		String name = (String) session.getAttribute("name");
		HashMap<String, Object>map = new HashMap<String, Object>();
		return service.stateUpdate_task_fin(prj_post_idx, loginId,name);
	}
	
	//업무글 수정하기
	@PostMapping(value="/project/taskUpdate.do")
	public String postUpdate(Model model, String subject, String content, String prj_idx, String post_prj_post_idx,
				String plan_start, String plan_end) {
		logger.info("업무글 수정 컨트롤러 접근");
		//logger.info("subject : " + dto.getSubject());
		//logger.info("content : " + dto.getContent());
		//logger.info("idx : " + dto.getPrj_idx());
		logger.info("prj_post_idx : " + post_prj_post_idx);

		service.taskUpdate(subject, content, post_prj_post_idx,plan_start,plan_end);
		return "redirect:/project/projectTask.move?prj_idx="+prj_idx;

	}
	
	
	
	
}
