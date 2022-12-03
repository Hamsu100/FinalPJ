package com.kh.moida.board.model.vo;

import java.util.Date;

public class Board {

	// Insert Param
	private int bNo; // ok
	private String bTitle; // ok
	private String bCont; // ok
	private String bOri; // ok
	private String bRen; // ok
	private Date bMdf; // ok
	private int bRdCnt; // ok
	private int uNo; // ok
	private int cNo; // ok
	private int bcNo; // ok
	private int gNo; // ok
	// View param
	private String uNick;
	private String bcCont;
	private String cTitle;
	private String uRen;
	private int cnt;

	public Board() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Board(int bNo, String bTitle, String bCont, String bOri, String bRen, Date bMdf, int bRdCnt, int uNo,
			int cNo, int bcNo, int gNo, String uNick, String bcCont, String cTitle, String uRen, int cnt) {
		super();
		this.bNo = bNo;
		this.bTitle = bTitle;
		this.bCont = bCont;
		this.bOri = bOri;
		this.bRen = bRen;
		this.bMdf = bMdf;
		this.bRdCnt = bRdCnt;
		this.uNo = uNo;
		this.cNo = cNo;
		this.bcNo = bcNo;
		this.gNo = gNo;
		this.uNick = uNick;
		this.bcCont = bcCont;
		this.cTitle = cTitle;
		this.uRen = uRen;
		this.cnt = cnt;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	@Override
	public String toString() {
		return "Board [bNo=" + bNo + ", bTitle=" + bTitle + ", bCont=" + bCont + ", bOri=" + bOri + ", bRen=" + bRen
				+ ", bMdf=" + bMdf + ", bRdCnt=" + bRdCnt + ", uNo=" + uNo + ", cNo=" + cNo + ", bcNo=" + bcNo
				+ ", gNo=" + gNo + ", uNick=" + uNick + ", bcCont=" + bcCont + ", cTitle=" + cTitle + ", uRen=" + uRen
				+ "]";
	}

	public int getbNo() {
		return bNo;
	}

	public void setbNo(int bNo) {
		this.bNo = bNo;
	}

	public String getbTitle() {
		return bTitle;
	}

	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}

	public String getbCont() {
		return bCont;
	}

	public void setbCont(String bCont) {
		this.bCont = bCont;
	}

	public String getbOri() {
		return bOri;
	}

	public void setbOri(String bOri) {
		this.bOri = bOri;
	}

	public String getbRen() {
		return bRen;
	}

	public void setbRen(String bRen) {
		this.bRen = bRen;
	}

	public Date getbMdf() {
		return bMdf;
	}

	public void setbMdf(Date bMdf) {
		this.bMdf = bMdf;
	}

	public int getbRdCnt() {
		return bRdCnt;
	}

	public void setbRdCnt(int bRdCnt) {
		this.bRdCnt = bRdCnt;
	}

	public int getuNo() {
		return uNo;
	}

	public void setuNo(int uNo) {
		this.uNo = uNo;
	}

	public int getcNo() {
		return cNo;
	}

	public void setcNo(int cNo) {
		this.cNo = cNo;
	}

	public int getBcNo() {
		return bcNo;
	}

	public void setBcNo(int bcNo) {
		this.bcNo = bcNo;
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

	public String getBcCont() {
		return bcCont;
	}

	public void setBcCont(String bcCont) {
		this.bcCont = bcCont;
	}

	public String getcTitle() {
		return cTitle;
	}

	public void setcTitle(String cTitle) {
		this.cTitle = cTitle;
	}

	public String getuRen() {
		return uRen;
	}

	public void setuRen(String uRen) {
		this.uRen = uRen;
	}

}
