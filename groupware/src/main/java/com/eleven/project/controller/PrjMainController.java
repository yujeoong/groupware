package com.eleven.project.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

import com.eleven.project.dto.ProjectPostDTO;
import com.eleven.project.service.PrjMainService;


@Controller
public class PrjMainController {


	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired PrjMainService service;
	
	
	//프로젝트 참여자 리스트, 프로젝트 명 가져오기
	@GetMapping(value="{root}/project{page}.move")
	public String memList(@PathVariable String root,@PathVariable String page, HttpSession session, Model model, String prj_idx) {
		logger.info("프로젝트 참여자 리스트");
		ArrayList<ProjectPostDTO> list = service.memList(prj_idx);
		
		String subject = service.subject(prj_idx);
		String loginId = (String) session.getAttribute("loginId");
		
		ProjectPostDTO dto = new ProjectPostDTO();
		dto.setPrj_idx(Integer.parseInt(prj_idx));
		dto.setMem_id(loginId);
		
		
		//참여권한이 있는 아이디만 프로젝트 페이지 이동
		String access = service.access(prj_idx,loginId);
		
		if(access==null) {
			model.addAttribute("msg","프로젝트 조회 권한이 없습니다.");
			root= "prjManage";
			page="List";
		}
		
		
		
		
		int authority = service.authority(dto);
		
		if(authority>0) {
			model.addAttribute("authority", authority);
		}
		
		model.addAttribute("prj_idx", prj_idx);
		model.addAttribute("subject", subject);		
		model.addAttribute("list", list);
//		return "redirect:/projectHeader";
		//return root+"/projectHeader";
		return root+"/project"+page;
	}

	// 검색 페이지
	@PostMapping(value="/project/projectPostSearch.do")
	public String postSearch(Model model, String prj_idx, String keyword) {
		logger.info("안녕 prj_idx" + prj_idx);
		
		
		//String subject = service.subject(prj_idx);
		//model.addAttribute("subject", subject);
		//ArrayList<ProjectPostDTO> list = service.postSearch(keyword);
		
		return "redirect:/project/projectPostSearch.move?prj_idx="+prj_idx;
	}	
	
	//간트차트 페이지
	@GetMapping(value="/project/ganttChart.move")
	public String ganttChart(Model model, String prj_idx) {
		logger.info("간트차트 컨트롤러");
		String subject = service.subject(prj_idx);
		model.addAttribute("subject", subject);
		return "/project/ganttChart";
	}	
	
	//일반 글쓰기 
	@PostMapping(value="/project/postWrite.do")
	public String postWrite(HttpSession session, Model model, ProjectPostDTO dto, MultipartFile[] multipartFiles, String prj_idx) {
		logger.info("일반 글쓰기 컨트롤러 접근");
		logger.info("subject : " + dto.getSubject());
		logger.info("content : " + dto.getContent());
		logger.info("idx : " + dto.getPrj_idx());
		String loginId = (String) session.getAttribute("loginId");
		dto.setPrj_idx(Integer.parseInt(prj_idx));
		dto.setMem_id(loginId);
		service.postWrite(multipartFiles,dto);
		return "redirect:/project/projectPost.move?prj_idx="+prj_idx;
	}
	
	//일반 글 수정 
	@PostMapping(value="/project/postUpdate.do")
	public String postUpdate(Model model, String subject, String content, String prj_idx, String post_prj_post_idx) {
		logger.info("일반 수정ㅇㅇㅇ 컨트롤러 접근");
		//logger.info("subject : " + dto.getSubject());
		//logger.info("content : " + dto.getContent());
		//logger.info("idx : " + dto.getPrj_idx());
		logger.info("prj_post_idx : " + post_prj_post_idx);

		service.postUpdate(subject, content, post_prj_post_idx);
		return "redirect:/project/projectPost.move?prj_idx="+prj_idx;

	}
	
