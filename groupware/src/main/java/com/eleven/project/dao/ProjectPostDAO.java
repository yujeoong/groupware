package com.eleven.project.dao;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.springframework.web.multipart.MultipartFile;

import com.eleven.noti.dto.NotiDTO;
import com.eleven.project.dto.CommDTO;
import com.eleven.project.dto.PollDTO;
import com.eleven.project.dto.PrjFileDTO;
import com.eleven.project.dto.ProjectPostDTO;
import com.eleven.project.dto.SelDTO;

public interface ProjectPostDAO {

	ArrayList<ProjectPostDTO> memList(String prj_idx);

	String subject(String prj_idx);

	int postWrite(ProjectPostDTO dto);

	void fileWrite(int prj_post_idx, String ori_File_Name, String new_file_name);

	String dateCheck(String prj_idx);

	int feedbackWrite(ProjectPostDTO dto);

	ArrayList<ProjectPostDTO> postList(String prj_idx);
	
	ArrayList<PrjFileDTO> fileList(String prj_post_idx);
	
	//ArrayList<CommDTO> commList(int i);

	HashMap<String, Object> postDetail(String prj_idx, String prj_post_idx);

	ArrayList<ProjectPostDTO> feedbackList(String prj_idx);

	HashMap<String, Object> feedbackDetail(String prj_idx, String prj_post_idx);

	ArrayList<ProjectPostDTO> postNumList(String prj_idx);

	ArrayList<CommDTO> commList(String prj_post_idx);

	int comtSubmit(String comment, String prj_post_idx, String loginId);

	int comtUpdate(String prj_com_idx, String comment);

	int comDelete(String prj_com_idx);

	int taskWrite(ProjectPostDTO dto);

	//int taskStateWrite(ProjectPostDTO dto, int prj_post_idx);

	int taskStateWrite(int prj_post_idx, String plan_start, String plan_end, String mem_id);

	ArrayList<ProjectPostDTO> taskList(String prj_idx);

	void postUpdate(String subject, String content, String post_prj_post_idx);

	void feedbackUpdate(String subject, String content, String feedback_prj_post_idx);
	
	int stateUpdate_task_ready(String prj_post_idx);

	int stateUpdate_task_ing(String prj_post_idx);

	int stateUpdate_task_fin(String prj_post_idx);

	int readyCommRegit(String loginId, String prj_post_idx, String name);

	int ingCommRegit(String loginId, String prj_post_idx, String name);

	int finCommRegit(String loginId, String prj_post_idx, String name);

	int sendNoti(NotiDTO noti);

	int sendNoti_rcp(String noti_idx, String mem_id);

	int pollWrite(ProjectPostDTO projectPostdto);

	int pollState(PollDTO pollDto);

	void pollSel(SelDTO selDto);

	ArrayList<ProjectPostDTO> pollList(String prj_idx);

	ArrayList<SelDTO> selList(String prj_post_idx);

	int totalCount(String prj_post_idx);

	String selected(String prj_post_idx, String loginId);

	int doPoll(String loginId, String sel_idx);

	int cancelPoll(String loginId, int selIdx);

	int getSelIdx(String loginId, String sel_idx);

	ArrayList<SelDTO> pollMem(String sel_idx);

	void taskUpdate(String subject, String content, String post_prj_post_idx);

	void tastDateUpdate(String plan_start, String plan_end, String post_prj_post_idx);

	int poll_postUpdate(String subject, String content, String poll_prj_post_idx);

	int poll_stateUpdate(String anon, String poll_end, String poll_prj_post_idx);

	ArrayList<ProjectPostDTO> HomeList(String prj_idx);

	int sel_update(SelDTO seldto);

	int deleteSel(String poll_prj_post_idx);

	int authority(ProjectPostDTO dto);

	String fileName(String path);

	String access(String prj_idx, String loginId);







	
	

}
