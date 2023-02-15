package com.eleven.main.service;

import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eleven.admin.dto.DepartmentDTO;
import com.eleven.main.dao.MainDAO;

@Service
@MapperScan(value= {"com.eleven.main"})
public class MainService {

	@Autowired MainDAO dao;

	public ArrayList<DepartmentDTO> depList(String loginId) {
		return dao.depList(loginId);
	}
}
