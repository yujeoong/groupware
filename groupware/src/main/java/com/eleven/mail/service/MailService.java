package com.eleven.mail.service;

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

import com.eleven.admin.dto.MemberDTO;
import com.eleven.appr.dto.ApprLineDTO;
import com.eleven.mail.dao.MailDAO;
import com.eleven.mail.dto.FileDTO;
import com.eleven.mail.dto.MailDTO;
import com.eleven.mail.dto.MailRcpDTO;

@Service
@MapperScan(value= {"com.eleven.mail"})
public class MailService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired MailDAO dao;
	@Value("${file.location}") private String root;
	


	//쪽지 작성
	public String regist(MultipartFile[] files, MailDTO dto, ArrayList<ApprLineDTO> rcpList) {
		
		int success = dao.registSender(dto); //Mail 테이블 insert (발신자, 제목, 내용) 
		String mail_idx = Integer.toString(dto.getMail_idx());
		logger.info("Mail insert 성공하면 111111 : "+success);
		logger.info("mail_idx : " +mail_idx);
		//logger.info("multipartFile 있으면 size : "+files.length);
		logger.info("title : "+dto.getTitle());
		logger.info("content : "+dto.getContent());
		logger.info("sender_id : "+dto.getSender_id());
		
		if(success > 0) {
			logger.info("수신자 입력 : "+success);
			if(rcpList !=null) {//새쪽지 작성
				for(int i=1; i<rcpList.size(); i++) {
					logger.info("리스트 값 : "+rcpList.get(i).getMem_id());
					String rcpId = rcpList.get(i).getMem_id();
					dao.rcpListRegist(mail_idx, rcpId);
				}
			}else {//답장 쪽지 작성
				String replyRcp = dto.getReceiver_id();
				logger.info("getReceiver_id : "+dto.getReceiver_id());
				dao.rcpListRegist(mail_idx, replyRcp); //한명만 등록
			}
			
			//파일
			if(files != null) {
				logger.info("파일 입력 : "+success);
				for(MultipartFile file : files) {
					try {
						fileUpload(file,mail_idx);
						Thread.sleep(1);
					}catch (Exception e) {
						e.printStackTrace();
						logger.info("파일 입력 실패");
					}
				}
			}
			
			
		}	
		return "redirect:/mail/detail.move?mail_idx="+mail_idx;
}		
		

	private void fileUpload(MultipartFile files, String mail_idx) {
	
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
			logger.info("파일 저장 완료 .... mail_idx : {} / oriFileName : {} / newFileName : {}", mail_idx, ori_file_name, new_file_name);
			dao.fileUpload(mail_idx, ori_file_name, new_file_name);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	

	
//쪽지함 리스트 불러오기	
	public HashMap<String, Object> list(int page, String sessionId, String cat, 
			String searchType, String searchInput) {
		logger.info("listCall - cat : "+cat);
		logger.info("listCall - searchType : "+searchType);
		logger.info("listCall - searchInput : "+searchInput);
		
		HashMap<String, Object>map = new HashMap<String, Object>();
		
		map = paging(page, sessionId, cat, searchType, searchInput); 
		logger.info("map :{}", map);
		
		map.put("sessionId",sessionId);
		map.put("cat", cat);
		map.put("searchType", searchType);
		map.put("searchInput", searchInput);
		logger.info("서비스에서 보내는 sessionId : "+sessionId);
		
		logger.info("map :{}", map);
		map.put("list", dao.list(map));
		return map;
	}


	
	
private HashMap<String, Object> paging(int page, String sessionId, String cat, 
			String searchType, String searchInput) {
	
		logger.info("페이징처리 요청");
		// page = 1 -> offset= 0부터 보여줘야함
		// page = 2 -> offset= 10부터 보여줘야함
		logger.info("page : "+page);
		int offset = (page-1)*10;
		logger.info("offset : {}", offset);
		
		// 총 페이지 수 = 게시물 총 갯수(=totalCount)/페이지당 보여줄 수
		int totalCount= dao.listTotal(sessionId, cat, searchType, searchInput);	// 저장된 데이터 갯수
		logger.info("totalCount : "+totalCount);
		
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



	
	//메일 상세보기 
	@Transactional
	public MailDTO detail(Model model, String mail_idx, String sessionId) {
		logger.info("mail detail");
		
		//첨부 파일 출력
		ArrayList<FileDTO> files = dao.fileList(mail_idx); 
		model.addAttribute("files", files);
		
		//읽음처리
		dao.state(mail_idx, sessionId); 
		
		//받는사람 리스트 출력 
		ArrayList<MailRcpDTO> rcp_list = dao.rcp_list(mail_idx);
		model.addAttribute("rcpList",rcp_list);
		
		//읽은사람 리스트 출력
		ArrayList<MailRcpDTO> read_list = dao.read_list(mail_idx);
		model.addAttribute("read_list", read_list);

		//안읽은 사람 리스트 출력
		ArrayList<MailRcpDTO> unread_list = dao.unread_list(mail_idx);
		model.addAttribute("unread_list", unread_list);

		
		return dao.contentDetail(mail_idx);
	}




	//답장 쓰기
	public MailDTO replyFormDetail(Model model, String mail_idx) {
		
		//받는사람 리스트 출력
		ArrayList<MailRcpDTO> rcp_list = dao.rcp_list(mail_idx);
		model.addAttribute("rcpList",rcp_list);
		
		return dao.contentDetail(mail_idx);
	}


	//답장 쓰기 (보낸사람을 받는사람으로)
	public MailDTO replyDetail(Model model, String mail_idx) {
		
		//답장시 받는사람 출력 (기존 보낸사람이 받는사람으로 들어감) 
		MailDTO replyRcp = dao.replyRcp(mail_idx);
		model.addAttribute("replyRcp", replyRcp);
		logger.info("senderId : "+replyRcp);
		
		return dao.contentDetail(mail_idx);
	}



	//받은 편지함에서 메일 삭제
	public int delete_mail(ArrayList<String> delList, String sessionId, String cat) {
		int total = 0;
		for(String rowNum: delList) {
			total += dao.delete_mail(rowNum, sessionId, cat);
		}
		logger.info("서비스에서 쪽지 총 지운 갯수 확인 : "+total);
		return total;
	}


	//읽음 처리
	public int read(ArrayList<String> chkList, String sessionId) {
		int total = 0;
		for(String rowNum : chkList) {
			total += dao.read(rowNum, sessionId);
		}
		logger.info("서비스에서 쪽지 총 읽은 갯수 확인 : "+total);
		return total;
	}




	
	




	
	
	
	
























	
	



}











