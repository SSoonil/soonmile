package com.sist.web.model;

import java.io.Serializable;

public class Group implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private String groupId;
	private String ownerId;
	private String groupName;
	private String isPublic;
	private String groupIntro;
	private String groupProfile;
	private String inviteCode;
	private String status;
	private String createAt;
	private String updateAt;
	
	//페이징 및 검색용 변수
	private String userId;
	private long startNum;
	private long endNum;
	
	public Group() {
		groupId = "";
		ownerId = "";
		groupName = "";
		isPublic = "";
		groupIntro = "";
		groupProfile = "";
		inviteCode = "";
		status = "";
		createAt = "";
		updateAt = "";
		
		userId = "";
		startNum = 0;
		endNum = 0;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getOwnerId() {
		return ownerId;
	}

	public void setOwnerId(String ownerId) {
		this.ownerId = ownerId;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getIsPublic() {
		return isPublic;
	}

	public void setIsPublic(String isPublic) {
		this.isPublic = isPublic;
	}

	public String getGroupIntro() {
		return groupIntro;
	}

	public void setGroupIntro(String groupIntro) {
		this.groupIntro = groupIntro;
	}

	public String getGroupProfile() {
		return groupProfile;
	}

	public void setGroupProfile(String groupProfile) {
		this.groupProfile = groupProfile;
	}

	public String getInviteCode() {
		return inviteCode;
	}

	public void setInviteCode(String inviteCode) {
		this.inviteCode = inviteCode;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCreateAt() {
		return createAt;
	}

	public void setCreateAt(String createAt) {
		this.createAt = createAt;
	}

	public String getUpdateAt() {
		return updateAt;
	}

	public void setUpdateAt(String updateAt) {
		this.updateAt = updateAt;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public long getStartNum() {
		return startNum;
	}

	public void setStartNum(long startNum) {
		this.startNum = startNum;
	}

	public long getEndNum() {
		return endNum;
	}

	public void setEndNum(long endNum) {
		this.endNum = endNum;
	}
	
	
}
