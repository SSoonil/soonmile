package com.sist.web.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.UserDao;
import com.sist.web.model.User;

@Service("userService")
public class UserService {

	private static Logger logger = LoggerFactory.getLogger(UserService.class);
	
	@Autowired
	private UserDao userDao;
	
	public User userSelect(String userId) {
		User user = null;

		try {
			user = userDao.userSelect(userId);
		} catch (Exception e) {
			logger.error("[userService] userSelect Exception", e);
		}

		return user;
	}
	
	public int userJoin(User user) {
		int res = 0;
		
		try {
			res = userDao.userJoin(user);
		} catch(Exception e) {
			logger.error("[userService] userJoin Exception", e);
		}
		return res;
	}
	
	public int userUpdate(User user) {
		int res = 0;
		
		try {
			res = userDao.userUpdate(user);
		} catch(Exception e) {
			logger.error("[userService] userUpdate Exception", e);
		}
		return res;
	}
	
	public int userLogin(String userId) {
		int res = 0;
		
		try {
			res = userDao.userLogin(userId);
		} catch(Exception e) {
			logger.error("[userService] userLogin Exception", e);
		}
		return res;
	}
}
