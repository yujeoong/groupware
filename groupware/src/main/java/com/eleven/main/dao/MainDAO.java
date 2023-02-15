package com.eleven.main.dao;

import java.util.ArrayList;

import com.eleven.admin.dto.DepartmentDTO;

public interface MainDAO {

	ArrayList<DepartmentDTO> depList(String loginId);

}
