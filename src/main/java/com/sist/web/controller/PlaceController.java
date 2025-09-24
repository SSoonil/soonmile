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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.common.util.StringUtil;
import com.sist.web.model.Place;
import com.sist.web.model.Response;
import com.sist.web.service.PlaceService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;

@Controller("placeController")
public class PlaceController {
	private static Logger logger = LoggerFactory.getLogger(PlaceController.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Autowired
	private PlaceService placeService;
	
	@RequestMapping(value="/map/regPlace", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> regPlace(HttpServletRequest request, HttpServletResponse response){
		Response<Object> res = new Response<Object>();
		
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String formGroupId = HttpUtil.get(request, "formGroupId");
		String placeAddr = HttpUtil.get(request, "placeAddr", "");
		String placePhone = HttpUtil.get(request, "placePhone", "");
		String placeName = HttpUtil.get(request, "placeName");
		double placeX = Double.parseDouble(HttpUtil.get(request, "placeX", "0"));
		double placeY = Double.parseDouble(HttpUtil.get(request, "placeY", "0"));
		String placeReview = HttpUtil.get(request, "placeReview", "");
		float placeRate = Float.parseFloat(HttpUtil.get(request, "placeRate", "0"));
		String placeCategoryGroupName = HttpUtil.get(request, "placeCategoryGroupName", "");
		String placeVisitDate = HttpUtil.get(request, "placeVisitDate", "");
		String placeRoadAddr = HttpUtil.get(request, "placeRoadAddr");
		String placeUrl = HttpUtil.get(request, "placeUrl");
		
		Place place = new Place();
		logger.debug("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		logger.debug("placeGroupId" + " " + formGroupId);
		logger.debug("placeAddr" + " " + placeAddr);
		logger.debug("placePhone" + " " + placePhone);
		logger.debug("placeName" + " " + placeName);
		logger.debug("placeX" + " " + placeX + "     " + placeY);
		logger.debug("placeReview" + " " + placeReview);
		logger.debug("placeRate" + " " + placeRate);
		logger.debug("userId " + userId);
		logger.debug("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		
		
		place.setGroupId(formGroupId);
		place.setUserId(userId);
		place.setPlaceAddr(placeAddr);
		place.setPlacePhone(placePhone);
		place.setPlaceName(placeName);
		place.setPlaceX(placeX);
		place.setPlaceY(placeY);
		place.setPlaceReview(placeReview);
		place.setPlaceRate(placeRate);
		place.setPlaceCategoryGroupName(placeCategoryGroupName);
		place.setPlaceVisitDate(placeVisitDate);
		place.setPlaceRoadAddr(placeRoadAddr);
		place.setPlaceUrl(placeUrl);
		
		placeService.regPlace(place);
		
		if(!StringUtil.isEmpty(userId)) {
			if(!StringUtil.isEmpty(formGroupId)) {
				res.setResponse(0, "성공");
			}
			else {
				res.setResponse(403, "그룹 선택 후 이용해 주세요");
			}
		}
		else {
			res.setResponse(403, "로그인 후 이용해 주세요");
		}
		
		return res;
		
	}
	
	@RequestMapping(value="/map/placeList", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> placeList(HttpServletRequest request, HttpServletResponse response){
		Response<Object> res = new Response<Object>();
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String groupId = HttpUtil.get(request, "groupId");
		
		logger.debug("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		logger.debug("groupId" + " " + groupId);
		logger.debug("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		
		Place search = new Place();
		search.setGroupId(groupId);
		search.setUserId(userId);
		List<Place> place = new ArrayList<Place>();
		place = placeService.placeList(search);
		res.setData(place);
		
		
		
		
		return res;
		
	}
}
