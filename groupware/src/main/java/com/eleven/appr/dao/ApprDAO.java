package com.eleven.appr.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.eleven.admin.dto.FileDTO;
import com.eleven.appr.dto.ApprDocDTO;
import com.eleven.appr.dto.ApprLineDTO;
import com.eleven.appr.dto.DocFormDTO;

public interface ApprDAO {

	int formRegist(DocFormDTO dto);

	DocFormDTO apprForm(String form_idx);

	int apprRegist(ApprDocDTO apprDoc);

	void apprLineRegist(ApprLineDTO apprLine);

	void apprLineFirst(String doc_idx);

	void apprLineSecond(String doc_idx);

	ArrayList<ApprDocDTO> apprList(String subCat, String loginId, int offset, String searchInput);

	ApprDocDTO apprDetail(String doc_idx);

	ArrayList<ApprLineDTO> apprLine(String doc_idx);

	void apprLineState(String doc_idx, int appr_order, String appr_state);

	void apprDocState(HashMap<String, String> params);

	void formUpHit(String form_idx);

	void apprToPost(String doc_idx);

	int docFormTotalCount(String searchInput);

	ArrayList<DocFormDTO> formList(int offset, String searchInput);

	int formDelete(String form_idx);

	int apprTotalCount(String subCat, String loginId, String searchInput);

	void fileWrite(String oriFileName, String newFileName, String doc_idx);

	ArrayList<FileDTO> fileList(String doc_idx);

}