	//피드백 작성기간 확인
	@GetMapping(value="/project/dateCheck.ajax")
	@ResponseBody
	public boolean dateCheck(String prj_idx) throws ParseException {
		boolean check = false;
		String todayfm = new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis()));
		logger.info("현재날짜: " + todayfm);
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

		service.dateCheck(prj_idx);		
		
		Date date = new Date(dateFormat.parse(service.dateCheck(prj_idx)).getTime()); 
		Date today = new Date(dateFormat.parse(todayfm).getTime());
		
		int compare = date.compareTo(today);
		
		if(compare < 0) {
			logger.info("피드백 작성가능");
			check = true;
			}else {
				logger.info("피드백 작성 불가");
			}
		
		return check;
	}
	
	//피드백 글쓰기
	@PostMapping(value="/project/feedbackWrite.do")
	public String feedbackWrite(HttpSession session, Model model, ProjectPostDTO dto, MultipartFile[] multipartFiles, String prj_idx) {
		logger.info("피드백 글쓰기 컨트롤러 접근");
		logger.info("subject : " + dto.getSubject());
		logger.info("content : " + dto.getContent());
		logger.info("idx : " + dto.getPrj_idx());
		String loginId = (String) session.getAttribute("loginId");
		dto.setMem_id(loginId);
		service.feedbackWrite(multipartFiles,dto);
		return "redirect:/project/projectFeedback.move?prj_idx="+prj_idx;
	}
	
	
	//일반&피드백 글 리스트 불러오기
	@GetMapping(value="/project/postList.ajax")
	@ResponseBody
	public HashMap<String, Object>postList(String prj_idx, String loginId){
		logger.info("일반글 리스트 요청");
		logger.info("ajax prj_idx : " + prj_idx);
		HashMap<String, Object>map = new HashMap<String, Object>();
		return service.postList(prj_idx);
	}
	
	//일반&피드백글 댓글리스트 불러오기
	@GetMapping(value="/project/postCommList.ajax")
	@ResponseBody
	public HashMap<String, Object>postCommList(String prj_post_idx){
		logger.info("일반글 댓글 리스트 요청");
		HashMap<String, Object>map = new HashMap<String, Object>();
		return service.postCommList(prj_post_idx);
	}
	
	
