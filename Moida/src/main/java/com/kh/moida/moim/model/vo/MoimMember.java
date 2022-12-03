package com.kh.moida.moim.model.vo;

public class MoimMember {
	// Insert Param
	private int uNo;
	private int gNo;
	private int pNo;
	private int lNo;
	private String mgCont; // 징계 사유
	// View Param
	private String uNick;
	private String uRen;
	private int uAge;
	private String uGender;
	private String lName; // 계급
	private String pName; // 징계명
	public MoimMember() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MoimMember(int uNo, int gNo, int pNo, int lNo, String mgCont, String uNick, String uRen, int uAge,
			String uGender, String lName, String pName) {
		super();
		this.uNo = uNo;
		this.gNo = gNo;
		this.pNo = pNo;
		this.lNo = lNo;
		this.mgCont = mgCont;
		this.uNick = uNick;
		this.uRen = uRen;
		this.uAge = uAge;
		this.uGender = uGender;
		this.lName = lName;
		this.pName = pName;
	}
	@Override
	public String toString() {
		return "MoimMember [uNo=" + uNo + ", gNo=" + gNo + ", pNo=" + pNo + ", lNo=" + lNo + ", mgCont=" + mgCont
				+ ", uNick=" + uNick + ", uRen=" + uRen + ", uAge=" + uAge + ", uGender=" + uGender + ", lName=" + lName
				+ ", pName=" + pName + "]";
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
	public int getpNo() {
		return pNo;
	}
	public void setpNo(int pNo) {
		this.pNo = pNo;
	}
	public int getlNo() {
		return lNo;
	}
	public void setlNo(int lNo) {
		this.lNo = lNo;
	}
	public String getMgCont() {
		return mgCont;
	}
	public void setMgCont(String mgCont) {
		this.mgCont = mgCont;
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
	public String getlName() {
		return lName;
	}
	public void setlName(String lName) {
		this.lName = lName;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	
	
}
