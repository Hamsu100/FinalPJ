package com.kh.moida.moim.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.moida.moim.model.vo.BanMember;
import com.kh.moida.moim.model.vo.JoinMember;
import com.kh.moida.moim.model.vo.Moim;
import com.kh.moida.moim.model.vo.MoimMember;
import com.kh.moida.user.model.vo.User;

public interface MoimDAO {
	// need function
	// 1. basic Data for moim
	public Moim selectMoimDetail(SqlSession session, int gNo);

	// 2. member Data for moim
	public List<MoimMember> selectMoimMember(SqlSession session, int gNo);

	// 3. moim member chk
	public MoimMember selectMoimMemberDetail(SqlSession session, Map<String, String> map);

	// 4. moim List map k/v : category, keyword, pageInfo
	public List<Moim> selectMoim(SqlSession session, Map<String, String> map);

	// 5. insert moim
	public int insertMoim(SqlSession session, Moim moim);

	public int selectMoimCnt(SqlSession session, Map<String, String> map);

	public String selectFavor(SqlSession session, Map<String, String> map);

	public int insertFavor(SqlSession session, Map<String, String> map);

	public int outMoim(SqlSession session, Map<String, String> map);

	public int selectGNoByMoim(SqlSession session, Moim moim);

	public int insertMoimMember(SqlSession session, MoimMember mm);

	public int updateMoim(SqlSession session, Moim m);

	public int deleteFavor(SqlSession session, Map<String, String> map);
	
	public List<Moim> recommand(SqlSession session, int uNo);
	
	public String detBanMem(SqlSession session, Map<String, String> map);
	
	public List<MoimMember> selectMoimMemberPaging(SqlSession session, Map<String, String> map);
	public int memCnt(SqlSession session, int gNo);
	
	public int updateLv(SqlSession session, Map<String, String> map);
	
	public int punish(SqlSession session, Map<String, String> map);

	public int ban(SqlSession session, Map<String, String> map);
	
	public List<User> inviteList(SqlSession session, int gNo);
	
	public int insertInvite(SqlSession session, Map<String, String> map);
	
	public List<BanMember> banList(SqlSession session, int gNo);
	public int delBan(SqlSession session, Map<String, String> map);
	
	public List<JoinMember> jmList(SqlSession session, int gNo);
	public int apply(SqlSession session, JoinMember jm);
	
	public int delJm(SqlSession session, Map<String,String> map);
	
	public int updateSetting(SqlSession session, Moim m);
	
	public int delMoim(SqlSession session , int gNo);
	
	public String selectJM(SqlSession session, Map<String, String> map);
}