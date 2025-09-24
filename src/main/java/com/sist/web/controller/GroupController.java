package com.sist.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.common.util.StringUtil;
import com.sist.web.model.Group;
import com.sist.web.model.Response;
import com.sist.web.model.SmPaging;
import com.sist.web.service.CommonService;
import com.sist.web.service.GroupService;
import com.sist.web.service.UserService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;

@Controller("groupController")
public class GroupController {
private static Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;

	@Value("#{env['auth.cookie.rate']}")
	private String AUTH_COOKIE_RATE;
	
	@Autowired
	private GroupService groupService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CommonService commonService;
	
	//그룹 만들기
	@RequestMapping(value="/group/groupMade", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> groupMade(HttpServletRequest request, HttpServletResponse response){
		Response<Object> res = new Response<Object>();
		String groupName = HttpUtil.get(request, "groupName");
		String isPublic = HttpUtil.get(request, "isPublic");
		String groupIntro = HttpUtil.get(request, "groupIntro");
		String ownerId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String groupId = commonService.createGroupCode(groupName);
		logger.debug(groupId + "groupId test ==========================");
		
		if(!StringUtil.isEmpty(groupName) && !StringUtil.isEmpty(groupIntro)) {
			if(userService.userSelect(ownerId) != null) {
				Group group = new Group();
				group.setGroupName(groupName);
				group.setOwnerId(ownerId);
				group.setIsPublic(isPublic);
				group.setGroupIntro(groupIntro);
				group.setInviteCode(groupId);
				if(groupService.groupMade(group) > 0) {
					res.setResponse(0, "그룹 생성 완료");
				}
				else {
					res.setResponse(404, "그룹생성 실패");
				}
			}
			else {
				res.setResponse(403, "존재하지 않은 아이디입니다.");
			}
		}
		else {
			res.setResponse(400, "입력값이 충분하지 않습니다.");
		}
		return res;
	}
	
	
	//그룹 list
		@RequestMapping(value="/group/groupList", method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> groupList(HttpServletRequest request, HttpServletResponse response){
			Map<String, Object> res = new HashMap<>();
			String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			long curPage = HttpUtil.get(request, "curPage", 0);
			long pageNum = HttpUtil.get(request, "pageNum", 1);
			long listSize = 5;
			long pageSize = 2;
			Group search = new Group();
			search.setUserId(userId);
			long totalCount = groupService.groupListCount(search);
			SmPaging paging = new SmPaging(pageNum, totalCount, listSize, pageSize);
			logger.debug("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
			logger.debug("startNum" + " " + paging.getStartNum());
			logger.debug("endNum" + " " + paging.getEndNum());
			logger.debug("listSize" + " " + paging.getListSize());
			logger.debug("pageSize" + " " + paging.getPageSize());
			logger.debug("pageNum" + " " + paging.getPageNum());
			logger.debug("totalPage" + " " + paging.getTotalPage());
			logger.debug("totalCount" + " " + paging.getTotalCount());
			logger.debug("totalCount" + " " + totalCount);
			logger.debug("userId " + userId);
			logger.debug("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
			List<Group> group = new ArrayList<Group>();
			search.setStartNum(paging.getStartNum());
			search.setEndNum(paging.getEndNum());
			group = groupService.groupList(search);
			
			res.put("group", group);
			res.put("paging", paging);
			
			return res;
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
