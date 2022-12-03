package com.kh.moida.user.model.vo;

import java.util.Arrays;
import java.util.Date;

public class User {
	private int uNo;
	private String uLoginId;
	private String uPwd;
	private Date uBirth;
	private String uGender;
	private String uNick;
	private String uOri;
	private String uRen;
	private int aNo;

	private String sido;
	private String gugun;
	private String emd;
	private String ri;
	private int uAge;
	private String[] uInterest;

	public User() {
		super();
		// TODO Auto-generated constructor stub
	}

	public User(int uNo, String uLoginId, String uPwd, Date uBirth, String uGender, String uNick, String uOri,
			String uRen, int aNo, String sido, String gugun, String emd, String ri, int uAge, String[] uInterest) {
		super();
		this.uNo = uNo;
		this.uLoginId = uLoginId;
		this.uPwd = uPwd;
		this.uBirth = uBirth;
		this.uGender = uGender;
		this.uNick = uNick;
		this.uOri = uOri;
		this.uRen = uRen;
		this.aNo = aNo;
		this.sido = sido;
		this.gugun = gugun;
		this.emd = emd;
		this.ri = ri;
		this.uAge = uAge;
		this.uInterest = uInterest;
	}

	@Override
	public String toString() {
		return "User [uNo=" + uNo + ", uLoginId=" + uLoginId + ", uPwd=" + uPwd + ", uBirth=" + uBirth + ", uGender="
				+ uGender + ", uNick=" + uNick + ", uOri=" + uOri + ", uRen=" + uRen + ", aNo=" + aNo + ", sido=" + sido
				+ ", gugun=" + gugun + ", emd=" + emd + ", ri=" + ri + ", uAge=" + uAge + ", uInterest="
				+ Arrays.toString(uInterest) + "]";
	}

	public int getuNo() {
		return uNo;
	}

	public void setuNo(int uNo) {
		this.uNo = uNo;
	}

	public String getuLoginId() {
		return uLoginId;
	}

	public void setuLoginId(String uLoginId) {
		this.uLoginId = uLoginId;
	}

	public String getuPwd() {
		return uPwd;
	}

	public void setuPwd(String uPwd) {
		this.uPwd = uPwd;
	}

	public Date getuBirth() {
		return uBirth;
	}

	public void setuBirth(Date uBirth) {
		this.uBirth = uBirth;
	}

	public String getuGender() {
		return uGender;
	}

	public void setuGender(String uGender) {
		this.uGender = uGender;
	}

	public String getuNick() {
		return uNick;
	}

	public void setuNick(String uNick) {
		this.uNick = uNick;
	}

	public String getuOri() {
		return uOri;
	}

	public void setuOri(String uOri) {
		this.uOri = uOri;
	}

	public String getuRen() {
		return uRen;
	}

	public void setuRen(String uRen) {
		this.uRen = uRen;
	}

	public int getaNo() {
		return aNo;
	}

	public void setaNo(int aNo) {
		this.aNo = aNo;
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

	public int getuAge() {
		return uAge;
	}

	public void setuAge(int uAge) {
		this.uAge = uAge;
	}

	public String[] getuInterest() {
		return uInterest;
	}

	public void setuInterest(String[] uInterest) {
		this.uInterest = uInterest;
	}

}
