package com.kh.moida.moim.model.vo;

import java.util.Date;

public class BanMember {
	private int gNo;
	private int uNo;
	private String bmCont;
	private Date bDate;
	
	private String uNick;
	private int uAge;
	private String uGender;
	public BanMember() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BanMember(int gNo, int uNo, String bmCont, Date bDate, String uNick, int uAge, String uGender) {
		super();
		this.gNo = gNo;
		this.uNo = uNo;
		this.bmCont = bmCont;
		this.bDate = bDate;
		this.uNick = uNick;
		this.uAge = uAge;
		this.uGender = uGender;
	}
	@Override
	public String toString() {
		return "BanMember [gNo=" + gNo + ", uNo=" + uNo + ", bmCont=" + bmCont + ", bDate=" + bDate + ", uNick=" + uNick
				+ ", uAge=" + uAge + ", uGender=" + uGender + "]";
	}
	public int getgNo() {
		return gNo;
	}
	public void setgNo(int gNo) {
		this.gNo = gNo;
	}
	public int getuNo() {
		return uNo;
	}
	public void setuNo(int uNo) {
		this.uNo = uNo;
	}
	public String getBmCont() {
		return bmCont;
	}
	public void setBmCont(String bmCont) {
		this.bmCont = bmCont;
	}
	public Date getbDate() {
		return bDate;
	}
	public void setbDate(Date bDate) {
		this.bDate = bDate;
	}
	public String getuNick() {
		return uNick;
	}
	public void setuNick(String uNick) {
		this.uNick = uNick;
	}
	public int getuAge() {
		return uAge;
	}
	public void setuAge(int uAge) {
		this.uAge = uAge;
	}
	public String getuGender() {
		return uGender;
	}
	public void setuGender(String uGender) {
		this.uGender = uGender;
	}
	
}
