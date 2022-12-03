package com.kh.moida.plan.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.moida.plan.model.vo.Plan;
import com.kh.moida.plan.model.vo.PlanMember;

public interface PlanDAO {
	
	// 1. plan Data for moim parma : gNo, month
	// map key / value : gNo / #{gNo}, month / #{month}
	public List<Plan> selectPlan(SqlSession session, Map<String, String> map);

	// 2. plan Detail for moim
	public Plan selectPlanDetail(SqlSession session, int plNo);
	
	// 3. planMember
	public List<PlanMember> selectPlanMember(SqlSession session, int plNo);
	
	// 4. myPlan List
	public List<Plan> myPlanList(SqlSession session, Map<String,String> map);
	
	public int memberCnt(SqlSession session, int plNo);
	
	public int dayCnt(SqlSession session, int plNo);
	
	public List<Plan> mainPlan(SqlSession session, int uNo);
	
	public List<Plan> planList(SqlSession session, Map<String, String> map);
	
	public int insertPlan(SqlSession session, Plan plan);
	
	public List<Plan> moimPlan(SqlSession session, int gNo);
	
	public int insertPm(SqlSession session, Map<String, String> map);
	
	public int delPm(SqlSession session, Map<String, String> map);
	
	public List<String> detPm(SqlSession session, Map<String, String> map);
}
