package com.kh.moida.plan.model.service;

import java.util.List;
import java.util.Map;

import com.kh.moida.plan.model.vo.Plan;
import com.kh.moida.plan.model.vo.PlanMember;

public interface PlanService {
	
	public List<Plan> selectPlan(Map<String,String> map);
	
	public Plan selectPlanDetail(int plNo);
	
	public List<PlanMember> selectPlanMember(int plNo);
	
	public List<Plan> myPlan(Map<String,String> map);
	
	public int memberCnt(int plNo);
	
	public List<Plan> mainPlan(int uNo);
	
	public int dayCnt(int plNo);
	
	public List<Plan> planList(Map<String, String> map);
	
	public int addPlan(Plan plan);
	
	public List<Plan> moimPlan(int gNo);
	
	public int insertPm (Map<String, String> map);
}
