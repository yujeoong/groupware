package com.eleven.prjManage.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.eleven.appr.dto.ApprDocDTO;
import com.eleven.prjManage.dao.PrjManageDAO;
import com.eleven.prjManage.dto.AuthorityDTO;
import com.eleven.prjManage.dto.ProjectDTO;



@Service
@MapperScan(value= {"com.eleven"})
public class PrjManageService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired PrjManageDAO dao;
	
	//프로젝트 등록
	public String regist(HashMap<String, String> params, AuthorityDTO authorityDTO) {
		String page = "redirect:/prjManage/projectRegist.move";
		ProjectDTO dto = new ProjectDTO();
		dto.setPrj_subject(params.get("prj_subject").toString());
		dto.setMem_id(params.get("mem_id").toString());
		dto.setPrj_content(params.get("prj_content").toString());
		dto.setPrj_start_date(params.get("prj_start_date").toString());
		dto.setPrj_end_date(params.get("prj_end_date").toString());
		
		int success = dao.regist(dto);
		int idx = dto.getPrj_idx();
		if(success>0) {			
			logger.info("등록완료~ idx:"+idx);
			
		//조회자 등록
		authRegist(idx, authorityDTO);
		
			page = "redirect:/prjManage/projectList.move";
		}
		
		return page;
	}

	//조회자 등록
	private void authRegist(int idx, AuthorityDTO authorityDTO) {
		
			for(AuthorityDTO auth : authorityDTO.getAuthorityDTOList()) {
				auth.setNum(idx);
				if(auth.getParti()==null) {
					auth.setParti("N");
				}
				dao.authRegist(auth);
			}
	}

	//프로젝트 수정페이지
	public ModelAndView editForm(String prj_idx, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		//수정불가시 이동페이지
		String page = "/prjManage/projectList";
		
		//프로젝트 디테일 조회
		ProjectDTO prjDetail = dao.prjDetail(prj_idx);

		
		logger.info("수정폼 로그인아이디:"+session.getAttribute("loginId"));
		logger.info("수정폼 생성자아이디:"+prjDetail.getMem_id());
		//작성자만 수정 가능
		String msg="";
		if(!session.getAttribute("loginId").equals(prjDetail.getMem_id())) {
			msg = "프로젝트 생성자만 수정 가능합니다.";
			mav.addObject("msg", msg);
		}else{
			page = "/prjManage/projectEdit";
			mav.addObject("project", prjDetail);			
		}
		
		mav.setViewName(page);
		
		return mav;
	}
	
	//프로젝트 수정
	public String edit(ProjectDTO dto, AuthorityDTO authorityDTO) {
		int success = dao.edit(dto);
		int prj_idx = dto.getPrj_idx();
		String page = "redirect:/prjManage/edit.move?prj_idx="+prj_idx;
		if(success>0) {
			if(dao.authDelete(prj_idx)>0) {
				authRegist(prj_idx, authorityDTO);
				logger.info("수정완료");
				page="redirect:/prjManage/projectList.move";
			}
		}
		return page;
	}
	
	
	//프로젝트 삭제
	public ModelAndView delete(String prj_idx) {
		ModelAndView mav = new ModelAndView("/prjManage/projectList");
		dao.delete(prj_idx);
		return mav;
	}

	
	//프로젝트 리스트
	public HashMap<String, Object> prjList(HttpServletRequest req, String loginId) {
		int page = Integer.parseInt(req.getParameter("page"));
		String searchInput = "";
		String listCat = req.getParameter("listCat");
		
		//검색어 있는 경우
		if(req.getParameter("searchInput") != null) {
			searchInput = req.getParameter("searchInput");
		}

		//page에 따른 offset
		int offset = (page-1)*10;

		//총 게시글 수************
		int totalCount = dao.prjTotalCount(listCat, loginId, searchInput);

		//총 페이지 수 = 총 게시글 수 / 페이지 당 보여줄 수 (나머지 있으면 +1)
		int totalPages = totalCount%10 >0 ? (totalCount/10)+1 : (totalCount/10);
		if(totalPages <1) {
			totalPages = 1;
		}
		
		//게시글 리스트
		ArrayList<ProjectDTO> dtoList =dao.prjList(listCat, loginId, offset, searchInput);
		
		for (ProjectDTO dto : dtoList) {
			int prj_idx = dto.getPrj_idx();
			String taskPercent = dao.taskPercent(prj_idx);
			dto.setTaskPercent(taskPercent);
		}
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("total", totalPages);
		result.put("list", dtoList);
		
		return result;
	}

	//사원 리스트
	public HashMap<String, Object> memList() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memList", dao.memList());
		map.put("depList", dao.depList());
		return map;
	}

	//참여자 리스트
	public ArrayList<AuthorityDTO> authList(String prj_idx) {
		return dao.authList(prj_idx);
	}


}
