package com.kh.moida.moim.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.moida.moim.model.vo.BanMember;
import com.kh.moida.moim.model.vo.JoinMember;
import com.kh.moida.moim.model.vo.Moim;
import com.kh.moida.moim.model.vo.MoimMember;
import com.kh.moida.user.model.vo.User;

@Repository
public class MoimDAOImpl implements MoimDAO {

	@Override
	public Moim selectMoimDetail(SqlSession session, int gNo) {
		return session.selectOne("moimMapper.selectMoimDetail", gNo);
	}

	@Override
	public List<MoimMember> selectMoimMember(SqlSession session, int gNo) {
		return session.selectList("moimMapper.selectMoimMember", gNo);
	}

	@Override
	public MoimMember selectMoimMemberDetail(SqlSession session, Map<String, String> map) {
		return session.selectOne("moimMapper.selectMoimMemberDetail", map);
	}

	@Override
	public List<Moim> selectMoim(SqlSession session, Map<String, String> map) {
		return session.selectList("moimMapper.selectMoim", map);
	}

	@Override
	public int insertMoim(SqlSession session, Moim moim) {
		session.insert("moimMapper.insertMoim", moim);
		int result = moim.getgNo();
		return result;
	}

	@Override
	public int selectMoimCnt(SqlSession session, Map<String, String> map) {
		return session.selectOne("moimMapper.selectMoimCnt", map);
	}

	@Override
	public String selectFavor(SqlSession session, Map<String, String> map) {
		return session.selectOne("moimMapper.selectFavor", map);
	}

	@Override
	public int insertFavor(SqlSession session, Map<String, String> map) {
		return session.insert("moimMapper.insertFavor", map);
	}

	@Override
	public int outMoim(SqlSession session, Map<String, String> map) {
		return session.delete("moimMapper.deleteMoim", map);
	}

	@Override
	public int selectGNoByMoim(SqlSession session, Moim moim) {
		return session.selectOne("moimMapper.selectMoimByMoim", moim);
	}

	@Override
	public int insertMoimMember(SqlSession session, MoimMember mm) {
		return session.insert("moimMapper.insertMoimMember", mm);
	}

	@Override
	public int updateMoim(SqlSession session, Moim m) {
		return session.update("moimMapper.updateMoim", m);
	}

	@Override
	public int deleteFavor(SqlSession session, Map<String, String> map) {
		return session.delete("moimMapper.deleteFavor", map);
	}

	@Override
	public List<Moim> recommand(SqlSession session, int uNo) {
		return session.selectList("moimMapper.mainRecommand", uNo);
	}

	@Override
	public String detBanMem(SqlSession session, Map<String, String> map) {
		return session.selectOne("moimMapper.detBan", map);
	}

	@Override
	public List<MoimMember> selectMoimMemberPaging(SqlSession session, Map<String, String> map) {
		return session.selectList("moimMapper.selectMoimMemberPaging", map);
	}

	@Override
	public int memCnt(SqlSession session, int gNo) {
		return session.selectOne("moimMapper.selectMoimMemberCnt", gNo);
	}

	@Override
	public int updateLv(SqlSession session, Map<String, String> map) {
		return session.update("moimMapper.updateLv",map);
	}

	@Override
	public int punish(SqlSession session, Map<String, String> map) {
		return session.update("moimMapper.punishment",map);
	}

	@Override
	public int ban(SqlSession session, Map<String, String> map) {
		return session.insert("moimMapper.ban",map);
	}

	@Override
	public List<User> inviteList(SqlSession session, int gNo) {
		return session.selectList("userMapper.inviteMember", gNo);
	}

	@Override
	public int insertInvite(SqlSession session, Map<String, String> map) {
		return session.insert("moimMapper.insertInvite", map);
	}

	@Override
	public List<BanMember> banList(SqlSession session, int gNo) {
		return session.selectList("moimMapper.banList", gNo);
	}

	@Override
	public int delBan(SqlSession session, Map<String, String> map) {
		return session.delete("moimMapper.deleteBan", map);
	}

	@Override
	public List<JoinMember> jmList(SqlSession session, int gNo) {
		return session.selectList("moimMapper.joinMemberList",gNo);
	}

	@Override
	public int apply(SqlSession session, JoinMember jm) {
		return session.insert("moimMapper.insertJm", jm);
	}

	@Override
	public int delJm(SqlSession session, Map<String, String> map) {
		return session.delete("moimMapper.delJm",map);
	}

	@Override
	public int updateSetting(SqlSession session, Moim m) {
		return session.update("moimMapper.updateMoimSetting",m);
	}

	@Override
	public int delMoim(SqlSession session, int gNo) {
		return session.delete("moimMapper.delMoim",gNo);
	}

	@Override
	public String selectJM(SqlSession session, Map<String, String> map) {
		return session.selectOne("moimMapper.selectJM", map);
	}
	
	

	
}
