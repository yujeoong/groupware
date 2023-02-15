package com.eleven.prjManage.dao;

import java.util.ArrayList;

import com.eleven.prjManage.dto.AuthorityDTO;
import com.eleven.prjManage.dto.DepDTO;
import com.eleven.prjManage.dto.MemberDTO;
import com.eleven.prjManage.dto.ProjectDTO;

public interface PrjManageDAO {

	int regist(ProjectDTO dto);

	ProjectDTO prjDetail(String prj_idx);

	int edit(ProjectDTO dto);

	void delete(String prj_idx);

	ArrayList<ProjectDTO> prjList(String listCat, String loginId, int offset, String searchInput);

	ArrayList<MemberDTO> memList();

	void authRegist(AuthorityDTO auth);

	ArrayList<AuthorityDTO> authList(String prj_idx);

	int authDelete(int prj_idx);

	ArrayList<DepDTO> depList();

	String taskPercent(int prj_idx);

	int prjTotalCount(String listCat, String loginId, String searchInput);

}
