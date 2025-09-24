package com.sist.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.web.model.Group;

@Repository("groupDao")
public interface GroupDao {
	//그룹 만들기
	public int groupMade(Group group);
	
	public List<Group> groupList(Group group);
	
	public long groupListCount(Group group);
}
