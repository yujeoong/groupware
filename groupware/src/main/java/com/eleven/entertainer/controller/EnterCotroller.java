package com.eleven.entertainer.controller;


import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.eleven.entertainer.service.EnterService;

@Controller
public class EnterCotroller {
	
	@Autowired EnterService service;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	// 엔터테이너 등록하기 페이지 이동
	@GetMapping(value="/entertainer/enterWriteForm.move")
	public ModelAndView enterWriteForm(){
		logger.info("엔터테이너 등록 페이지 요청");
		return service.enterWriteForm();
	}
	
	
	// 엔터테이너 등록(기본정보+계약+활동이력+파일)
	@PostMapping(value="/entertainer/enterRegist.do")
	public String enterRegist(MultipartFile[] files, HttpServletRequest req, MultipartFile photo, @RequestParam HashMap<String, String> params) {
		logger.info("params: {}",params);
		logger.info("files : {}",files.length);
		String[] start_date = req.getParameterValues("career_start_date[]");
		String[] end_date = req.getParameterValues("career_end_date[]");
		String[] content = req.getParameterValues("career_content[]");
//		logger.info("careers: {}",start_date[1]);
//		logger.info("careers: {}",end_date[1]);
//		logger.info("careers: {}",content[1]);
		return service.enterRegist(photo, files, params, start_date, end_date,content );	
	}
	
	// 아티스트 등록 경로
//	@GetMapping(value = "/artist/enterWriteForm.move")
//	public String artistWriteForm() {
//		return "/entertainer/enterWriteForm";
//	}
	
	// 연습생 리스트
	@GetMapping(value="/entertainer/enterList.move")
	public ModelAndView enterList() {
		logger.info("연습생 리스트");
		return service.enterList();
	}
	
	// 아티스트 리스트
	@GetMapping(value="/artist/artistList.move")
	public ModelAndView artistList() {
		logger.info("아티스트 리스트");
		return service.artistList();
	}

	//엔터테이너 수정페이지 이동
	@GetMapping(value="/entertainer/enterEdit.move")
	public ModelAndView enterEditForm(@RequestParam String ent_idx){
		logger.info(ent_idx+"번 엔터테이너 수정 요청");
		return service.enterEditForm(ent_idx);
	}
	
	// 아티스트 수정 페이지 등록 경로
//	@GetMapping(value = "/artist/enterEdit.move")
//	public String artistEditForm() {
//		return "/entertainer/enterEdit";
//	}
	
	
	
	//엔터테이너 수정하기
	@PostMapping(value="/entertainer/enterEdit.do")
	public String enterEdit(Model model,MultipartFile[] files, MultipartFile photo ,@RequestParam HashMap<String, String> params, HttpServletRequest req) {
		logger.info("params:{} ",params);
		String[] start_date = req.getParameterValues("career_start_date[]");
		String[] end_date = req.getParameterValues("career_end_date[]");
		String[] content = req.getParameterValues("career_content[]");
		return service.enterEdit(photo, files, params, start_date, end_date,content);
	}
	
	//엔터테이너 평가 등록 페이지 이동
	@GetMapping(value="/entertainer/enterTest.move")
	public ModelAndView enterTest(@RequestParam String ent_idx){
		logger.info(ent_idx+"번 엔터테이너 평가 등록 요청");
		return service.enterTestForm(ent_idx);
	}
	
	// 아티스트 평가 페이지 등록 경로
//	@GetMapping(value = "/artist/enterTest.move")
//	public String artistTestForm() {
//		return "/entertainer/enterTest";
//	}
	
	
	// 엔터테이너 평가등록
	@PostMapping(value="/entertainer/enterTestRegist.do")
	public String entertestRegist(@RequestParam HashMap<String, String> params) {
		logger.info("params:{} ",params);
		return service.enterTestRegist(params);
	}
	
	// 연습생 검색
	@PostMapping(value = "/entertainer/enterSearch.move")
	public ModelAndView enterSearch(@RequestParam HashMap<String, String> params) {
		logger.info("연습생 검색");
		return service.enterSearch(params);
	}
	
	// 아티스트 검색
	@PostMapping(value = "/artist/artSearch.move")
	public ModelAndView artSearch(@RequestParam HashMap<String, String> params) {
		logger.info("아티스트 검색");
		return service.artSearch(params);
	}
	
	// 연습생 상세보기
	@GetMapping(value="/entertainer/enterDetail.move")
	public ModelAndView enterDetail(@RequestParam String ent_idx) {
		logger.info("연습생 상세보기 요청");
		logger.info("detail ent_idx : "+ent_idx);
		return service.enterDetail(ent_idx);
	}
	
	// 아티스트 상세보기
//	@GetMapping(value="/artist/artistDetail.move")
//	public ModelAndView artistDetail(@RequestParam String ent_idx) throws IOException {
//		logger.info("아티스트 상세보기 요청");
//		logger.info("detail ent_idx : "+ent_idx);
//		
//		String url ="https://www.melon.com/album/detail.htm?albumId=10238683";
//		int page = 1;
//		Document doc= Jsoup.connect(url).data("page",String.valueOf(page)).get();
//		
//		return service.artistDetail(doc,ent_idx);
//	}/artist/artistGroup.move
	
	//그룹등록
	@PostMapping(value="/artist/artistGroup.do")
	public String artistGroup(String artg_name){
		logger.info("그룹등록" +artg_name);
		
		return service.artistGroup(artg_name);
	}
	
	//아티스트 상세보기
	@GetMapping(value="/artist/artistDetail.move")
	public ModelAndView artistDetail(@RequestParam String ent_idx) throws IOException {
		logger.info("아티스트 상세보기 요청");
		logger.info("detail ent_idx : "+ent_idx);
		
		return service.artistDetail(ent_idx);
	}


//	// 첨부파일 삭제
//	@ResponseBody
//	@RequestMapping(value = "/entertainer/delete.ajax")
//	public HashMap<String, Object> fileDelete(int file_idx){
//		logger.info("파일 삭제 요청 : {}",file_idx);
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		
//		int success=service.fileDelete(file_idx);
//		logger.info("delete success:{}",success);
//		map.put("success", success);
//		return map;
//	}
	
	
	//사원 리스트 호출
		@GetMapping(value="/entertainer/memList.ajax")
		@ResponseBody
		public HashMap<String, Object> memList() {
			logger.info("list 요청");
			return service.memList();
		}
	
        // 그룹이름 중복검사
        @ResponseBody
        @PostMapping(value = "/group/idCheck.ajax")
        public String idCheck(String idCheck) {
            logger.info("값: "+idCheck);
            return service.idCheck(idCheck);
        }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

