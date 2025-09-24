package com.sist.web.model;

import java.io.Serializable;

public class User implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String userId;
	private String userPwd; 
	private String userName;
	private String userPhone;
	private String userProfile;
	private String status;
	private String regDate;
	private String updateDate;
	private String lastLoginDate;
	private String userEmail;
	
	public User() {
		userId = "";
		userPwd = "";
		userName = "";
		userPhone = "";
		userProfile = "";
		status = "N";
		regDate = "";
		updateDate = "";
		lastLoginDate = "";
		userEmail = "";
		
	}
	
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public String getUserProfile() {
		return userProfile;
	}
	public void setUserProfile(String userProfile) {
		this.userProfile = userProfile;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getLastLoginDate() {
		return lastLoginDate;
	}
	public void setLastLoginDate(String lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	} 
	
	
	
}
