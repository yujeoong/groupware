package com.eleven.login;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service
@MapperScan(value= {"com.eleven.login"})
public class LoginService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired LoginDAO dao;
	@Autowired PasswordEncoder encoder;

	public ModelAndView login(String id, String pw, HttpSession session) {
		ModelAndView mav = new ModelAndView("redirect:/");
		
		// 해당 아이디의 pw(암호화)를 db에서 꺼내온다.
		String encoded_pw = dao.encodedPW(id);
		logger.info("encoded_pw :{}", encoded_pw);
		
		// 입력받은 pw와 비교 
		boolean match = encoder.matches(pw, encoded_pw);	
		
		String msg = "아이디/비밀번호를 확인바랍니다.";
		String page = "login";
		String loginId	= dao.login(id);
		String name = null; // 이름 
		String pos = null; 	// 직급 
		String duty = null; // 직책 
		String dep = null;	// 부서
		String level = null; // 관리자 등급

		String duty_level = null; // 관리자 등급
		String profile_img = null; // 관리자 등급
		
		logger.info("loginId :"+loginId);
		
		if(match) {
			logger.info("일치 여부 : "+match);
			page = "redirect:/"; 
			name = dao.name(id);
			pos = dao.pos(id);  
			duty = dao.duty(id);  
			dep = dao.dep(id);
			level = dao.level(id);
			duty_level = dao.duty_level(id);
			profile_img = dao.profileImg(id);
			logger.info("name/pos/duty/dep/level :{}, {}, {}, {},{}", name, pos, duty, dep, level);
			
			session.setAttribute("loginId", loginId);
			session.setAttribute("name", name);
			session.setAttribute("pos", pos);
			session.setAttribute("duty", duty);
			session.setAttribute("dep", dep);
			session.setAttribute("level", level);
			session.setAttribute("pos", pos);
			session.setAttribute("duty_level", duty_level);
			session.setAttribute("profileImg", profile_img);
		} else {
			logger.info("로그인 실패");
			mav.addObject("msg", msg);	// redirect 에서 model에 값을 담은면 get방식 parameter로 전달 됨(=> url 뒤에 붙는다.)		
		}
		 
		mav.setViewName(page);
		return mav;
	}
	
	

}
