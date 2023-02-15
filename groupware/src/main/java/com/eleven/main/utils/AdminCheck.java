package com.eleven.main.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AdminCheck implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		boolean pass = false;
		
		//관리자 레벨 확인
		HttpSession session = request.getSession();
		if(session.getAttribute("level").equals("1") || session.getAttribute("level").equals("0")) {
			pass = true;
		}else {
			response.sendRedirect("/");
		}

		return pass;
	}
	
}
