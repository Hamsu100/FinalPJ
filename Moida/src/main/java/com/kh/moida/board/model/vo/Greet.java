package com.kh.moida.board.model.vo;

import java.sql.Date;

public class Greet {
	// insert param
	private int grNo;
	private String grCont;
	private java.sql.Date grCrt;
	private java.sql.Date grMdf;
	private String grStatus;
	private int uNo;
	private int gNo;

	// View param
	private String uNick;
	private String uRen;

	public Greet() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Greet(int grNo, String grCont, Date grCrt, Date grMdf, String grStatus, int uNo, int gNo, String uNick,
			String uRen) {
		super();
		this.grNo = grNo;
		this.grCont = grCont;
		this.grCrt = grCrt;
		this.grMdf = grMdf;
		this.grStatus = grStatus;
		this.uNo = uNo;
		this.gNo = gNo;
		this.uNick = uNick;
		this.uRen = uRen;
	}

	@Override
	public String toString() {
		return "Greet [grNo=" + grNo + ", grCont=" + grCont + ", grCrt=" + grCrt + ", grMdf=" + grMdf + ", grStatus="
				+ grStatus + ", uNo=" + uNo + ", gNo=" + gNo + ", uNick=" + uNick + ", uRen=" + uRen + "]";
	}

	public int getGrNo() {
		return grNo;
	}

	public void setGrNo(int grNo) {
		this.grNo = grNo;
	}

	public String getGrCont() {
		return grCont;
	}

	public void setGrCont(String grCont) {
		this.grCont = grCont;
	}

	public java.sql.Date getGrCrt() {
		return grCrt;
	}

	public void setGrCrt(java.sql.Date grCrt) {
		this.grCrt = grCrt;
	}

	public java.sql.Date getGrMdf() {
		return grMdf;
	}

	public void setGrMdf(java.sql.Date grMdf) {
		this.grMdf = grMdf;
	}

	public String getGrStatus() {
		return grStatus;
	}

	public void setGrStatus(String grStatus) {
		this.grStatus = grStatus;
	}

	public int getuNo() {
		return uNo;
	}

	public void setuNo(int uNo) {
		this.uNo = uNo;
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

	public String getuRen() {
		return uRen;
	}

	public void setuRen(String uRen) {
		this.uRen = uRen;
	}

}
