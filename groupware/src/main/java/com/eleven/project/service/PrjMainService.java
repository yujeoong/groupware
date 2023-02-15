package com.eleven.project.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.eleven.project.dao.ProjectPostDAO;
import com.eleven.project.dto.PrjFileDTO;
import com.eleven.project.dto.ProjectPostDTO;

@Service
@MapperScan(value= {"com.eleven.project"})
public class PrjMainService {

	
	@Value("${file.location}") private String root;

	@Autowired ProjectPostDAO dao;
	
	Logger logger = LoggerFactory.getLogger(getClass());

	//프로젝트 참여자 리스트 가져오기
	public ArrayList<ProjectPostDTO> memList(String prj_idx) {
		logger.info("참여자 가져오기 서비스");
		return dao.memList(prj_idx);
	}
	
	//프로젝트명 가져오기
	public String subject(String prj_idx) {
		logger.info("프로젝트명 가져오기 서비스");
		return dao.subject(prj_idx);
	}
	
	//프로젝트 일반글 작성
	public void postWrite(MultipartFile[] multipartFiles, ProjectPostDTO dto) {
		int success = dao.postWrite(dto);
		int prj_post_idx = dto.getPrj_post_idx();
		
		//int authority = dao.authority(dto);
		
		logger.info("write success : {} ", prj_post_idx);
		logger.info("multipartFile size : " + multipartFiles.length);
		if(success>0 && !multipartFiles[0].isEmpty()) {
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
	
	//피드백 작성기간 확인
	public String dateCheck(String prj_idx) {
		logger.info("피드백 작성기간 확인 서비스");
		return dao.dateCheck(prj_idx);
	}
	
	//피드백 글 작성
	public void feedbackWrite(MultipartFile[] multipartFiles, ProjectPostDTO dto) {
		int success = dao.feedbackWrite(dto);
		int prj_post_idx = dto.getPrj_post_idx();
		logger.info("write success : {} ", prj_post_idx);
		logger.info("multipartFile size : " + multipartFiles.length);
		if(success>0 && !multipartFiles[0].isEmpty()) {
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
	
	//일반글 리스트 출력
	public HashMap<String, Object> postList(String prj_idx) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		//ArrayList<ProjectPostDTO> postNumList= dao.postNumList(prj_idx);
		//logger.info("postNumList : " + postNumList);
		
		result.put("post", dao.postList(prj_idx));
		logger.info("result : " + result);
		
		return result;
	}
	
	//일반&피드백글 수정 전 상세보기
	public HashMap<String, Object> postDetail(String prj_idx, String prj_post_idx) {
		return dao.postDetail(prj_idx, prj_post_idx);
	}

	//일반글 수정하기
	public void postUpdate(String subject, String content, String post_prj_post_idx) {
		dao.postUpdate(subject, content, post_prj_post_idx);
	}

	//피드백 글 리스트 출력
	public HashMap<String, Object> feedbackList(String prj_idx) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("post", dao.feedbackList(prj_idx));
		return result;
	}
	//피드백 글 수정 전 상세보기
	public HashMap<String, Object> feedbackDetail(String prj_idx, String prj_post_idx) {
		return dao.feedbackDetail(prj_idx, prj_post_idx);
	}


	
	//댓글 리스트 출력하기
	public HashMap<String, Object> postCommList(String prj_post_idx) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("commList", dao.commList(prj_post_idx));		
		return result;
	}
	//일반&피드백글 댓글 작성하기
	public int comtSubmit(String comment, String prj_post_idx, String loginId) {
		logger.info("댓글 작성하기 서비스");
		return dao.comtSubmit(comment,prj_post_idx,loginId);
	}

	//일반&피드백글 댓글 수정하기
	public int comtModify(String prj_com_idx, String comment) {
		logger.info("댓글 수정 서비스");
		return dao.comtUpdate(prj_com_idx,comment);
	}
	//일반&피드백글 댓글 삭제하기
	public int comDelete(String prj_com_idx) {
		logger.info("댓글 삭제 service");
		return dao.comDelete(prj_com_idx);
	}
	
	//피드백 수정하기
	public void feedbackUpdate(String subject, String content, String feedback_prj_post_idx) {
		dao.feedbackUpdate(subject, content, feedback_prj_post_idx);
	}


	public HashMap<String, Object> HomeList(String prj_idx) {
		HashMap<String, Object> result = new HashMap<String, Object>();

		result.put("post", dao.HomeList(prj_idx));
		logger.info("result : " + result);
		
		return result;
	}

	public int authority(ProjectPostDTO dto) {
		return dao.authority(dto);
	}

	//일반게시글 파일 리스트 불러오기
	public HashMap<String, Object> fileListCall(String prj_post_idx) {
		
		logger.info("파일리스트 서비스");
		
		ArrayList<PrjFileDTO> files = dao.fileList(prj_post_idx);
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("files", files);
		
		
		return result;
	}

	//파일리스트 이름 가져오기
	public String fileName(String path) {
		return dao.fileName(path);
	}

	//참여권한 확인 
	public String access(String prj_idx, String loginId) {
		logger.info("프로젝트 접근 확인 서비스");
		return dao.access(prj_idx,loginId);
	}


	

		
	
	
	
	
}
