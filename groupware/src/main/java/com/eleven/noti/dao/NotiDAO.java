package com.eleven.noti.dao;

import java.util.ArrayList;

import com.eleven.noti.dto.NotiDTO;
import com.eleven.noti.dto.NotiRcpDTO;

public interface NotiDAO {

	ArrayList<NotiDTO> notiInBox(String loginId);

	int readNoti(String loginId, String noti_idx);

	int readNotiAll(String loginId);

	ArrayList<NotiDTO> notiSentList(String loginId);

	ArrayList<NotiRcpDTO> notiRcpList(String noti_idx);

	int sendNoti(NotiDTO dto);

	void sendNotiRcp(String noti_idx, String rcp);

}
