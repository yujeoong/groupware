package com.eleven.facBook.dao;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eleven.facBook.dto.FacBookDTO;

@Mapper
public interface FacBookDAO {

	ArrayList<FacBookDTO> fbList();

	ArrayList<FacBookDTO> fbDetail(String fb_idx);

	String reserveId(String fb_idx);

	int fbDelete(int fb_idx);

	List<String> nameList(int type);

	int fbUpdate(HashMap<String, String> params);

	int overlapCheck(HashMap<String, Object> map);

	int fbRegist(HashMap<String, String> params);

}
