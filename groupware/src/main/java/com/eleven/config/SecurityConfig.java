package com.eleven.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	
	@Bean
	public PasswordEncoder getPasswordEncoder() {
		
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		//기본로그인기능 사용X.
		//403: 권한에러 - csrf 기능을 비활성화하며 생기지 않는다.
	    //csrf(Cross Site Request Forgery): 내가 요청하지 않은 내용으로 요청되는 해킹방법(주로 자바스크립트를 이용한 페이지 변조)
	    // 이걸 막기 위해 csrf 토큰을 만들어 서버에서 페이지에 내려주게 된다.
	    // 그리고 페이지에서 서버에 요청을 보낼 경우 이 토큰 값을 보내게 된다.
	    // 그리고 요청 시 보내 온 토큰 값과 서버가 가지고 있는 토큰 값이 일치하는지 검사
	    // 일치하지 않거나 토큰이 없으면 403 에러(그런데 우리는 jsp에 토큰을 발행하는 로직을 넣지않았다.)
		http.httpBasic().disable().csrf().disable();
		return http.build();
	}
}
