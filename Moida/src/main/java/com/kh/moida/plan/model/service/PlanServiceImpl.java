package com.kh.moida.plan.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.moida.plan.model.dao.PlanDAO;
import com.kh.moida.plan.model.vo.Plan;
import com.kh.moida.plan.model.vo.PlanMember;

@Service
public class PlanServiceImpl implements PlanService {

	@Autowired
	private PlanDAO dao;

	@Autowired
	private SqlSessionTemplate session;

	// map key/value = month / gNo
	@Override
	public List<Plan> selectPlan(Map<String, String> map) {
		return dao.selectPlan(session, map);
	}

	@Override
	public Plan selectPlanDetail(int plNo) {
		return dao.selectPlanDetail(session, plNo);
	}

	@Override
	public List<PlanMember> selectPlanMember(int plNo) {
		return dao.selectPlanMember(session, plNo);
	}

	@Override
	public List<Plan> myPlan(Map<String,String> map) {
		return dao.myPlanList(session, map);
	}

	@Override
	public int memberCnt(int plNo) {
		return dao.memberCnt(session, plNo);
	}
	
	@Override
	public List<Plan> mainPlan(int uNo) {
		return dao.mainPlan(session, uNo);
	}

	@Override
	public int dayCnt(int plNo) {
		return dao.dayCnt(session, plNo);
	}

	@Override
	public List<Plan> planList(Map<String, String> map) {
		return dao.planList(session, map);
	}
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int addPlan(Plan plan) {
		return dao.insertPlan(session, plan);
	}

	@Override
	public List<Plan> moimPlan(int gNo) {
		return dao.moimPlan(session, gNo);
	}

	@Override
	public int insertPm(Map<String, String> map) {
		return dao.insertPm(session, map);
	}
	
	
}