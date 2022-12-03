package com.kh.moida.msg.model.vo;

import java.util.Date;

public class Msg {
	private int mNo;
	private String mContent;
	private int mSender;
	private int mReceiver;
	private Date mDate;

	private String uNick;
	private String uRen;
	private int uNo;

	public int getuNo() {
		return uNo;
	}

	public void setuNo(int uNo) {
		this.uNo = uNo;
	}


	public Msg(int mNo, String mContent, int mSender, int mReceiver, Date mDate, String uNick, String uRen, int uNo) {
		super();
		this.mNo = mNo;
		this.mContent = mContent;
		this.mSender = mSender;
		this.mReceiver = mReceiver;
		this.mDate = mDate;
		this.uNick = uNick;
		this.uRen = uRen;
		this.uNo = uNo;
	}

	public String getuRen() {
		return uRen;
	}

	public void setuRen(String uRen) {
		this.uRen = uRen;
	}


	@Override
	public String toString() {
		return "Msg [mNo=" + mNo + ", mContent=" + mContent + ", mSender=" + mSender + ", mReceiver=" + mReceiver
				+ ", mDate=" + mDate + ", uNick=" + uNick + ", uRen=" + uRen + ", uNo=" + uNo + "]";
	}

	public Msg() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getmNo() {
		return mNo;
	}

	public void setmNo(int mNo) {
		this.mNo = mNo;
	}

	public String getmContent() {
		return mContent;
	}

	public void setmContent(String mContent) {
		this.mContent = mContent;
	}

	public int getmSender() {
		return mSender;
	}

	public void setmSender(int mSender) {
		this.mSender = mSender;
	}

	public int getmReceiver() {
		return mReceiver;
	}

	public void setmReceiver(int mReceiver) {
		this.mReceiver = mReceiver;
	}

	public Date getmDate() {
		return mDate;
	}

	public void setmDate(Date mDate) {
		this.mDate = mDate;
	}

	public String getuNick() {
		return uNick;
	}

	public void setuNick(String uNick) {
		this.uNick = uNick;
	}

}
