package com.eleven.appr.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.eleven.appr.dto.ApprDocDTO;
import com.eleven.appr.dto.DocFormDTO;
import com.eleven.appr.service.ApprService;

@Controller
public class ApprController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ApprService service;

	
	//결재양식 리스트 호출(페이징,검색)
	@PostMapping(value="/appr/formList.ajax")
	@ResponseBody
	public HashMap<String, Object> formList(HttpServletRequest req) {
		logger.info("list 요청");
		logger.info("list"+req.getParameter("page"));
		return service.formList(req);
	}
	
	//결재양식 생성 등록
	@PostMapping(value="/appr/formRegist.do")
	public ModelAndView formRegist(DocFormDTO dto) {
		logger.info("subject: "+dto.getSubject());
		logger.info("content: "+dto.getContent());
		// maxPostSize 미설정시 2MB 이상의 요청이 온 항목은 null로 전송된다.
		//logger.info("content: "+dto.getContent().length());
		return service.formRegist(dto);
	}
		
	//결재양식 삭제
	@GetMapping(value="/appr/formDelete.do")
	public String formDelete(String form_idx, Model model) {
		String msg = service.formDelete(form_idx);
		model.addAttribute("msg", msg);
		return "/appr/docFormList";
	}
	
	//결재양식 호출
	@GetMapping(value="/appr/apprRegist.move")
	public String apprForm(String form_idx, Model model) {
		DocFormDTO form = service.apprForm(form_idx);
		model.addAttribute("form", form);
		return "/appr/apprRegist";
	}
	
	//기안문서 등록
	@PostMapping(value="/appr/apprRegist.do")
	public ModelAndView apprRegist(MultipartFile[] files, ApprDocDTO apprDoc) {
		logger.info("기안문서 등록~~~~~~controller");
		//결재라인 1번째를 기안문서 작성자로 등록
		apprDoc.setMem_id(apprDoc.getApprLineDTOList().get(0).getMem_id());
		return service.apprRegist(files, apprDoc);
	}
	
	//결재문서 리스트 페이지이동
	@GetMapping(value={"/apprInbox/{subCat}.move", "/apprSent/{subCat}.move"})
	public String apprInMove(){
		return "/appr/apprList";
	}
	
	//결재문서 리스트 호출
	@PostMapping(value="/appr/apprList.ajax")
	@ResponseBody
	public HashMap<String, Object> apprList(HttpServletRequest req, HttpSession session) {
		logger.info("list결재문서리스트"+req.getParameter("page"));
		String loginId = (String) session.getAttribute("loginId");
		return service.apprList(req, loginId);
	}

	//결재문서 상세보기 페이지 이동
	@GetMapping(value="/{mainCat}/apprDetail.move")
	public String pageMove(@PathVariable String mainCat, String doc_idx) {
		logger.info("상세보기 page move: {}/{}/{}",mainCat,doc_idx);
		return "/appr/apprDetail";
	}
	
	//기안문서 상세보기 호출
	@GetMapping(value="/appr/apprDetail.ajax")
	@ResponseBody
	public HashMap<String, Object> apprDetail(String doc_idx) {
		logger.info("detail 요청~~~~~"+doc_idx);
		return service.apprDetail(doc_idx);
	}
	
	//결재하기
	@PostMapping(value="/appr/sign.do")
	public String apprSign(@RequestParam HashMap<String, String> params) {
		
		logger.info("싸인ㅋㅋ {}",params);
		service.apprSign(params);
		return "redirect:/apprInbox/apprDone.move";
	}
}