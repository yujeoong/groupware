package com.eleven.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.eleven.admin.dto.AdminFacDTO;

public interface AdminFacDAO {

	int totalCount(String option, String searchWhat);

	ArrayList<AdminFacDTO> Faclist(int offset, String option, String searchWhat);

	int facRegist(HashMap<String, String> params);

	int facNameFind(String nameFinder);

	int facUpdate(HashMap<String, String> params);

	String whatIsName(String nameFinder);


}
