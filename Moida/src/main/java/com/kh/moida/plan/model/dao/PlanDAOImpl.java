package com.kh.moida.plan.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.moida.plan.model.vo.Plan;
import com.kh.moida.plan.model.vo.PlanMember;

@Repository
public class PlanDAOImpl implements PlanDAO {

	@Override
	public Plan selectPlanDetail(SqlSession session, int plNo) {
		return session.selectOne("planMapper.selectPlanDetail", plNo);
	}

	@Override
	public List<Plan> selectPlan(SqlSession session, Map<String, String> map) {
		return session.selectList("planMapper.selectPlan", map);
	}

	@Override
	public List<PlanMember> selectPlanMember(SqlSession session, int plNo) {
		return session.selectList("planMapper.selectPlanMember", plNo);
	}

	@Override
	public List<Plan> myPlanList(SqlSession session, Map<String, String> map) {
		return session.selectList("planMapper.myPlanList", map);
	}

	@Override
	public int memberCnt(SqlSession session, int plNo) {
		return session.selectOne("planMapper.memCnt", plNo);
	}

	@Override
	public int dayCnt(SqlSession session, int plNo) {
		return session.selectOne("planMapper.mainPlan", plNo);
	}

	@Override
	public List<Plan> mainPlan(SqlSession session, int uNo) {
		return session.selectList("planMapper.mainPlList", uNo);
	}

	@Override
	public List<Plan> planList(SqlSession session, Map<String, String> map) {
		return session.selectList("planMapper.planList", map);
	}

	@Override
	public int insertPlan(SqlSession session, Plan plan) {
		return session.insert("planMapper.insertPlan", plan);
	}

	@Override
	public List<Plan> moimPlan(SqlSession session, int gNo) {
		return session.selectList("planMapper.moimPlan", gNo);
	}

	@Override
	public int insertPm(SqlSession session, Map<String, String> map) {
		return session.insert("planMapper.insertPm", map);
	}

	@Override
	public int delPm(SqlSession session, Map<String, String> map) {
		return session.delete("planMapper.delPm", map);
	}

	@Override
	public List<String> detPm(SqlSession session, Map<String, String> map) {
		return session.selectList("planMapper.detPm", map);
	}

}
