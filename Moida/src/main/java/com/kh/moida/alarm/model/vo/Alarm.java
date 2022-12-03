package com.kh.moida.alarm.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class Alarm {
	private int alNo;
	private int uNo;
	private int gNo;
	private String alCont;
	private Date alDate;
	
	private String gName;
}
