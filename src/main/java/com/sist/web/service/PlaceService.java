package com.sist.web.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.PlaceDao;
import com.sist.web.model.Group;
import com.sist.web.model.Place;
import com.sist.web.model.User;

@Service("placeService")
public class PlaceService {
	private static Logger logger = LoggerFactory.getLogger(PlaceService.class);
	
	@Autowired
	private PlaceDao placeDao;
	
	public int regPlace(Place place) {
		int res = 0;
		
		try {
			res = placeDao.regPlace(place);
		} catch(Exception e) {
			logger.error("[mapService] mapService Exception", e);
		}
		return res;
	}
	
	public List<Place> placeList(Place place){
		List<Place> res = new ArrayList<Place>();
		try {
			res = placeDao.placeList(place);
		} catch(Exception e) {
			logger.error("[placeService] placeList exception", e);
		}
		return res;
	}
}