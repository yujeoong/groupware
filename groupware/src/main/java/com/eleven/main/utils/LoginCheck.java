package com.eleven.main.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Component
public class LoginCheck implements HandlerInterceptor{

	//preHandler: 컨트롤러 진입 전에 실행되는 메서드. 반환값이 true면 컨트롤러 진입, false면 진입 불가.
	//false인 경우 response 객체를 이용해 redirect 한다.
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		boolean pass = false;
		
		HttpSession session = request.getSession();
		if(session.getAttribute("loginId") != null) {
			pass = true;
		}else {
			response.sendRedirect("/login");
		}
		
		return pass;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}

}
