package com.eleven.main.config;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.eleven.main.utils.AdminCheck;
import com.eleven.main.utils.LoginCheck;
import com.eleven.main.utils.TeamLeaderCheck;

@Configuration
public class InterceptorConfig implements WebMvcConfigurer {

	private final LoginCheck loginCheck;
	public InterceptorConfig(LoginCheck loginCheck) {
		this.loginCheck = loginCheck;
	}
	
	@Autowired AdminCheck adminCheck;
	@Autowired TeamLeaderCheck teamLeaderCheck;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		//WebMvcConfigurer.super.addInterceptors(registry);
		
		//무시할 패턴 리스트 생성
		ArrayList<String> excludeList = new ArrayList<String>();
		excludeList.add("/");
		excludeList.add("/login*");	//.뒤에 모든 것 포함
		excludeList.add("/logout.do");
		excludeList.add("/*.ajax");
		excludeList.add("/resources/**");
		excludeList.add("/assets/**");
		
		registry.addInterceptor(loginCheck)//1. 인터셉터에서 실행할 클래스
		.addPathPatterns("/**")//2. 인터셉터에서 잡아낼 url 패턴 설정(모든 url 대상으로)
		.excludePathPatterns(excludeList);//3. 인터셉터에서 무시할 url 패턴
		
		registry.addInterceptor(adminCheck)
		.addPathPatterns("/admin/**")
		.excludePathPatterns(excludeList);

		registry.addInterceptor(teamLeaderCheck)
		.addPathPatterns("/prjManage/projectRegist.move")
		.excludePathPatterns(excludeList);
	}

}
