package com.eleven.project.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.eleven.project.dao.ProjectPostDAO;
import com.eleven.project.dto.PollDTO;
import com.eleven.project.dto.ProjectPostDTO;
import com.eleven.project.dto.SelDTO;

@Service
@MapperScan(value= {"com.eleven.project"})
public class PrjPollService {

	@Value("${file.location}") private String root;
	
	@Autowired ProjectPostDAO dao;
	
	Logger logger = LoggerFactory.getLogger(getClass());

	//투표 글쓰기
	public String pollWrite(MultipartFile[] multipartFiles, String loginId, HashMap<String, String> params,
			String[] select, int prj_idx) {
		logger.info("투표 글쓰기 서비스 loginId: " + loginId);
		ProjectPostDTO projectPostdto = new ProjectPostDTO();
		projectPostdto.setSubject(params.get("subject"));
		projectPostdto.setContent(params.get("content"));
		projectPostdto.setMem_id(loginId);
		projectPostdto.setPrj_idx(prj_idx);
		
		//글 테이블에 데이터 넣기
		int success = dao.pollWrite(projectPostdto);
		//글번호 생성해서 가져오기
		int prj_post_idx = projectPostdto.getPrj_post_idx();
		logger.info("generated prj_post_idx : " + prj_post_idx);
		
		PollDTO pollDto = new PollDTO();
		pollDto.setPrj_post_idx(prj_post_idx);
		pollDto.setEnd_date(params.get("poll_end"));
		pollDto.setAnon(params.get("anon"));
		
		//투표테이블에 데이터 넣기
		int success2 = dao.pollState(pollDto);
		logger.info("투표테이블에 데이터 넣기 성공 여부 : " + success2);
		
		//선택지 넣기
		for(int i=0; i<select.length; i++) {
			logger.info("poll 테이블 입력 갯수 " + select.length);
			logger.info("poll 테이블 입력 서비스 " + select[i]);
			SelDTO selDto = new SelDTO();
			selDto.setPrj_post_idx(prj_post_idx);
			selDto.setSel_content(select[i]);
			dao.pollSel(selDto);
		}
		
		
		
		//파일 넣기
		if(success >0 && !multipartFiles[0].isEmpty()) {
			for (MultipartFile multipartFile : multipartFiles) {
				try {
					upload(multipartFile,prj_post_idx);
					Thread.sleep(1);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
		
		
		return "redirect:/project/projectPoll.move?prj_idx="+prj_idx;
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

		//투표글 리스트 불러오기
		public HashMap<String, Object> pollList(String prj_idx, String loginId) {
			HashMap<String, Object> result = new HashMap<String, Object>();
			//post 테이블에서 글 불러오기
			ArrayList<ProjectPostDTO> pollList = dao.pollList(prj_idx);
			result.put("poll", dao.pollList(prj_idx));
			
			//ArrayList<SelDTO> selList = dao.selList();
			//result.put("selList",  dao.selList());
			
			return result;
		}

		//투표창 만들기
		public HashMap<String, Object> drawDoPoll(String prj_idx, String loginId, String prj_post_idx) {
			HashMap<String, Object> poll = new HashMap<String, Object>();
			ArrayList<SelDTO> selList = dao.selList(prj_post_idx);
			poll.put("selList", selList);
			
			int totalCount = dao.totalCount(prj_post_idx);
			poll.put("totalCount", totalCount);
			
			String selected = dao.selected(prj_post_idx,loginId);
			poll.put("selected", selected);
			
//			if(loginId != "noLogin") {
//				String selectedPoll = dao.mySel(loginId);
//			}
			
			return poll;
		}



		//투표하기
		public HashMap<String, Object> doPoll(String loginId, String sel_idx) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			int success = dao.doPoll(loginId, sel_idx);
			map.put("success", success);
			return map;
		}



		//투표 취소하기
		public HashMap<String, Object> cancelPoll(String loginId, String prj_post_idx) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			int selIdx = dao.getSelIdx(loginId, prj_post_idx);
			PollDTO dto = new PollDTO();
			dto.setSel_idx(selIdx);
			logger.info("선택지 idx 는 : " + selIdx);
			int success = dao.cancelPoll(loginId, selIdx);
			
			map.put("success", success);
			return map;
		}




		public HashMap<String, Object> pollMem(String sel_idx) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			ArrayList<SelDTO> pollMemList = dao.pollMem(sel_idx);
			map.put("success", pollMemList);
			return map;
		}




		public HashMap<String, Object> pollDetail(String prj_post_idx) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			int totalCount = dao.totalCount(prj_post_idx);
			
			ArrayList<SelDTO> selList = dao.selList(prj_post_idx);
			map.put("selList", selList);
			
			logger.info("totalCount는 :" + totalCount);
			map.put("totalCount", totalCount);
			
			return map;
		}



		//투표 수정하기
		public String pollUpdate(String prj_idx, String poll_prj_post_idx, String subject, String content, String poll_end,
				String anon, String[] select) {
			int success1 = dao.poll_postUpdate(subject, content,poll_prj_post_idx);
			int success2 = dao.poll_stateUpdate(anon,poll_end,poll_prj_post_idx);
			logger.info("투표 업데이트 성공 여부 1 : " +success1);
			logger.info("투표 업데이트 성공 여부 2 : " +success2);
//			for (int i = 0; i < select.length; i++) {
//				logger.info("poll테이블입력 갯수 "+select.length);
//				logger.info("poll테이블입력 서비스 "+select[i]);
//				SelDTO seldto = new SelDTO();
//				seldto.setPrj_post_idx(Integer.parseInt(poll_prj_post_idx));
//				seldto.setSel_content(select[i]);
//				seldto.setOffset(i);
//				int success3= dao.sel_update(seldto);
//				logger.info("선택지 업데이트 성공 여부 : "  + success3);
//			}
			
			//선택지 지우기
			int deleteSel = dao.deleteSel(poll_prj_post_idx);
			
			//선택지 넣기
			for(int i=0; i<select.length; i++) {
				logger.info("poll 테이블 입력 갯수 " + select.length);
				logger.info("poll 테이블 입력 서비스 " + select[i]);
				SelDTO selDto = new SelDTO();
				selDto.setPrj_post_idx(Integer.parseInt(poll_prj_post_idx));
				selDto.setSel_content(select[i]);
				dao.pollSel(selDto);
			}			
			
			return "redirect:/project/projectPoll.move?prj_idx="+prj_idx;
		}
		
		
}

