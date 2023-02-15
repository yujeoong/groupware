package com.eleven.orgChart.service;

import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.eleven.orgChart.dao.OrgChartDAO;
import com.eleven.orgChart.dto.OrgChartDTO;


@Service
@MapperScan(value= {"com.eleven.orgChart"})
public class OrgChartService {

	@Autowired OrgChartDAO dao;
	Logger logger = LoggerFactory.getLogger(getClass());
	@Value("${file.location}")
	private String root;
	
	
	
	public ArrayList<OrgChartDTO> orgList() {
		return dao.orgList();
	}


	
	

	
	
	
	
	
	
}
