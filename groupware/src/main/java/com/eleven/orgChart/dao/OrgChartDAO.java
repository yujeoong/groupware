package com.eleven.orgChart.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.eleven.orgChart.dto.OrgChartDTO;

@Mapper
public interface OrgChartDAO {


	ArrayList<OrgChartDTO> orgList();

}
