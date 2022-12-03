package com.kh.moida.board.model.vo;

import java.util.Date;

public class Challenge {

	private int cNo;
	private String cTitle;
	private String cCont;
	private Date cDate;
	private int gNo;
	private String gName;
	public Challenge() {
		super();
	}
	public Challenge(int cNo, String cTitle, String cCont, Date cDate, int gNo, String gName) {
		super();
		this.cNo = cNo;
		this.cTitle = cTitle;
		this.cCont = cCont;
		this.cDate = cDate;
		this.gNo = gNo;
		this.gName = gName;
	}
	@Override
	public String toString() {
		return "Challenge [cNo=" + cNo + ", cTitle=" + cTitle + ", cCont=" + cCont + ", cDate=" + cDate + ", gNo=" + gNo
				+ ", gName=" + gName + "]";
	}
	public int getcNo() {
		return cNo;
	}
	public void setcNo(int cNo) {
		this.cNo = cNo;
	}
	public String getcTitle() {
		return cTitle;
	}
	public void setcTitle(String cTitle) {
		this.cTitle = cTitle;
	}
	public String getcCont() {
		return cCont;
	}
	public void setcCont(String cCont) {
		this.cCont = cCont;
	}
	public Date getcDate() {
		return cDate;
	}
	public void setcDate(Date cDate) {
		this.cDate = cDate;
	}
	public int getgNo() {
		return gNo;
	}
	public void setgNo(int gNo) {
		this.gNo = gNo;
	}
	public String getgName() {
		return gName;
	}
	public void setgName(String gName) {
		this.gName = gName;
	}
	
	
}
