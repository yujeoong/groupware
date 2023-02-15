package com.eleven.appr.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.eleven.admin.dto.FileDTO;
import com.eleven.appr.dao.ApprDAO;
import com.eleven.appr.dto.ApprDocDTO;
import com.eleven.appr.dto.ApprLineDTO;
import com.eleven.appr.dto.DocFormDTO;
import com.eleven.noti.service.NotiService;

@Service
@MapperScan(value = { "com.eleven" })
public class ApprService {

	@Value("${file.location}") private String root;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	ApprDAO dao;
	@Autowired
	NotiService notiService;

	// 결재양식 등록
	public ModelAndView formRegist(DocFormDTO dto) {
		ModelAndView mav = new ModelAndView();
		String page = "/appr/docForm";
		logger.info("양식등록요청service");
		if (dto.getContent() != null) {
			int success = dao.formRegist(dto);
			logger.info("글 등록 성공?: " + success);
			page = "redirect:/appr/docFormList.move";
		} else {
			String msg = "전송 용량 초과." + "1MB 미만의 이미지를 사용하세요.";
			mav.addObject("msg", msg);
		}
		mav.setViewName(page);

		return mav;
	}
	

	//결재양식 삭제
	public String formDelete(String form_idx) {
		String msg = "삭제에 실패했습니다.";
		if(dao.formDelete(form_idx)>0) {
			msg = "삭제 완료";
		}
		return msg;
	}


	// 결재양식 리스트 호출
	public HashMap<String, Object> formList(HttpServletRequest req) {
		
		int page = Integer.parseInt(req.getParameter("page"));
		String searchInput = "";
		
		//검색어 있는 경우
		if(req.getParameter("searchInput") != null) {
			searchInput = req.getParameter("searchInput");
		}

		//page에 따른 offset
		int offset = (page-1)*10;

		//총 게시글 수
		int totalCount = dao.docFormTotalCount(searchInput);

		//총 페이지 수 = 총 게시글 수 / 페이지 당 보여줄 수 (나머지 있으면 +1)
		int totalPages = totalCount%10 >0 ? (totalCount/10)+1 : (totalCount/10);
		if(totalPages <1) {
			totalPages = 1;
		}
		
		//게시글 리스트
		ArrayList<DocFormDTO> list = dao.formList(offset, searchInput);
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("total", totalPages);
		result.put("list", list);
		
		return result;
	}


	// 결재양식 호출
	public DocFormDTO apprForm(String form_idx) {
		return dao.apprForm(form_idx);
	}

