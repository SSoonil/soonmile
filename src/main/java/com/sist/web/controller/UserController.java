package com.sist.web.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.common.util.StringUtil;
import com.sist.web.model.Group;
import com.sist.web.model.Paging;
import com.sist.web.model.Response;
import com.sist.web.model.SmPaging;
import com.sist.web.model.User;
import com.sist.web.service.GroupService;
import com.sist.web.service.UserService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;

@Controller("userController")
public class UserController {
	private static Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;

	@Value("#{env['auth.cookie.rate']}")
	private String AUTH_COOKIE_RATE;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private GroupService groupService;
	
	//로그인 회원가입 페이지
	@RequestMapping(value="/user/joinForm", method=RequestMethod.GET)
	public String reg(HttpServletRequest request, HttpServletResponse response) {
		return "/user/joinForm";
	}
	
	//myinfo 페이지
	@RequestMapping(value="/user/myInfo", method=RequestMethod.GET)
	public String myInfo(HttpServletRequest request, HttpServletResponse response, Model model){
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
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
		logger.debug(group.get(0).toString());
		logger.debug( group.get(0).getGroupName());
		model.addAttribute("groups", group);
		model.addAttribute("paging", paging);
		return "/user/myInfo";
	}
	
	//회원 가져오기
	@RequestMapping(value="/user/info", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> info(HttpServletRequest request, HttpServletResponse response){
		Response<Object> res = new Response<Object>();
		
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		User user = userService.userSelect(userId);
		logger.debug(userId + "ddddddddddddddd");
		logger.debug(user.getUserId() + "ddddddddddddddd2");
		res.setData(user);
		return res;
	}
	
	//로그인 시작
	@RequestMapping(value="/user/loginProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> login(HttpServletRequest request, HttpServletResponse response){
		Response<Object> res = new Response<Object>();
		
		String userId = HttpUtil.get(request, "loginUserId");
		String userPwd = HttpUtil.get(request, "loginUserPwd");
		User user = null;
		if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd)) {
			user = userService.userSelect(userId);
			if(user != null) {
				if(StringUtil.equals(userPwd, user.getUserPwd())) {
					logger.debug(user.toString());
					if(StringUtil.equals(user.getStatus(), "Y")) {
						if(userService.userLogin(userId) > 0) {
							CookieUtil.addCookie(response, "/", 0, AUTH_COOKIE_NAME, CookieUtil.stringToHex(user.getUserId()));
							res.setResponse(0, "로그인 성공");
						}
						else {
							res.setResponse(402, "로그인에 실패하였습니다.");
						}
					}
					else {
						res.setResponse(401, "정상적인 유저가 아닙니다");
					}
				}
				else {
					res.setResponse(403, "비밀번호가 일치하지 않습니다.");
				}
			}
			else {
				res.setResponse(404, "없는 유저입니다.");
			}
		}
		else {
			res.setResponse(400, "아이디나 비밀번호를 입력해주세요");
		}
		
		return res;
	}
	//로그인 끝
	//회원가입 시작
	@RequestMapping(value="/user/joinProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> join(HttpServletRequest request, HttpServletResponse response){
		Response<Object> res = new Response<Object>();
		
		String userId = HttpUtil.get(request, "joinUserId");
		String userPwd = HttpUtil.get(request, "joinUserPwd");
		String userName = HttpUtil.get(request, "joinUserName");
		String userPhone = HttpUtil.get(request, "joinUserPhone");
		String userEmail = HttpUtil.get(request, "joinUserEmail");
		
		logger.debug(userId + "=" + userPwd + "=" + userName + "=" + userPhone + "=" + userEmail);
		
		if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userPhone) && !StringUtil.isEmpty(userEmail)) {
			if(userService.userSelect(userId) == null) {
				User user = new User();
				user.setUserId(userId);
				user.setUserPwd(userPwd);
				user.setUserName(userName);
				user.setUserPhone(userPhone);
				user.setUserEmail(userEmail);
				if(userService.userJoin(user) > 0) {
					res.setResponse(0, "회원가입 완료");
				}
				else {
					res.setResponse(404, "회원가입 실패");
				}
			}
			else {
				res.setResponse(405, "이미 존재하는 아이디입니다.");
			}
		}
		else {
			res.setResponse(400, "입력값이 충분하지 않습니다.");
		}
		
		return res;
	}
	
	//아이디 중복체크
	@RequestMapping(value="/user/checkDupId", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> checkDupId(HttpServletRequest request, HttpServletResponse response){
		Response<Object> res = new Response<Object>();
		String userId = HttpUtil.get(request, "joinUserId");
		User user = null;
		user = userService.userSelect(userId);
		if(user == null) {
			res.setCode(0);
		}
		else {
			res.setCode(400);
		}
		return res;
	}
	
	//회원가입 끝
	
	//회원정보 수정
		@RequestMapping(value="/user/updateProc", method=RequestMethod.POST)
		@ResponseBody
		public Response<Object> updateProc(HttpServletRequest request, HttpServletResponse response){
			Response<Object> res = new Response<Object>();
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			String userId = HttpUtil.get(request, "infoUserId");
			String userPwd = HttpUtil.get(request, "infoUserPwd");
			String userName = HttpUtil.get(request, "infoUserName");
			String userPhone = HttpUtil.get(request, "infoUserPhone");
			String userEmail = HttpUtil.get(request, "infoUserEmail");
			
			logger.debug("===" + cookieUserId + "-" + userId + "=" + userPwd + "=" + userName + "=" + userPhone + "=" + userEmail);
			User user = null;
			user = userService.userSelect(userId);
			if(StringUtil.equals(cookieUserId, userId)) {
				if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userPhone) && !StringUtil.isEmpty(userEmail)) {
					User user1 = new User();
					user1.setUserId(userId);
					user1.setUserPwd(userPwd);
					user1.setUserName(userName);
					user1.setUserPhone(userPhone);
					user1.setUserEmail(userEmail);
					if(userService.userUpdate(user1) > 0) {
						res.setResponse(0, "회원정보 수정 완료");
					}
					else {
						res.setResponse(404, "회원정보 수정 실패");
					}
				}
				else {
					res.setResponse(400, "입력값이 충분하지 않습니다.");
				}
			}
			else {
				res.setResponse(404, "로그인 정보와 일치하지 않습니다.");
			}
			
			return res;
		}
	
	
}
