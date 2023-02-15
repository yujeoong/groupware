package com.eleven.main.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;

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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eleven.admin.dto.DepartmentDTO;
import com.eleven.main.service.MainService;


@Controller
public class MainController {
	
	@Autowired MainService service;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@GetMapping(value="/{page}.move")
	public String pageMove(@PathVariable String page) {
		logger.info("page move: "+page);
		return page;
	}
	
	@GetMapping(value="{root}/{page}.move")
	public String pageMove(@PathVariable String root, @PathVariable String page) {
		logger.info("page move: {}/{}",root,page);
		return root+"/"+page;
	}
	
	@GetMapping(value="{root}/{sub}/{page}.move")
	public String pageMove(@PathVariable String root, @PathVariable String sub, @PathVariable String page) {
		logger.info("page move: {}/{}/{}",root,sub,page);
		return root+"/"+sub+"/"+page;
	}
	

	//소속 부서 리스트 이름 가져오기
	//사원 리스트 호출
	@GetMapping(value="/depList.ajax")
	@ResponseBody
	public ArrayList<DepartmentDTO> depList(HttpSession session) {
		logger.info("list 요청");
		String loginId = (String) session.getAttribute("loginId");
		//String loginId="2310002";
		return service.depList(loginId);
	}
	
	//파일 다운로드
	@GetMapping(value="/main/download.do")
	public ResponseEntity<Resource> download(String newName, String oriName){
//		String filePath = "C:/eleven_upload/"+newName;
		String filePath = "/usr/local/tomcat/webapps/upload/"+newName;
		Resource resource = new FileSystemResource(filePath);
		HttpHeaders header = new HttpHeaders();
		try {
			String encodeName = URLEncoder.encode(oriName, "UTF-8");
			header.add("Content-type", "application/octet-stream");
			header.add("Content-Disposition", "attachment;fileName=\""+encodeName+"\"");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
	}
	
}
