package com.sist.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.web.model.Place;

@Repository("placeDao")
public interface PlaceDao {
	
	//장소 등록
	public int regPlace(Place place);
	
	//PLACE LIST
	public List<Place> placeList(Place place);
}
