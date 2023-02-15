package com.eleven.login;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;	

@Controller
public class LoginController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired LoginService loginService;
	
	@GetMapping(value={"/login"})
	public String login() {
		return "login";
	}
	
	
	@PostMapping(value = "/login.do")
	public ModelAndView login(String id, String pw, HttpSession session) {
		logger.info("login 요청 id :{}, pw :{}", id, pw);
		
		return loginService.login(id, pw, session);
	}
	
	
	// 로그아웃 
	@GetMapping(value = "/logout.do")
	public String logout(HttpSession session) {
		session.removeAttribute("loginId"); 
		session.removeAttribute("name");
		session.removeAttribute("pos");
		session.removeAttribute("duty");
		session.removeAttribute("dep");
		session.removeAttribute("level");
		session.invalidate();
		
		return "login";
	}
	
}