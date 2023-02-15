package com.eleven.adminMem.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.eleven.admin.dto.MemberListDTO;
import com.eleven.adminMem.dao.MemDetailDAO;
import com.eleven.adminMem.dto.MemAuthDTO;
import com.eleven.adminMem.dto.MemCareerDTO;
import com.eleven.adminMem.dto.MemChangeDTO;
import com.eleven.adminMem.dto.MemFileDTO;
import com.eleven.adminMem.dto.MemStateDTO;

@Service
@MapperScan(value={ "com.eleven.adminMem" })
public class MemDetailService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MemDetailDAO dao; 
	
	// 이력 조회
	public ArrayList<MemCareerDTO> careerList(String mem_id) { 
		return dao.careerList(mem_id);
	}

	// 이력 등록 
	public int careerRegist(HashMap<String, String> params) { 
		return dao.careerRegist(params);
	}

	// 이력 삭제 
	public int careerDelete(int car_idx) { 
		return dao.careerDelete(car_idx);
	}

	// 부서,직급,직책 변경 로그 
	public ArrayList<MemChangeDTO> changeList(String mem_id) { 
		return dao.changeList(mem_id);
	}

	// 상태 변경 로그 
	public ArrayList<MemStateDTO> stateList(String mem_id) { 
		return dao.stateList(mem_id);
	}

	// 조회권한 수 
	public ArrayList<String> authCnt(String mem_id) { 
		return dao.authCnt(mem_id);
	}

	// 조회권한 리스트 
	public ArrayList<MemAuthDTO> authList(String mem_id) { 
		return dao.authList(mem_id);
	}
	
	// 소분류 리스트
	public ArrayList<MemAuthDTO> cateList(String category) { 
		return dao.cateList(category);
	}

	// 조회권한 등록
	public int authRegist(HashMap<String, Object> params) { 
		
		return dao.authRegist(params);
	}

	// 조회 권한 삭제 
	public int authDelete(HashMap<String, Object> map) { 
		return dao.authDelete(map);
	}

	// 사원상세보기 -마이페이지 
	public ModelAndView memDetail(String mem_id) { 
		int cate = 6; //프로필
		int checkFile = 0; //파일 존재 여부 확인
		HashMap<String, Object> member = dao.memDetail(mem_id);

		ModelAndView mav = new ModelAndView("/member/mem_detail");
		mav.addObject("member",member);
		mav.addObject("mem_id",mem_id); // 지원추가 

			//프로필 사진 조회
			checkFile = dao.picFileChk(mem_id, cate);
			if(checkFile > 0) {
				MemFileDTO profile = dao.picFile(mem_id,cate);
				mav.addObject("profile", profile);
			}

			//서명이미지 있는지 확인
			checkFile = 0;
			checkFile = dao.picFileChk(mem_id,cate);
			if(checkFile > 0) {
				cate = 7;
				MemFileDTO sign = dao.picFile(mem_id,cate);
				mav.addObject("sign",sign);			
			}

		return mav;
	}

	// 사원 리스트 - 관리자 권한 관리 
	public HashMap<String, Object> authMemList(int page, String searchWhat, String searchOption, String depOption,
			String posOption, String dutyOption) {
		String idCheck = ""; // 아이디중복체크랑 차이를 둠

		int offset=(page-1)*10;
		int totalCount=dao.totalCount(idCheck,searchWhat,searchOption,depOption,posOption,dutyOption);
		logger.info("total count : "+ totalCount);

		int totalPages=totalCount/10;
		if(totalCount%10>0) {
			totalPages=(totalCount/10)+1;
		}

		logger.info("총 페이지 수 : "+ totalPages);
		logger.info("총 페이지 수 2: "+Math.ceil(totalCount/10));
		
		//페이지네이션 0이면 jsp 오류생기므로 방지용
		if(totalPages < 1) {
			totalPages = 1;
		}

		HashMap<String, Object> result=new HashMap<String, Object>();
		ArrayList<MemberListDTO> list=dao.memList(offset,searchWhat,searchOption,depOption,posOption,dutyOption);
		result.put("total",totalPages);
		result.put("list", list);		
		result.put("page", page);		
		return result;
	}

	// 사원 관리자 권한 수정  
	public int memAuthUpdate(HashMap<String, Object> map) {
		 
		return dao.memAuthUpdate(map);
	}

	

}
