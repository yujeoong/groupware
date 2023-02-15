package com.eleven.admin.Controller;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class EncodeController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired PasswordEncoder encoder;
	
	/*
	@GetMapping(value = "/encode/{msg}")
	public HashMap<String, String> home(@PathVariable String msg) {
		logger.info("msg : "+msg);
		hash = encoder.encode(msg);
		logger.info("hash : "+hash);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("plain", msg);
		map.put("encoded", hash);
		
		return map;
	}
	
	@GetMapping(value = "/confirm/{msg}")
	public HashMap<String, Object> confirm(@PathVariable String msg) {
		
		/* 같은 평문을 넣어도 그 때마다 암호문이 달라짐
		 * 이유 : sault라는 값 때문임 
		 * (암호문을 통해 평문을 유추하지 못하도록 함)
		 * 평문 > 암호문 > 기존 암호문과 비교 형태는 불가
		 * 암호문끼리 같은지 아닌지는 확인할 수 없다는 뜻.
		 * 다만 평문을 넣었을 때 일치 여부만 알수 있는 방법이 있음.
		 
		
		
		logger.info("msg : "+msg);
		//평문을 넣었을 때 일치 여부를 알 수 있게 하는 법
		boolean match = encoder.matches(msg, hash);
		logger.info("일치 여부 : "+match);
		hash = encoder.encode(msg);
		logger.info("hash : "+hash);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("plain", msg);
		map.put("encoded", hash);
		
		return map;
	}
	*/
	
	//비밀번호 인코딩
	public String newPw(String pw) {
		String encodePw = null;
		
		//초기 등록시 pw == null 이므로 설정
		if(pw == null) {
			pw = "0000";
		}
		
		encodePw = encoder.encode(pw);
		logger.info("인코딩된 pw : "+encodePw);
		
		return encodePw;
	}
	
	//기존 비밀번호 일치 확인
	public boolean match(String pw, String getPw) {
		
		boolean match = encoder.matches(pw, getPw);
		logger.info("일치 여부 : "+match);
		
		return match;
	}

	
}
