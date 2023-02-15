package com.eleven.admin.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eleven.admin.dao.AdminFacDAO;
import com.eleven.admin.dto.AdminFacDTO;

@Service
@MapperScan(value={"com.eleven.admin.dao"})
public class AdminFacService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired AdminFacDAO dao;
	
	/*시설 리스트+페이지네이션*/
	public HashMap<String, Object> Faclist(int page,String option, String searchWhat) {
		int offset=(page-1)*10;
		int totalCount=dao.totalCount(option,searchWhat);
		logger.info("total count : "+ totalCount);
		
		int totalPages=totalCount/10;
		if(totalCount%10>0) {
			totalPages=(totalCount/10)+1;
		}
		
		logger.info("총 페이지 수 : "+ totalPages);
		logger.info("총 페이지 수 2: "+Math.ceil(totalCount/10));
		
		HashMap<String, Object> result=new HashMap<String, Object>();
		ArrayList<AdminFacDTO> list=dao.Faclist(offset,option,searchWhat);
		result.put("total",totalPages);
		result.put("page", page);
		result.put("list", list);		
		return result;
	}
	
	//시설등록
	public int facRegist(HashMap<String, String> params) {
		String nameFinder = params.get("facName");
		logger.info("facName : "+nameFinder);
		int nameTF = dao.facNameFind(nameFinder);
		int row = 0;
		if(nameTF == 0) {
			row = dao.facRegist(params);
		}
		return row;
	}
	
	//시설수정
	public int facUpdate(HashMap<String, String> params) {
		String nameFinder = params.get("facNewName");
		String oldName = params.get("facOldName");
		logger.info("facNewName : "+nameFinder);
		int nameTF = 1;
		if(!nameFinder.equals("")) { //이름을 바꿨다면
			nameTF = dao.facNameFind(nameFinder); //이름 중복검사
			logger.info("0이면 중복없음 nameTF : "+nameTF);
			}
		int row = 0;
		if(nameTF == 0 || nameFinder.equals("")) { //중복이 없거나, 이름이 수정하지 않았다면
			row = dao.facUpdate(params);	
			}else{
				String getName = dao.whatIsName(nameFinder);
				logger.info("일치??  getName:{}, oldName:{}",getName,oldName);
				if(getName.equals(oldName)) {
					logger.info("실행?");
					row = dao.facUpdate(params);
				}
			}
		return row;
	}

}
