package com.eleven.noti.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.eleven.noti.dto.NotiDTO;
import com.eleven.noti.service.NotiService;

@RestController
public class NotiController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired NotiService service;
//    private final NotiService notiService;
//
//    public NotificationController(NotificationService notificationService) {
//        this.notificationService = notificationService;
//    }
//
//    /**
//     * @title 로그인 한 유저 sse 연결
//     */
//    @GetMapping(value = "/subscribe/{id}", produces = "text/event-stream")
//    public SseEmitter subscribe(@PathVariable Long id,
//                                @RequestHeader(value = "Last-Event-ID", required = false, defaultValue = "") String lastEventId) {
//        return notificationService.subscribe(id, lastEventId);
//    }
	
	
	//수신 알림 불러오기
	@GetMapping(value="/noti/notiInBox.ajax")
	public ArrayList<NotiDTO> notiInBox(HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		return service.notiInBox(loginId);
	}
	
	//발신 알림 불러오기
	@GetMapping(value="/noti/notiSentList.ajax")
	public HashMap<String, Object> notiSentList(HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		return service.notiSentList(loginId);
	}
	
	//알림 읽음 처리
	@GetMapping(value="/noti/readNoti.ajax")
	public int readNoti(HttpSession session, String noti_idx) {
		logger.info("noti 읽음변경 요청"+noti_idx);
		
		String loginId = (String) session.getAttribute("loginId");
		
		return service.readNoti(loginId,noti_idx);
	}
}
