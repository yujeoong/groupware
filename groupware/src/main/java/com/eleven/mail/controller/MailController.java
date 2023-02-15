package com.eleven.mail.controller;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.eleven.admin.dto.MemberDTO;
import com.eleven.appr.dto.ApprDocDTO;
import com.eleven.appr.dto.ApprLineDTO;
import com.eleven.mail.dto.MailDTO;
import com.eleven.mail.dto.MailRcpDTO;
import com.eleven.mail.service.MailService;

@Controller
public class MailController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired MailService service;
	
	
	//쪽지 작성으로 이동 (from project) 
	@GetMapping(value="/mail/writeForm.move?{mem_id}")
	public String depPost(@PathVariable String mem_id){
		logger.info("mem_id : "+mem_id);
		return "/mail/writeForm";
	}	
	
	
	//쪽지 작성
	@PostMapping(value="/mail/regist.do")
	public String Regist(Model model, MultipartFile[] files, MailDTO dto, 
			ApprDocDTO apprDoc, HttpServletRequest req) {
		//String[] receiver_id=req.getParameterValues("mem_id");
		logger.info("쪽지 작성 regist - 컨트롤러");
		
		ArrayList<ApprLineDTO> rcpList= apprDoc.getApprLineDTOList();
		if(rcpList != null) {//새쪽지 작성
			for(int i=1; i<rcpList.size(); i++) {
				logger.info("리스트 값 : "+rcpList.get(i).getMem_id());
			}
		}		
		
		return service.regist(files, dto, rcpList);
	}
	

	
	
	//쪽지함 리스트
	@RequestMapping(value="/mail/list.ajax")
	@ResponseBody
	public HashMap<String, Object> mailList(HttpServletRequest request, int page,
			String cat, String searchType, String searchInput){
		HttpSession session=request.getSession();
		String sessionId = (String) session.getAttribute("loginId");
		logger.info("ajax listCall 실행");
		return service.list(page, sessionId, cat, searchType, searchInput);
	}

	
	
	
	/*
	//보낸 쪽지함 리스트 - 마우스오버 
	@GetMapping(value="/mail/testSentList.ajax")
	@ResponseBody
	public HashMap<String, Object> testSentList(Model model, @RequestParam String mail_idx){
		return service.testSentList(model, mail_idx);
	}
	*/
	
	


	
	//상세보기 (mail테이블)
	@GetMapping(value="/mail/detail.move")
	public String detail(Model model, @RequestParam String mail_idx, HttpServletRequest request) {
		logger.info("mail_idx : "+mail_idx);
		
		HttpSession session=request.getSession();
		String sessionId = (String) session.getAttribute("loginId");
		
		MailDTO maildto=service.detail(model, mail_idx, sessionId);
		
		if(maildto != null) {
			model.addAttribute("list", maildto);
		}
		return "/mail/detail";
	}
	

	

	
	//파일 다운로드
	@GetMapping(value="/mail/download.do")
	public ResponseEntity<Resource> download(String path){
		logger.info("file name : "+path);
		//String filePath = "C:/eleven_upload/"+path; 
		String filePath = "/usr/local/tomcat/webapps/upload/"+path; 
		String ori_file_name = "download.jpg"; //실제로 이 oriFileName은 db file에서 가져와야한다.
														// 한글파일명은 깨진다. 
		
		Resource resource = new FileSystemResource(filePath);
		HttpHeaders header = new HttpHeaders();
		
		try {
			//한글 파일명은 다운로드시 이름이 깨져서 표현된다.
			//한글 깨짐 방지가 필요하다.
			String encodeName= URLEncoder.encode(ori_file_name, "UTF-8");
			logger.info("encoded : "+encodeName);
			   //image/(확장자) 는 이미지, 
			   //text/(확장자)는 문자열, 
			  //application/octet-stream은 바이너리
			header.add("Content-type", "application/octet-stream");
			//content-Disposition 은 내려보낼때 문자열(inline)인지 다운로드 받을 파일(attachment)인지 데이터 종류를 의미한다.
			//fileName="" 형태로 이름을 지정하지 않으면 다운로드가 되지 않는다. 
			header.add("content-Disposition", "attachment;fileName=\""+encodeName+"\"");			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource,header,HttpStatus.OK);
	}
	
	

	
	
	
	
	
	//답장 페이지로 이동
	@GetMapping(value="/mail/replyForm.move")
	public String updateForm(String mail_idx, Model model) {
		logger.info("replyForm - mail_idx : "+mail_idx);
		
		MailDTO dto = service.replyDetail(model, mail_idx);
		model.addAttribute("list",dto);
		
		return "/mail/replyForm";
	}
	

	
	//메일 삭제 (숨김) 
	@RequestMapping(value="/mail/delete.ajax")
	@ResponseBody
	public HashMap<String, Object> delete_mail(@RequestParam(value="delList[]") ArrayList<String> delList, 
			String cat ,HttpServletRequest request) {
		logger.info("delList : {}",delList);
		logger.info("컨트롤러 cat : "+cat);
		
		HttpSession session=request.getSession();
		String sessionId = (String) session.getAttribute("loginId");
		logger.info("컨트롤러 loginId : "+sessionId);
		
		int cnt = service.delete_mail(delList, sessionId, cat);
		
		String msg ="쪽지 ";
		msg += cnt+" 개를 삭제하였습니다.";
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("msg", msg);
		return map;
	}

	
	
	//메일 읽음
		@RequestMapping(value="/mail/read.ajax")
		@ResponseBody
		public HashMap<String, Object> read(@RequestParam(value="chkList[]") ArrayList<String> chkList, 
				HttpServletRequest request) {
			logger.info("delList : {}",chkList);
			
			HttpSession session=request.getSession();
			String sessionId = (String) session.getAttribute("loginId");
			logger.info("컨트롤러 loginId : "+sessionId);
			
			int cnt = service.read(chkList, sessionId);
			
			String msg ="쪽지 ";
			msg += cnt+" 개를 읽음으로 처리하였습니다.";
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("msg", msg);
			
			return map;
		}
	
	

}


