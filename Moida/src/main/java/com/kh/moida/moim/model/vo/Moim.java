package com.kh.moida.moim.model.vo;

public class Moim {

	// Insert Param
	private int gNo;
	private String gName;
	private String gIntro;
	private String gShort;
	private String gThumbOri;
	private String gThumbRen;
	private String gCoverOri;
	private String gCoverRen;
	private String gJoinYN;
	private int gCnt;
	private String gQ1;
	private String gQ2;
	private String gQ3;
	private int aNo;
	private int iNo;
	// View param
	private String sido;
	private String gugun;
	private String emd;
	private String ri;
	private String iCont;
	private int memCnt;
	private String uNick;
	private int uNo;
	public Moim() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Moim(int gNo, String gName, String gIntro, String gShort, String gThumbOri, String gThumbRen,
			String gCoverOri, String gCoverRen, String gJoinYN, int gCnt, String gQ1, String gQ2, String gQ3, int aNo,
			int iNo, String sido, String gugun, String emd, String ri, String iCont, int memCnt, String uNick,
			int uNo) {
		super();
		this.gNo = gNo;
		this.gName = gName;
		this.gIntro = gIntro;
		this.gShort = gShort;
		this.gThumbOri = gThumbOri;
		this.gThumbRen = gThumbRen;
		this.gCoverOri = gCoverOri;
		this.gCoverRen = gCoverRen;
		this.gJoinYN = gJoinYN;
		this.gCnt = gCnt;
		this.gQ1 = gQ1;
		this.gQ2 = gQ2;
		this.gQ3 = gQ3;
		this.aNo = aNo;
		this.iNo = iNo;
		this.sido = sido;
		this.gugun = gugun;
		this.emd = emd;
		this.ri = ri;
		this.iCont = iCont;
		this.memCnt = memCnt;
		this.uNick = uNick;
		this.uNo = uNo;
	}
	@Override
	public String toString() {
		return "Moim [gNo=" + gNo + ", gName=" + gName + ", gIntro=" + gIntro + ", gShort=" + gShort + ", gThumbOri="
				+ gThumbOri + ", gThumbRen=" + gThumbRen + ", gCoverOri=" + gCoverOri + ", gCoverRen=" + gCoverRen
				+ ", gJoinYN=" + gJoinYN + ", gCnt=" + gCnt + ", gQ1=" + gQ1 + ", gQ2=" + gQ2 + ", gQ3=" + gQ3
				+ ", aNo=" + aNo + ", iNo=" + iNo + ", sido=" + sido + ", gugun=" + gugun + ", emd=" + emd + ", ri="
				+ ri + ", iCont=" + iCont + ", memCnt=" + memCnt + ", uNick=" + uNick + ", uNo=" + uNo + "]";
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
	public String getgIntro() {
		return gIntro;
	}
	public void setgIntro(String gIntro) {
		this.gIntro = gIntro;
	}
	public String getgShort() {
		return gShort;
	}
	public void setgShort(String gShort) {
		this.gShort = gShort;
	}
	public String getgThumbOri() {
		return gThumbOri;
	}
	public void setgThumbOri(String gThumbOri) {
		this.gThumbOri = gThumbOri;
	}
	public String getgThumbRen() {
		return gThumbRen;
	}
	public void setgThumbRen(String gThumbRen) {
		this.gThumbRen = gThumbRen;
	}
	public String getgCoverOri() {
		return gCoverOri;
	}
	public void setgCoverOri(String gCoverOri) {
		this.gCoverOri = gCoverOri;
	}
	public String getgCoverRen() {
		return gCoverRen;
	}
	public void setgCoverRen(String gCoverRen) {
		this.gCoverRen = gCoverRen;
	}
	public String getgJoinYN() {
		return gJoinYN;
	}
	public void setgJoinYN(String gJoinYN) {
		this.gJoinYN = gJoinYN;
	}
	public int getgCnt() {
		return gCnt;
	}
	public void setgCnt(int gCnt) {
		this.gCnt = gCnt;
	}
	public String getgQ1() {
		return gQ1;
	}
	public void setgQ1(String gQ1) {
		this.gQ1 = gQ1;
	}
	public String getgQ2() {
		return gQ2;
	}
	public void setgQ2(String gQ2) {
		this.gQ2 = gQ2;
	}
	public String getgQ3() {
		return gQ3;
	}
	public void setgQ3(String gQ3) {
		this.gQ3 = gQ3;
	}
	public int getaNo() {
		return aNo;
	}
	public void setaNo(int aNo) {
		this.aNo = aNo;
	}
	public int getiNo() {
		return iNo;
	}
	public void setiNo(int iNo) {
		this.iNo = iNo;
	}
	public String getSido() {
		return sido;
	}
	public void setSido(String sido) {
		this.sido = sido;
	}
	public String getGugun() {
		return gugun;
	}
	public void setGugun(String gugun) {
		this.gugun = gugun;
	}
	public String getEmd() {
		return emd;
	}
	public void setEmd(String emd) {
		this.emd = emd;
	}
	public String getRi() {
		return ri;
	}
	public void setRi(String ri) {
		this.ri = ri;
	}
	public String getiCont() {
		return iCont;
	}
	public void setiCont(String iCont) {
		this.iCont = iCont;
	}
	public int getMemCnt() {
		return memCnt;
	}
	public void setMemCnt(int memCnt) {
		this.memCnt = memCnt;
	}
	public String getuNick() {
		return uNick;
	}
	public void setuNick(String uNick) {
		this.uNick = uNick;
	}
	public int getuNo() {
		return uNo;
	}
	public void setuNo(int uNo) {
		this.uNo = uNo;
	}
	
}
