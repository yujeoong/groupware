package com.eleven.admin.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eleven.admin.dao.AdminMemberDAO;
import com.eleven.admin.dto.DepartmentDTO;
import com.eleven.admin.dto.DutyDTO;
import com.eleven.admin.dto.PosDTO;

@Service
@MapperScan(value = {"com.eleven.admin.dao"})
public class AdminDepService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired AdminMemberDAO dao;
	
	//부서 리스트
	public HashMap<String, Object> depList(String option) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<DepartmentDTO> list = dao.depList(option);
		logger.info("잘가져옴? : "+list.size());
		map.put("list",list);
		return map;
	}
	
	//직급 리스트
	public HashMap<String, Object> posList(String option) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<PosDTO> list = dao.posList(option);
		logger.info("잘가져옴? : "+list.size());
		map.put("list",list);
		return map;
	}
	
	//직책리스트
	public HashMap<String, Object> dutyList(String option) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<DutyDTO> list = dao.dutyList(option);
		logger.info("잘가져옴? : "+list.size());
		map.put("list",list);
		return map;
	}
	
	/*부서 직급 직책 등록*/
	public int depRegist(HashMap<String, String> params) {
		int nameTF = dao.depNameFind(params);
		logger.info("일치 이름 여부 : "+nameTF);
		int row = 0;
		if(nameTF == 0) {
			row = dao.depRegist(params);
		}
		return row;
	}
	
	/*부서 직급 직책 수정*/
	public int depUpdate(HashMap<String, String> params) {
		String nameFinder = params.get("name");
		//String oldName = params.get("oldName");
		int nameTF = 1;
		if(!nameFinder.equals("")) { //이름을 바꿨다면
			nameTF = dao.depNameFind(params); //이름 중복검사
			logger.info("0이면 중복없음 nameTF : "+nameTF);
			}
		int row = 0;
		if(nameTF == 0 || nameFinder.equals("")) { //중복이 없거나, 이름을 수정하지 않았다면
			String YorN = dao.activeFind(params); //예전 active가져오기
			
			//만약 YorN가 Y이고 params.get 이 N이라면
			if(YorN.equals("Y") && params.get("active").equals("N")) { 
				//member에서 해당하는 사람이 있는지 체크 = > 없다면 Update
				int inPerson = dao.checkPeople(params);
					if(inPerson>0) {
						row = 99;
					}else{
						row = dao.depUpdate(params);									
					}
			}else{
				row = dao.depUpdate(params);	
			}
		}
		return row;
	}


}
