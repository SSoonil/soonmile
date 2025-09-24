package com.sist.web.service;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service("commonService")
public class CommonService {
	private static Logger logger = LoggerFactory.getLogger(CommonService.class);
	
	public String createGroupCode(String groupName) {
		String groupId = "";
		String uuidString = UUID.nameUUIDFromBytes(groupName.getBytes()).toString();
		logger.debug("uuid" + uuidString);
		byte[] uuidStringBytes = uuidString.getBytes(StandardCharsets.UTF_8);
		byte[] hashBytes;
		
		try {
			MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
			hashBytes = messageDigest.digest(uuidStringBytes);
		} catch (NoSuchAlgorithmException e) {
			logger.error("[CommonService] createGroupId Exception", e);
			throw new RuntimeException(e);
		}
		
		StringBuilder sb = new StringBuilder();
		for(int i=0; i < 4; i++) {
			sb.append(String.format("%02x", hashBytes[i]));
		}
		groupId = sb.toString();
		logger.debug(groupId);
		return groupId;
	}
	
	
}
