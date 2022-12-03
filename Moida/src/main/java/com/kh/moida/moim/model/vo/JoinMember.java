package com.kh.moida.moim.model.vo;

public class JoinMember {
	private int gNo;
	private int uNo;
	private String jmA1;
	private String jmA2;
	private String jmA3;

	private String gQ1;
	private String gQ2;
	private String gQ3;

	private String uNick;
	private int uAge;
	private String uGender;
	private String uRen;

	public String getuRen() {
		return uRen;
	}

	public void setuRen(String uRen) {
		this.uRen = uRen;
	}

	private String sido;
	private String gugun;
	private String emd;
	private String ri;

	public JoinMember() {
		super();
	}


	public JoinMember(int gNo, int uNo, String jmA1, String jmA2, String jmA3, String gQ1, String gQ2, String gQ3,
			String uNick, int uAge, String uGender, String uRen, String sido, String gugun, String emd, String ri) {
		super();
		this.gNo = gNo;
		this.uNo = uNo;
		this.jmA1 = jmA1;
		this.jmA2 = jmA2;
		this.jmA3 = jmA3;
		this.gQ1 = gQ1;
		this.gQ2 = gQ2;
		this.gQ3 = gQ3;
		this.uNick = uNick;
		this.uAge = uAge;
		this.uGender = uGender;
		this.uRen = uRen;
		this.sido = sido;
		this.gugun = gugun;
		this.emd = emd;
		this.ri = ri;
	}

	@Override
	public String toString() {
		return "JoinMember [gNo=" + gNo + ", uNo=" + uNo + ", jmA1=" + jmA1 + ", jmA2=" + jmA2 + ", jmA3=" + jmA3
				+ ", gQ1=" + gQ1 + ", gQ2=" + gQ2 + ", gQ3=" + gQ3 + ", uNick=" + uNick + ", uAge=" + uAge
				+ ", uGender=" + uGender + ", sido=" + sido + ", gugun=" + gugun + ", emd=" + emd + ", ri=" + ri + "]";
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

	public String getJmA1() {
		return jmA1;
	}

	public void setJmA1(String jmA1) {
		this.jmA1 = jmA1;
	}

	public String getJmA2() {
		return jmA2;
	}

	public void setJmA2(String jmA2) {
		this.jmA2 = jmA2;
	}

	public String getJmA3() {
		return jmA3;
	}

	public void setJmA3(String jmA3) {
		this.jmA3 = jmA3;
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

}
