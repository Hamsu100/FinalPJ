package com.kh.moida.board.model.vo;

import java.sql.Date;

public class Reply {
	// insert param
	private int rNo;
	private String rCont;
	private java.sql.Date rMdf;
	private int uNo;
	private int bNo;
	private int gNo;
	// view param
	private String uNick;
	private String uRen;
	
	public String getuRen() {
		return uRen;
	}
	public void setuRen(String uRen) {
		this.uRen = uRen;
	}
	@Override
	public String toString() {
		return "Reply [rNo=" + rNo + ", rCont=" + rCont + ", rMdf=" + rMdf + ", uNo=" + uNo + ", bNo=" + bNo + ", gNo="
				+ gNo + ", uNick=" + uNick + ", uRen=" + uRen + "]";
	}
	public Reply(int rNo, String rCont, Date rMdf, int uNo, int bNo, int gNo, String uNick, String uRen) {
		super();
		this.rNo = rNo;
		this.rCont = rCont;
		this.rMdf = rMdf;
		this.uNo = uNo;
		this.bNo = bNo;
		this.gNo = gNo;
		this.uNick = uNick;
		this.uRen = uRen;
	}
	public Reply() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getrNo() {
		return rNo;
	}
	public void setrNo(int rNo) {
		this.rNo = rNo;
	}
	public String getrCont() {
		return rCont;
	}
	public void setrCont(String rCont) {
		this.rCont = rCont;
	}
	public java.sql.Date getrMdf() {
		return rMdf;
	}
	public void setrMdf(java.sql.Date rMdf) {
		this.rMdf = rMdf;
	}
	public int getuNo() {
		return uNo;
	}
	public void setuNo(int uNo) {
		this.uNo = uNo;
	}
	public int getbNo() {
		return bNo;
	}
	public void setbNo(int bNo) {
		this.bNo = bNo;
	}
	public int getgNo() {
		return gNo;
	}
	public void setgNo(int gNo) {
		this.gNo = gNo;
	}
	public String getuNick() {
		return uNick;
	}
	public void setuNick(String uNick) {
		this.uNick = uNick;
	}
	
	
}
//java.lang.String' to required type 'java.lang.Class[]' for property 'typeAliases';
//nested exception is java.lang.IllegalArgumentException: Could not find class [com.kh.moida.*.model.vo]