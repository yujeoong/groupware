package com.eleven.project.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.HashMap;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.eleven.noti.dto.NotiDTO;
import com.eleven.project.dao.ProjectPostDAO;
import com.eleven.project.dto.ProjectPostDTO;

@Service
@MapperScan(value= {"com.eleven.project"})
public class PrjTaskService {

	
	@Value("${file.location}") private String root;

	@Autowired ProjectPostDAO dao;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	//업무글 작성하기
	public void taskWrite(MultipartFile[] multipartFiles, ProjectPostDTO dto, String prj_idx, String chargeId) {
		
		//게시글테이블
		int success1 = dao.taskWrite(dto);
		int prj_post_idx = dto.getPrj_post_idx();
		String plan_start = dto.getPlan_start();
		String plan_end = dto.getPlan_end();
		//로그인 아이디
		String mem_id = dto.getMem_id();
		logger.info("서비스 logger : " + plan_start + plan_end + mem_id);
		
		//업무테이블
		int success = dao.taskStateWrite(prj_post_idx, plan_start,plan_end, chargeId);

		if(!mem_id.equals(chargeId)) {
			NotiDTO noti = new NotiDTO();
			noti.setContent("새로운 담당 업무가 등록되었습니다.");
			noti.setMem_id(chargeId);
			int sendSuccess = dao.sendNoti(noti);
			logger.info("알림 sendSuccess : " + sendSuccess);

			String noti_idx = noti.getNoti_idx();
			int rcpSuccess = dao.sendNoti_rcp(noti_idx, mem_id);
			logger.info("알림 rcpSuccess : " + rcpSuccess);

		}
		
		
		
		logger.info("write success : {} ", prj_post_idx);
		logger.info("multipartFile size : " + multipartFiles.length);
		if(success1 >0 && !multipartFiles[0].isEmpty()) {
			for (MultipartFile multipartFile : multipartFiles) {
				try {
					upload(multipartFile,prj_post_idx);
					Thread.sleep(1);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	//파일 업로드
	public void upload(MultipartFile multipartFile, int prj_post_idx) {
		
		//1. 파일명 추출
		String ori_File_Name= multipartFile.getOriginalFilename();
		logger.info("ori_File_Name : " + ori_File_Name);
		String ext = ori_File_Name.substring(ori_File_Name.lastIndexOf("."));
		
		//2. 새 파일명 생성
		String new_file_name= System.currentTimeMillis()+ext;
		
		try {
			// 파일 저장
			// uploadFile 에서 바이트 추출
			byte[] arr= multipartFile.getBytes();
			// 저장할 파일 위치 지정
			Path path = Paths.get(root+new_file_name);
			// 파일 쓰기
			Files.write(path, arr);
			dao.fileWrite(prj_post_idx,ori_File_Name,new_file_name);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}	

	//업무글 리스트 불러오기
	public HashMap<String, Object> taskList(String prj_idx) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("task", dao.taskList(prj_idx));
		return result;
	}

	//업무상태 준비중으로 바꾸기
	public HashMap<String, Object> stateUpdate_task_ready(String prj_post_idx, String loginId, String name) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("commSuccess", dao.readyCommRegit(loginId,prj_post_idx,name));
		result.put("success", dao.stateUpdate_task_ready(prj_post_idx));
		return result;
	}
	
	//업무상태 진행중으로 바꾸기
	public HashMap<String, Object> stateUpdate_task_ing(String prj_post_idx, String loginId, String name) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("commSuccess", dao.ingCommRegit(loginId,prj_post_idx,name));
		result.put("success", dao.stateUpdate_task_ing(prj_post_idx));
		return result;
	}

	//업무상태 완료로 바꾸기
	public HashMap<String, Object> stateUpdate_task_fin(String prj_post_idx, String loginId, String name) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("commSuccess", dao.finCommRegit(loginId,prj_post_idx,name));
		result.put("success", dao.stateUpdate_task_fin(prj_post_idx));
		return result;
	}

	//업무글 수정하기
	public void taskUpdate(String subject, String content, String post_prj_post_idx, String plan_start, String plan_end) {
		dao.tastDateUpdate(plan_start,plan_end,post_prj_post_idx);
		dao.taskUpdate(subject, content, post_prj_post_idx);
		
	}

}
