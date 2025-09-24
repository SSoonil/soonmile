package com.sist.web.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.GroupDao;
import com.sist.web.dao.UserDao;
import com.sist.web.model.Group;

@Service("groupService")
public class GroupService {
private static Logger logger = LoggerFactory.getLogger(UserService.class);
	
	@Autowired
	private GroupDao groupDao;
	
	@Autowired
	private UserDao userDao;
	
	public int groupMade(Group group) {
		int res = 0;
		try {
			res = groupDao.groupMade(group);
		} catch(Exception e) {
			logger.error("[groupService] groupMade exception", e);
		}
		return res;
	}
	
	public List<Group> groupList(Group group){
		List<Group> res = new ArrayList<Group>();
		try {
			res = groupDao.groupList(group);
		} catch(Exception e) {
			logger.error("[groupService] groupList exception", e);
		}
		return res;
	}
	public long groupListCount(Group group) {
		long res = 0;
		try {
			res = groupDao.groupListCount(group);
		} catch(Exception e) {
			logger.error("[groupService] groupListCount exception", e);
		}
		return res;
	}
}
