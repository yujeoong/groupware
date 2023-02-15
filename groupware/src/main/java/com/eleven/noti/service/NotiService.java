package com.eleven.noti.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.eleven.noti.dao.NotiDAO;
import com.eleven.noti.dto.NotiDTO;
import com.eleven.noti.dto.NotiRcpDTO;

@Service
@MapperScan(value= {"com.eleven"})
public class NotiService {

	private final NotiDAO dao;
	public NotiService(NotiDAO dao) {
		this.dao = dao;
	}

	Logger logger = LoggerFactory.getLogger(getClass());
	
	//알림 등록 리스트(복수 수신자)
	public int sendNoti(String content, String mem_id, ArrayList<String> notiRcp) {
		int success=0;

		NotiDTO dto = new NotiDTO();
		dto.setContent(content);
		dto.setMem_id(mem_id);
		int row = dao.sendNoti(dto);
		if(row >0) {
			String noti_idx = dto.getNoti_idx();
			for (String rcp : notiRcp) {
				dao.sendNotiRcp(noti_idx, rcp);
			}
		}
		
		return success;
	}
	
	//알림 등록(단일 수신자)
	public int sendNotiSingle(String content, String mem_id, String notiRcp) {
		int success=0;
		
		NotiDTO dto = new NotiDTO();
		dto.setContent(content);
		dto.setMem_id(mem_id);
		int row = dao.sendNoti(dto);
		if(row >0) {
			String noti_idx = dto.getNoti_idx();
				dao.sendNotiRcp(noti_idx, notiRcp);
		}
		return success;
	}
	
	//수신 알림 리스트 호출
	public ArrayList<NotiDTO> notiInBox(String loginId) {
		return dao.notiInBox(loginId);
	}

	//알림 읽음 처리
	public int readNoti(String loginId, String noti_idx) {
		int success = 0;
		if(noti_idx.equals("readAll")) {
			logger.info("readAll~~~");
			success = dao.readNotiAll(loginId);
		}else{
			success = dao.readNoti(loginId, noti_idx);			
		}
		return success;
	}

	public HashMap<String, Object> notiSentList(String loginId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<NotiDTO> notiSentList = dao.notiSentList(loginId);
		for (NotiDTO notiDTO : notiSentList) {
			String noti_idx = notiDTO.getNoti_idx();
			ArrayList<NotiRcpDTO> rcpList = dao.notiRcpList(noti_idx);
			notiDTO.setRcpList(rcpList);
		}
		map.put("notiSentList", notiSentList);
		
		return map;
	}

}
