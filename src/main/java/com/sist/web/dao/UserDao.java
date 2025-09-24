package com.sist.web.dao;

import org.springframework.stereotype.Repository;

import com.sist.web.model.User;

@Repository("userDao")
public interface UserDao {
	
	//유저 선택(로그인)
	public User userSelect(String userId);
	
	//회원가입
	public int userJoin(User user);
	
	//회원수정
	public int userUpdate(User user);
	
	//로그인시 최근 로그인 날짜 확인
	public int userLogin(String userId);
}
