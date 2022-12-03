package com.kh.moida.plan.model.vo;

import java.util.Date;

public class Plan {
	// Insert Param
	private int plNo;
	private java.util.Date plDate;
	private String plTitle;
	private String plCont;
	private int plMemLimit;
	private String plPlace;
	private double plX;
	private double plY;
	private int gNo;

	// View Param;
	private String gName;
	private int memCnt;
	private int dDay;

	public Plan() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Plan(int plNo, Date plDate, String plTitle, String plCont, int plMemLimit, String plPlace, double plX,
			double plY, int gNo, String gName, int memCnt, int dDay) {
		super();
		this.plNo = plNo;
		this.plDate = plDate;
		this.plTitle = plTitle;
		this.plCont = plCont;
		this.plMemLimit = plMemLimit;
		this.plPlace = plPlace;
		this.plX = plX;
		this.plY = plY;
		this.gNo = gNo;
		this.gName = gName;
		this.memCnt = memCnt;
		this.dDay = dDay;
	}

	@Override
	public String toString() {
		return "Plan [plNo=" + plNo + ", plDate=" + plDate + ", plTitle=" + plTitle + ", plCont=" + plCont
				+ ", plMemLimit=" + plMemLimit + ", plPlace=" + plPlace + ", plX=" + plX + ", plY=" + plY + ", gNo="
				+ gNo + ", gName=" + gName + ", memCnt=" + memCnt + ", dDay=" + dDay + "]";
	}

	public int getPlNo() {
		return plNo;
	}

	public void setPlNo(int plNo) {
		this.plNo = plNo;
	}

	public java.util.Date getPlDate() {
		return plDate;
	}

	public void setPlDate(java.util.Date plDate) {
		this.plDate = plDate;
	}

	public String getPlTitle() {
		return plTitle;
	}

	public void setPlTitle(String plTitle) {
		this.plTitle = plTitle;
	}

	public String getPlCont() {
		return plCont;
	}

	public void setPlCont(String plCont) {
		this.plCont = plCont;
	}

	public int getPlMemLimit() {
		return plMemLimit;
	}

	public void setPlMemLimit(int plMemLimit) {
		this.plMemLimit = plMemLimit;
	}

	public String getPlPlace() {
		return plPlace;
	}

	public void setPlPlace(String plPlace) {
		this.plPlace = plPlace;
	}

	public double getPlX() {
		return plX;
	}

	public void setPlX(double plX) {
		this.plX = plX;
	}

	public double getPlY() {
		return plY;
	}

	public void setPlY(double plY) {
		this.plY = plY;
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

	public int getMemCnt() {
		return memCnt;
	}

	public void setMemCnt(int memCnt) {
		this.memCnt = memCnt;
	}

	public int getdDay() {
		return dDay;
	}

	public void setdDay(int dDay) {
		this.dDay = dDay;
	}

}
