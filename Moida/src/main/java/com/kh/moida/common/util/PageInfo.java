package com.kh.moida.common.util;

import lombok.Getter;

@Getter
public class PageInfo {
	private int currentPage;
	
	private int pageLimit;
	
	private int listCount;
	
	private int listLimit;	
	
	/**
	 * 
	 * @param currentPage ?˜„?¬ ?˜?´ì§?
	 * @param pageLimit ?•œ ?˜?´ì§??— ë³´ì—¬ì§? ?˜?´ì§??˜ ?ˆ˜ 
	 * @param listCount ? „ì²? ë¦¬ìŠ¤?Š¸?˜ ?ˆ˜
	 * @param listLimit ?•œ ?˜?´ì§??— ?‘œ?‹œ?  ë¦¬ìŠ¤?Š¸?˜ ?ˆ˜
	 */
	public PageInfo(int currentPage, int pageLimit, int listCount, int listLimit) {
		this.currentPage = currentPage;
		this.pageLimit = pageLimit;
		this.listCount = listCount;
		this.listLimit = listLimit;
	}
	
	/** 	
	 * @return ? „ì²? ?˜?´ì§? ì¤? ê°??¥ ë§ˆì?ë§? ?˜?´ì§?
	 */
	public int getMaxPage() {
		/*
		 	listCount = 100, listLimit = 10
		 	100 / 10 = 10.0		=> 10?˜?´ì§?
		 	101 / 10 = 10.1		=> 11?˜?´ì§?
		 	103 / 10 = 10.3		=> 11?˜?´ì§?
		 	109 / 10 = 10.9		=> 11?˜?´ì§?
		 	110 / 10 = 11.0		=> 11?˜?´ì§?
		 	111 / 10 = 11.1		=> 12?˜?´ì§?
		 */
		return (int)Math.ceil((double)this.listCount / this.listLimit);
	}
	
	/**
	 * 
	 * @return ?˜?´ì§? ?œ ?˜?´ì§??˜ ?‹œ?‘ index
	 */
	public int getStartPage() {
		/*	
			< 1 2 3 4 5 6 7 8 9 10 >
			< 11 12 13 14 15 16 17 18 19 20 >
			< 21 22 23 24 25 26 27 28 29 30 >
			
			1, 11, 21, 31, .... => (10 * n) + 1 (n >= 0)
			
			1 ~ 10 : n = 0
			11 ~ 20 : n = 1
			21 ~ 30 : n = 2
			31 ~ 40 : n = 3 
			.... 
			n = (currentPage - 1) / pageLimit
			
			(10 * ((currentPage - 1) / pageLimit)) + 1 (n >= 0)
		 */
		return (this.pageLimit * ((this.currentPage - 1) / this.pageLimit)) + 1;
	}

	/**
	 * 
	 * @return ?˜?´ì§? ?œ ?˜?´ì§? ì¤? ë§ˆì?ë§? indext
	 */ 
	public int getEndPage() {
		// 10, 20, 30, 40, .... 
		
		int endPage = getStartPage() + this.pageLimit - 1;
		
		return endPage > getMaxPage() ? getMaxPage() : endPage;
	}	
	

	/**
	 * 
	 * @return ?´? „ ?˜?´ì§?
	 */ 
	public int getPrevPage() {
		int prevPage = this.getCurrentPage() - 1;
		
		return prevPage < 1 ? 1 : prevPage;
	}
	
	/**
	 * 
	 * @return ?‹¤?Œ ?˜?´ì§?
	 */ 
	public int getNextPage() {
		int nextPage = this.getCurrentPage() + 1;
		
		return nextPage > getMaxPage() ? getMaxPage() : nextPage;
	}
	
	/**
	 * 
	 * @return ?˜?´ì§??˜ ?‹œ?‘ ë¦¬ìŠ¤?Š¸ 
	 */ 	
	public int getStartList() {
		return (this.getCurrentPage() - 1) * this.listLimit + 1;
	}
	
	/**
	 * 
	 * @return ?˜?´ì§??˜ ë§ˆì?ë§? ë¦¬ìŠ¤?Š¸
	 */ 	
	public int getEndList() {
		int endList = this.getStartList() + this.listLimit - 1;
		
		return endList > this.listCount ? this.listCount : endList;
	}
}
