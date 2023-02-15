package com.eleven.mail.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;

import com.eleven.admin.dto.MemberDTO;
import com.eleven.appr.dto.ApprLineDTO;
import com.eleven.mail.dto.FileDTO;
import com.eleven.mail.dto.MailDTO;
import com.eleven.mail.dto.MailRcpDTO;
import com.eleven.prjManage.dto.DepDTO;

@Mapper
public interface MailDAO {

	int registSender(MailDTO dto);

	void registReceiver(int mail_idx, String receiver_id);

	void fileUpload(String mail_idx, String ori_file_name, String new_file_name);

	int listTotal(String sessionId, String cat, String searchType, String searchInput);
	
	ArrayList<HashMap<String, Object>> list(HashMap<String, Object> map);
	
	void mail_rcp(MailRcpDTO rcpdto);

	void state(String mail_idx, String sessionId);

	MailDTO contentDetail(String mail_idx);

	ArrayList<FileDTO> fileList(String mail_idx);

	ArrayList<MailRcpDTO> rcp_list(String mail_idx);

	ArrayList<MailRcpDTO> read_list(String mail_idx);

	ArrayList<MailRcpDTO> unread_list(String mail_idx);

	MailDTO replyRcp(String mail_idx);

	int delete_mail(String rowNum, String sessionId, String cat);

	int read(String rowNum, String sessionId);

	void rcpListRegist(String mail_idx, String rcpId);
























}
