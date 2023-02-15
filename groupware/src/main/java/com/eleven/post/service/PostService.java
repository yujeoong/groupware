package com.eleven.post.service;

import java.io.File;
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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.eleven.mail.dto.FileDTO;
import com.eleven.post.dao.PostDAO;
import com.eleven.post.dto.PostDTO;

@Service
@MapperScan(value= {"com.eleven.post"})
public class PostService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired PostDAO dao;
	@Value("${file.location}") private String root;
	
	
	
	
	//글작성
	public String regist(Model model, PostDTO dto, MultipartFile[] files, String dep_idx) {
		dto.setDep_idx(dep_idx);
		logger.info("dep_idx : "+dep_idx);
		String page = "redirect:/";
		
		if(dto.getContent() != null) {
			int success = dao.regist(dto);
			logger.info("서비스 글 작성 성공 : "+success);
			
			String post_idx = dto.getPost_idx();
			logger.info("등록한 글의 post_idx : "+post_idx);

			if(success > 0) {
				//첨부파일
				for(MultipartFile file : files) {
					try {
						fileUpload(file, post_idx);
						Thread.sleep(1);
					}catch(Exception e) {
						e.printStackTrace();
					}
				}
			
			
				/*
				 * if(dep_idx != "99") { //공지사항이 아닐때, postList로 보낸다. page =
				 * "redirect:/post/postList"+dep_idx+".move"; }else { page =
				 * "redirect:/noticeList.move"; }
				 */
				
				page = "redirect:/post/detail.move?post_idx="+post_idx;
				
			}
			
		}

	
		return page;
	}



	private void fileUpload(MultipartFile files, String post_idx) {

		//파일명 추출
			String ori_file_name = files.getOriginalFilename();
			logger.info("oriFileName : "+ori_file_name);
			String ext= ori_file_name.substring(ori_file_name.lastIndexOf("."));
			
			//새 파일명 생성
			String new_file_name = System.currentTimeMillis()+ext;
			
			//파일 저장
			try {
				//uploadFile에서 바이트 추출
				byte[] arr = files.getBytes();
				Path path = Paths.get(root+new_file_name); //저장할 파일 위치 지정
				Files.write(path, arr); //파일 쓰기
				logger.info("파일 저장 완료 .... mail_idx : {} / oriFileName : {} / newFileName : {}", post_idx, ori_file_name, new_file_name);
				dao.fileUpload(post_idx, ori_file_name, new_file_name);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
	

	

	//수정할 글 불러오기
	public HashMap<String, Object> editForm(String post_idx, Model model) {
		ArrayList<FileDTO> files = dao.fileList(post_idx);
		model.addAttribute("files",files);
		
		
		return dao.editForm(post_idx);
	}



	

	//글 수정하기
	public String edit(MultipartFile[] files, HashMap<String, String> params) {
		int success = dao.edit(params);
		String post_idx = params.get("post_idx");
		logger.info("글수정 후 이동할 post_idx : "+post_idx);
		
		
		if(success > 0) {
			//첨부파일
			for(MultipartFile file : files) {
				try {
					fileUpload(file, post_idx);
					Thread.sleep(1);
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		
		}
		
		return "redirect:/post/detail.move?post_idx="+post_idx;
	}
	
	

	//게시판 리스트 출력
	public HashMap<String, Object> postList(String dep_idx, int page, 
			String searchType, String searchInput, String sessionId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map=paging(dep_idx,page,searchType, searchInput); 
		logger.info("map : {}", map);
		
		map.put("dep_idx", dep_idx);
		map.put("searchType", searchType);
		map.put("searchInput", searchInput);
		logger.info("service에서 보내는 dep_idx : "+dep_idx);
		
		logger.info("map : {}",map);
		map.put("list", dao.postList(map)); //dep_idx와 offset을 map에 넣어주기 
		return map;
	}
	
	
	
	
	//페이징 처리
	private HashMap<String, Object> paging(String dep_idx, int page, 
			String searchType, String searchInput) {
		
		logger.info("페이징 처리 요청");
		// page = 1 -> offset= 0부터 보여줘야함
		// page = 2 -> offset= 10부터 보여줘야함
		logger.info("page : "+page);
		int offset = (page-1)*10;
		logger.info("offset : {}", offset);
		
		// 총 페이지 수 = 게시물 총 갯수(=totalCount)/페이지당 보여줄 수
		int totalCount= dao.listTotal(dep_idx,searchType,searchInput);	// 저장된 데이터 갯수
		logger.info("totalCount : "+totalCount);
		logger.info("totalCount 셀때의 dep_idx : "+dep_idx );
		
		// 이 경우 나머지가 생기면 page+1
		int totalPages = totalCount%10 > 0 ? (totalCount/10)+1 : (totalCount/10);
		logger.info("총 페이지 수 : " + totalPages);
		logger.info("총 페이지 수2 : "+ Math.ceil(totalCount/10));
		
		//페이지네이션 0이면 jsp 오류생기므로 방지용
				if(totalPages < 1) {
					totalPages = 1;
				}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("offset", offset);
		map.put("total",totalPages);
		return map;
	}

	
	//글 상세보기
	@Transactional
	public PostDTO detail(Model model, String post_idx) {
		logger.info("post detail");

		ArrayList<FileDTO> files = dao.fileList(post_idx);
		model.addAttribute("files",files);
		
		dao.upHit(post_idx); //조회수
		
		return dao.detail(post_idx);
	}




	public String delete(String post_idx, String dep_idx) {
		String page ="";
		
		
		dao.comDelete(post_idx); //댓글 삭제
		int postDeleteDone = dao.postDelete(post_idx); 

			ArrayList<FileDTO> fileList = dao.fileList(post_idx); //삭제할 파일 리스트 불러오기

			if(postDeleteDone > 0 && fileList.size()>0) { //글 삭제 완료 하고, file이 있으면
				File file = null;
				for(FileDTO dto : fileList) {
//					file = new File("C:/eleven_upload"+dto.getNew_file_name());
					file = new File(root+dto.getNew_file_name());
					logger.info("삭제할 글에 있는 file들... {} ",file);
					
					if(file.exists()) {
						logger.info("file ?? {} ",file);
						int success = dao.fileDelete(file);
						logger.info("파일 삭제한 갯수 : "+success);
						//logger.info(dto.getNew_file_name()+" 파일 이름: "+file.delete());
					}
				}

			}
		
		if(dep_idx != "99") { //공지사항이 아닐때, postList로 보낸다. 
			page = "redirect:/post/postList"+dep_idx+".move";
		}else {
			page = "redirect:/noticeList.move";
		}
		
		return page;
	}








	
}










