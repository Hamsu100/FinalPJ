package com.kh.moida.plan.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class PlanMember {
	private int plNo;
	private int uNo;
	
	
	private String uNick;
	private String uGender;
	private int uAge;
}