	// 기안문서 등록
	public ModelAndView apprRegist(MultipartFile[] files, ApprDocDTO apprDoc) {
		ModelAndView mav = new ModelAndView();
		//등록 실패시 양식리스트로 돌아감
		String page = "/appr/docFormList";
		
		//기안문서 등록
		int success = dao.apprRegist(apprDoc);
		String doc_idx = apprDoc.getDoc_idx();
		if (success > 0) {
			logger.info("등록완료~ idx:" + doc_idx);
			//결재라인 등록
			apprLineRegist(doc_idx, apprDoc.getApprLineDTOList());
			
			//상신결재함>결재진행중 문서로 이동
			page = "redirect:/apprSent/apprDetail.move?doc_idx="+doc_idx;
			
			//파일 있으면 등록
			if(!files[0].isEmpty()) {
				for(MultipartFile file : files) {
					fileUpload(file,doc_idx);
					//page="redirect:/detail.do?idx="+doc_idx;
					try {
						Thread.sleep(1);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
			
		}else {
			mav.addObject("msg", "전송 용량 초과. 1MB 미만의 이미지를 사용하세요.");
		}
		
		mav.setViewName(page);
		return mav;
	}
	
	
	//파일 업로드
	public void fileUpload(MultipartFile uploadFile, String doc_idx) {
		String oriFileName = uploadFile.getOriginalFilename();
		String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
		
		String newFileName = System.currentTimeMillis()+ext;
		
		try {
			byte[] arr = uploadFile.getBytes();
			Path path = Paths.get(root+newFileName);
			Files.write(path, arr);
			dao.fileWrite(oriFileName,newFileName,doc_idx);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 결재라인 등록
	public void apprLineRegist(String doc_idx, ArrayList<ApprLineDTO> apprLineList) {
		for (ApprLineDTO apprLine : apprLineList) {
			apprLine.setDoc_idx(doc_idx);
			dao.apprLineRegist(apprLine);
		}
		// 첫번째: 기안문서 작성자 결재완료, 두번째: 상태 결재중
		dao.apprLineFirst(doc_idx);
		dao.apprLineSecond(doc_idx);

		// 다음 결재자(두번쨰)에게 알림
		notiService.sendNotiSingle("[기안문서 "+doc_idx+"] 결재문서가 도착했습니다.", apprLineList.get(0).getMem_id(), apprLineList.get(1).getMem_id());
	}

	// 기안문서 리스트 호출
	public HashMap<String, Object> apprList(HttpServletRequest req, String loginId) {

		int page = Integer.parseInt(req.getParameter("page"));
		String searchInput = "";
		String subCat = req.getParameter("subCat");
		
		//검색어 있는 경우
		if(req.getParameter("searchInput") != null) {
			searchInput = req.getParameter("searchInput");
		}

		//page에 따른 offset
		int offset = (page-1)*10;

		//총 게시글 수************
		int totalCount = dao.apprTotalCount(subCat, loginId, searchInput);

		//총 페이지 수 = 총 게시글 수 / 페이지 당 보여줄 수 (나머지 있으면 +1)
		int totalPages = totalCount%10 >0 ? (totalCount/10)+1 : (totalCount/10);
		if(totalPages <1) {
			totalPages = 1;
		}
		//게시글 리스트**********
		ArrayList<ApprDocDTO> list = dao.apprList(subCat, loginId, offset, searchInput);
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("total", totalPages);
		result.put("list", list);
		
		return result;
	}

	//결재문서 상세보기
	public HashMap<String, Object> apprDetail(String doc_idx) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ApprDocDTO apprDoc = dao.apprDetail(doc_idx);
		map.put("apprDoc", apprDoc);
		
		ArrayList<ApprLineDTO> apprLineList = dao.apprLine(doc_idx);
		map.put("apprLineList", apprLineList);

		ArrayList<FileDTO> fileList = dao.fileList(doc_idx);
		map.put("fileList", fileList);
		return map;

	}

	//결재 or 반려하기
	public void apprSign(HashMap<String, String> params) {
		// 문서상태: 결재or반려
		String appr_state = params.get("appr_state");
		// 결재순서
		int appr_order = 0;
		// 기안문서 번호
		String doc_idx = params.get("doc_idx");
		
		// 결재라인
		ArrayList<ApprLineDTO> apprLineList = new ArrayList<ApprLineDTO>();
		ArrayList<String> notiRcp = new ArrayList<String>();	//알림수신자리스트
		apprLineList = dao.apprLine(doc_idx);
		for (int i = 0; i < apprLineList.size(); i++) {
			notiRcp.add(apprLineList.get(i).getMem_id());
			if(apprLineList.get(i).getState().equals("1")) {
				appr_order = i;
				break;
			}
		}
		int total_order = apprLineList.size();
		
		// 결재라인 상태 변경
		dao.apprLineState(doc_idx, appr_order, appr_state);

		//결재
		if (appr_state.equals("2")) {
			//최종결재
			if(appr_order + 1 == total_order ) {
				//사용한 문서양식 사용수+1
				String form_idx = params.get("form_idx");
				dao.formUpHit(form_idx);
				//기안자에게 알림
				notiService.sendNotiSingle("[기안문서 "+doc_idx+"] 결재가 최종 완료되었습니다.", apprLineList.get(appr_order).getMem_id(),apprLineList.get(0).getMem_id());
				
				
				//공개가 Y면 해당사원의 소속부서 부서게시판에 등록
				if(params.get("open").equals("Y")) {
					dao.apprToPost(doc_idx);
				}
			}else {
				params.put("appr_state", "1");
				//중간결재완료: 기안자에게 알림
				notiService.sendNotiSingle("[기안문서 "+doc_idx+"] 결재가 완료되었습니다.["+appr_order+"/"+total_order+"]", apprLineList.get(appr_order).getMem_id(),apprLineList.get(0).getMem_id());
				
				//다음결재자 상태변경(결재중으로) 및 알림
				dao.apprLineState(doc_idx, appr_order+1, "1");
				notiService.sendNotiSingle("[기안문서 "+doc_idx+"] 결재문서가 도착했습니다.", apprLineList.get(0).getMem_id(), apprLineList.get(appr_order+1).getMem_id());
			}
			
		//반려
		}else if(appr_state.equals("3")) {
			//이전결재자 모두에게 알림
			notiService.sendNoti("[기안문서 "+doc_idx+"] 기안문서가 반려되었습니다.", apprLineList.get(appr_order).getMem_id(),notiRcp);
		}
		
		//결재문서 상태 변경(중간결재일 경우 1로 다시설정하기 때문에 맨 마지막에 있어야 함)				
		dao.apprDocState(params);
	}

}
