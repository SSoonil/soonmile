package com.sist.web.model;

import java.io.Serializable;

public class SmPaging implements Serializable {

	private static final long serialVersionUID = 1L;

	private long startNum;	//페이지내 첫번째 시작 번호
	private long endNum;	//페이지내 마지막 번호
	private long listSize;	//페이지내 게시물 수
	private long pageSize;	//표시할 페이지 개수
	private long totalCount;//총 게시물 수
	private long totalPage;	//총 페이지 수
	private long pageNum;	//현재 페이지
	private long startPage;	//첫번째 페이지 번호(현재 보이는 페이지 내) 
	private long endPage;	//마지막 페이지 번호
	
	public SmPaging(long pageNum, long totalCount, long listSize, long pageSize) {
		this.pageNum = pageNum;
		this.totalCount = totalCount;
		this.listSize = listSize;
		this.pageSize = pageSize;
		
		//계산
		if(totalCount > 0) {
			this.totalPage = (long)Math.ceil((double)totalCount / listSize);
			this.startNum = (pageNum - 1) * listSize + 1;
			this.endNum = startNum + listSize - 1;
			if(this.endNum > totalCount) {
				this.endNum = totalCount;
			}
			this.startPage = (pageNum - 1) / pageSize * pageSize + 1;
			this.endPage = startPage + pageSize - 1;
			if(this.endPage > totalPage) {
				this.endPage = totalPage;
			}
			
		}
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

	public long getListSize() {
		return listSize;
	}

	public void setListSize(long listSize) {
		this.listSize = listSize;
	}

	public long getPageSize() {
		return pageSize;
	}

	public void setPageSize(long pageSize) {
		this.pageSize = pageSize;
	}

	public long getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(long totalCount) {
		this.totalCount = totalCount;
	}

	public long getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(long totalPage) {
		this.totalPage = totalPage;
	}

	public long getPageNum() {
		return pageNum;
	}

	public void setPageNum(long pageNum) {
		this.pageNum = pageNum;
	}

	public long getStartPage() {
		return startPage;
	}

	public void setStartPage(long startPage) {
		this.startPage = startPage;
	}

	public long getEndPage() {
		return endPage;
	}

	public void setEndPage(long endPage) {
		this.endPage = endPage;
	}
	
	
}
