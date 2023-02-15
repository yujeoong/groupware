package com.eleven.post.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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

import com.eleven.post.dto.PostDTO;
import com.eleven.post.service.PostService;

@Controller
public class PostController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired PostService service;
	
	
	
	//부서게시판 페이지 이동
		@GetMapping(value="/post/postList{dep_idx}.move")
		public String depPost(@PathVariable String dep_idx){
			logger.info("이동한 게시판 (dep_idx) : "+dep_idx);
			return "/post/postList";
		}
		
		
	//공지사항 페이지 이동 
		@GetMapping(value="/noticeList.move") 
		public String noticeList (Model model) {
			model.addAttribute("dep_idx", "99");
			return "/post/postList";
		}
	
	
	
	//글 작성
	@PostMapping(value="/post/regist.do")
	public String regist(Model model, PostDTO dto, MultipartFile[] files, HttpServletRequest req) {
		String dep_idx = req.getParameter("dep_idx");
		logger.info("dep_idx : "+dep_idx);
		return service.regist(model, dto, files, dep_idx);
	}
	
	
	// 글 수정할 내용 불러오기
	@GetMapping(value="/post/editForm.move")
	public HashMap<String, Object> editForm(Model model, HttpSession session, @RequestParam String post_idx){
		logger.info("수정하려는 글 post_idx: "+post_idx);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("list",service.editForm(post_idx, model));		
		return map;
	}
	
	
	//글 수정
	@PostMapping(value="/post/edit.do")
	public String edit(Model model, HttpSession session, MultipartFile[] files, HttpServletRequest req,
			@RequestParam HashMap<String, String> params) {
		//String mem_id = (String) session.getAttribute("loginId");
		
		return service.edit(files, params);
	}
	
	
	//게시판 리스트 출력 (+부서번호)
	@GetMapping(value="/post/postList.ajax")
	@ResponseBody
	public HashMap<String, Object> postList(String dep_idx, int page, 
			String searchType, String searchInput, HttpServletRequest request){
		logger.info("로그인한 사람의 부서 번호 : "+dep_idx);
		logger.info("컨트롤러에서 page !??    "+page);
		if (dep_idx == null) {
			dep_idx = "99";
		}
		HttpSession session=request.getSession();
		String sessionId = (String) session.getAttribute("loginId");
		return service.postList(dep_idx, page, searchType, searchInput,sessionId);
	}	
	
	
	
	//상세보기
	@GetMapping(value="/post/detail.move")
	public String detail(Model model, @RequestParam String post_idx) {
		logger.info("mail_idx : "+post_idx);
		
		PostDTO postdto=service.detail(model, post_idx);
		
		if(postdto != null) {
			model.addAttribute("list", postdto);
		}
		return "/post/detail";
	}
	
	
	//파일 다운로드
	@GetMapping(value="/post/download.do")
	public ResponseEntity<Resource> download(String path){
		logger.info("file name : "+path);
//		String filePath = "C:/eleven_upload/"+path; 
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
	
	
	
	//글삭제
	@GetMapping(value="/post/delete.do")
	public String delete(@RequestParam String post_idx, @RequestParam String dep_idx) {
		return service.delete(post_idx, dep_idx);
	}
	
	
	
	
}
