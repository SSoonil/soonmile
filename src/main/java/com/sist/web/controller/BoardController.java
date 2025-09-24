package com.sist.web.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sist.web.model.Group;
import com.sist.web.service.GroupService;
import com.sist.web.service.UserService;
import com.sist.web.util.CookieUtil;

@Controller("boardController")
public class BoardController {
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private GroupService groupService;
	
	@RequestMapping(value="/board/map", method=RequestMethod.GET)
	public String map(HttpServletRequest request, HttpServletResponse response, Model model) {
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		Group search = new Group();
		search.setUserId(userId);
		long totalCount = groupService.groupListCount(search);
		List<Group> group = new ArrayList<Group>();
		
		search.setStartNum(0);
		search.setEndNum(totalCount);
		group = groupService.groupList(search);
		model.addAttribute("groups", group);
		return "/board/map";
	}
}
