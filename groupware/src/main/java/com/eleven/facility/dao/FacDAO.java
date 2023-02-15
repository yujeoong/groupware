package com.eleven.facility.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FacDAO {
	
	int totalCount(String option);

	ArrayList<HashMap<String, Object>> facList(HashMap<String, Object> map);

	HashMap<String, Object> facDetail(int fac_idx);

	int facListAll();

	void facStateUpdate(String strNow);


}
