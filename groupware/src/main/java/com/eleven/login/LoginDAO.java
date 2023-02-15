package com.eleven.login;

public interface LoginDAO {

	String encodedPW(String id);

	String login(String id);

	String name(String id);

	String pos(String id);

	String duty(String id);

	String dep(String id);

	String level(String id);

	String profileImg(String id);

	String duty_level(String id);


}


