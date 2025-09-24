package com.sist.web.model;

import java.io.Serializable;

public class Place implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private int placeId;
	private String groupId;
	private String userId;
	private String placeName;
	private double placeX;
	private double placeY;
	private String placeReview;
	private float placeRate;
	private String createAt;
	private String status;
	private String placeCategoryGroupName;
	private String placeVisitDate;
	private String placeAddr;
	private String placePhone;
	private String placeRoadAddr;
	private String placeUrl;
	
	
	public String getPlacePhone() {
		return placePhone;
	}
	public void setPlacePhone(String placePhone) {
		this.placePhone = placePhone;
	}
	public String getPlaceAddr() {
		return placeAddr;
	}
	public void setPlaceAddr(String placeAddr) {
		this.placeAddr = placeAddr;
	}
	public int getPlaceId() {
		return placeId;
	}
	public void setPlaceId(int placeId) {
		this.placeId = placeId;
	}
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPlaceName() {
		return placeName;
	}
	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}
	public double getPlaceX() {
		return placeX;
	}
	public void setPlaceX(double placeX) {
		this.placeX = placeX;
	}
	public double getPlaceY() {
		return placeY;
	}
	public void setPlaceY(double placeY) {
		this.placeY = placeY;
	}
	public String getPlaceReview() {
		return placeReview;
	}
	public void setPlaceReview(String placeReview) {
		this.placeReview = placeReview;
	}
	public float getPlaceRate() {
		return placeRate;
	}
	public void setPlaceRate(float placeRate) {
		this.placeRate = placeRate;
	}
	public String getCreateAt() {
		return createAt;
	}
	public void setCreateAt(String createAt) {
		this.createAt = createAt;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPlaceCategoryGroupName() {
		return placeCategoryGroupName;
	}
	public void setPlaceCategoryGroupName(String placeCategoryGroupName) {
		this.placeCategoryGroupName = placeCategoryGroupName;
	}
	public String getPlaceVisitDate() {
		return placeVisitDate;
	}
	public void setPlaceVisitDate(String placeVisitDate) {
		this.placeVisitDate = placeVisitDate;
	}
	public String getPlaceRoadAddr() {
		return placeRoadAddr;
	}
	public void setPlaceRoadAddr(String placeRoadAddr) {
		this.placeRoadAddr = placeRoadAddr;
	}
	public String getPlaceUrl() {
		return placeUrl;
	}
	public void setPlaceUrl(String placeUrl) {
		this.placeUrl = placeUrl;
	}
	
	
}
