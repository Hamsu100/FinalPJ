package com.kh.moida.user.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.moida.board.model.vo.Challenge;
import com.kh.moida.moim.model.vo.Moim;
import com.kh.moida.user.model.vo.User;

@Repository
public class UserDAOImpl implements UserDAO {

	@Override
	public User selectById(SqlSession session, String uId) {
		return session.selectOne("userMapper.selectUserById", uId);
	}

	@Override
	public List<String> selectAreaBySido(SqlSession session, String sido) {
		return session.selectList("areaMapper.selectBySido", sido);
	}

	@Override
	public List<String> selectAreaByGugun(SqlSession session, Map<String, String> map) {
		return session.selectList("areaMapper.selectByGugun", map);
	}

	@Override
	public List<Map<String, String>> selectAreaByEmd(SqlSession session, Map<String, String> map) {
		return session.selectList("areaMapper.selectByEmd", map);
	}

	@Override
	public String duplicateId(SqlSession session, String uId) {
		return session.selectOne("userMapper.duplicateId", uId);
	}

	@Override
	public String duplicateNick(SqlSession session, String uNick) {
		return session.selectOne("userMapper.duplicateNick", uNick);
	}

	@Override
	public int insertUser(SqlSession session, User user) {
		return session.insert("userMapper.insertUser", user);
	}

	@Override
	public int insertUserInterest(SqlSession session, Map<String, String> map) {
		return session.insert("userMapper.insertUserInterest", map);
	}

	@Override
	public List<Moim> myMoim(SqlSession session, int uNo) {
		return session.selectList("moimMapper.selectMyGroup", uNo);
	}

	@Override
	public List<Object> interest(SqlSession session, int uNo) {
		return session.selectList("userMapper.selectInterest", uNo);
	}

	@Override
	public int deleteInterest(SqlSession session, int uNo) {
		return session.delete("userMapper.deleteInterest", uNo);
	}

	@Override
	public int updateUser(SqlSession session, User user) {
		return session.update("userMapper.updateUser", user);
	}

	@Override
	public int updatePwd(SqlSession session, User user) {
		return session.update("userMapper.updatePwd", user);
	}

	@Override
	public int outUser(SqlSession session, User user) {
		return session.update("userMapper.outUser", user);
	}

	@Override
	public List<Challenge> myChal(SqlSession session, Map<String, String> map) {
		return session.selectList("boardMapper.myChalList");
	}

	@Override
	public User userNick(SqlSession session, Map<String, String> map) {
		return session.selectOne("userMapper.userNick", map);
	}

	@Override
	public List<User> searchUser(SqlSession session, Map<String, String> map) {
		return session.selectList("userMapper.searchUser",map);
	}

	@Override
	public User selectByUNo(SqlSession session, int uNo) {
		return session.selectOne("userMapper.selectByUNo", uNo);
	}
	
	
	

}
