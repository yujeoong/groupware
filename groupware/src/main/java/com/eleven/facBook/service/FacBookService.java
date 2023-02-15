package com.eleven.facBook.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eleven.facBook.dao.FacBookDAO;
import com.eleven.facBook.dto.FacBookDTO;

@Service
public class FacBookService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired FacBookDAO dao;

	public ArrayList<FacBookDTO> fbList() {
		
		return dao.fbList();
	}

	public ArrayList<FacBookDTO> fbDetail(String fb_idx) {

		return dao.fbDetail(fb_idx);
	}

	public String reserveId(String fb_idx) {
		
		return dao.reserveId(fb_idx);
	}

	public int fbDelete(int fb_idx) {
		
		return dao.fbDelete(fb_idx);
	}

	public Object nameList(int type) {
		
		return dao.nameList(type);
	}

	public int fbUpdate(HashMap<String, String> params) {
		
		return dao.fbUpdate(params);
	}

	public int overlapCheck(HashMap<String, Object> map) {

		return dao.overlapCheck(map);
	}

	public int fbRegist(HashMap<String, String> params) {
		
		return dao.fbRegist(params);
	}

}