//	//파일 가져오기
//	@GetMapping(value="/project/projectPostPhoto.do")
//	public ResponseEntity<Resource> showImage(String path) {
//		logger.info("photo name : " + path);
//		String filePath = "C:/upload/" + path;
//		
//		// 파일시스템으로 리소스를 읽어와 담는다.(리소스 바디)
//		Resource resource = new FileSystemResource(filePath);
//		
//		// 헤더(내가 보낼 컨텐트의 타입이 어떤 것이다.)
//		HttpHeaders header = new HttpHeaders();
//		try {
//			String type = Files.probeContentType(Paths.get(filePath)); //image/jpeg
//			logger.info("file type : " + type);
//			header.add("Content-type", type);
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		
//		return new ResponseEntity<Resource>(resource,header,HttpStatus.OK);
//	}	
	
	
	//일반글 수정 전 상세보기
	@GetMapping(value="/project/postDetail.ajax")
	@ResponseBody
	public HashMap<String, Object>postDetail(String prj_idx, String prj_post_idx){
		logger.info("일반 수정 내용 가져오기 요청");
		HashMap<String, Object>map = new HashMap<String, Object>();
		return service.postDetail(prj_idx,prj_post_idx);
	}	
	
	
	
	//피드백 글 리스트 불러오기
	@GetMapping(value="/project/feedbackList.ajax")
	@ResponseBody
	public HashMap<String, Object>feedbackList(String prj_idx, String prj_post_idx){
		logger.info("피드백 리스트 요청");
		logger.info("ajax prj_idx : " + prj_idx);
		HashMap<String, Object>map = new HashMap<String, Object>();
		return service.feedbackList(prj_idx);
	}
	
	
	//피드백 글 수정 전 상세보기
	@GetMapping(value="/project/feedbackDetail.ajax")
	@ResponseBody
	public HashMap<String, Object>feedbackDetail(String prj_idx, String prj_post_idx){
		logger.info("피드백 수정 내용 가져오기 요청");
		HashMap<String, Object>map = new HashMap<String, Object>();
		return service.feedbackDetail(prj_idx,prj_post_idx);
	}	
	


	//프로젝트 피드백 글 수정
	@PostMapping(value="/project/feedbackUpdate.do")
	public String feedbackUpdate(Model model, String subject, String content, String prj_idx, String feedback_prj_post_idx) {
		logger.info("피드백 수정ㅇㅇㅇ 컨트롤러 접근");
		//logger.info("subject : " + dto.getSubject());
		//logger.info("content : " + dto.getContent());
		//logger.info("idx : " + dto.getPrj_idx());
		logger.info("prj_post_idx : " + feedback_prj_post_idx);

		service.feedbackUpdate(subject, content, feedback_prj_post_idx);
		return "redirect:/project/projectFeedback.move?prj_idx="+prj_idx;

	}	
	
	
	//일반&피드백글 댓글 작성하기
	@RequestMapping(value="/project/comtSubmit.ajax")
	@ResponseBody
	public HashMap<String, Object> comtSubmit(HttpSession session, @RequestParam HashMap<String, String> params) {
		String comment = params.get("comment");
		String prj_post_idx = params.get("prj_post_idx");
		String loginId = (String) session.getAttribute("loginId");
		logger.info("댓글입력 아이디 : " + loginId);
		int row = service.comtSubmit(comment, prj_post_idx,loginId);
		//int row = service.comtSubmit(comment, loginId, postId);
	   
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", row);
	   
	   return map;
	}

	//일반&피드백글 댓글 수정하기
	@RequestMapping(value="/project/comtModify.ajax")
	@ResponseBody
	public HashMap<String, Object> comtModify(HttpSession session, @RequestParam HashMap<String, String> params) {
		String prj_com_idx = params.get("prj_com_idx");
		String comment = params.get("comment");
		logger.info("comment : " + comment);
		logger.info("댓글 수정 controller");
		//int row = service.comtUpdate(commentId,comment);
		int row = service.comtModify(prj_com_idx,comment);
	   
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", row);
		
	   return map;
	}
	
	
	//일반&피드백글 댓글 삭제하기
	@RequestMapping(value="/project/comDelete.ajax")
	@ResponseBody
	public HashMap<String, Object> comDelete(HttpSession session, @RequestParam HashMap<String, String> params) {
		String prj_com_idx = params.get("prj_com_idx");
		int row = service.comDelete(prj_com_idx);
	   
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", row);
	   
	   return map;
	}

	//홈 리스트 모든 글 가져오기
	@GetMapping(value="/project/HomeList.ajax")
	@ResponseBody
	public HashMap<String, Object>HomeList(String prj_idx){
		logger.info("모든 글 리스트 요청");
		logger.info("ajax prj_idx : " + prj_idx);
		HashMap<String, Object>map = new HashMap<String, Object>();
		return service.HomeList(prj_idx);
	}
	
	//일반게시글 파일리스트 가져오기
	@GetMapping(value="/project/fileListCall.ajax")
	@ResponseBody
	public HashMap<String, Object>fileListCall(String prj_post_idx){
		logger.info("파일리스트 요청");
		logger.info("ajax prj_post_idx : " + prj_post_idx);
		HashMap<String, Object>map = new HashMap<String, Object>();
		return service.fileListCall(prj_post_idx);
	}
	
	//파일 다운로드
	@GetMapping(value="/project/download.do")
	public ResponseEntity<Resource> download(String path) {
		logger.info("photo name : " + path);
		//String filePath = "C:/eleven_upload/" + path;
		String filePath = "/usr/local/tomcat/webapps/upload/" + path;
		String oriFileName = service.fileName(path); 
		
		Resource resource = new FileSystemResource(filePath);
		HttpHeaders header = new HttpHeaders();
		
		try {
			// 한글 파일명은 다운로드시 이름이 깨져서 저장된다. __.jpg
			// 한글 깨짐 방지가 필요하다. 
			String encodeName = URLEncoder.encode(oriFileName, "UTF-8");
			logger.info("encoded: " + encodeName);
			//image/... 은 이미지, text/... 은 문자열 , application/octet-stream 은 바이너리
			header.add("Content-type", "application/octet-stream");
			//content-Disposition 은 내려보낼 때 문자열인지(inline) 다운로드 받을 파일(attachment)인지 데이터 종류를 의미
			//fileName="과제.gif" 형태로 이름을 지정하지 않으면 다운로드가 되지 않는다.
			header.add("content-Disposition", "attachment;fileName=\""+encodeName+"\"");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource,header,HttpStatus.OK);
	}	
		
	
	
}
