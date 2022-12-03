package com.kh.moida.user.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.moida.board.model.vo.Challenge;
import com.kh.moida.moim.model.vo.Moim;
import com.kh.moida.user.model.vo.User;

public interface UserDAO {
	public User selectById(SqlSession session, String uId);

	public String duplicateId(SqlSession session, String uId);

	public String duplicateNick(SqlSession session, String uNick);

	public int insertUser(SqlSession session, User user);

	public int insertUserInterest(SqlSession session, Map<String, String> map);

	public List<String> selectAreaBySido(SqlSession session, String sido);

	public List<String> selectAreaByGugun(SqlSession session, Map<String, String> map);

	public List<Map<String, String>> selectAreaByEmd(SqlSession session, Map<String, String> map);

	public List<Moim> myMoim(SqlSession session, int uNo);

	public List<Object> interest(SqlSession session, int uNo);
	
	public int deleteInterest(SqlSession session, int uNo);
	
	public int updateUser(SqlSession session, User user);
	
	public int updatePwd(SqlSession session, User user);
	
	public int outUser(SqlSession session, User user);
	
	public List<Challenge> myChal(SqlSession session, Map<String, String> map);

	public User userNick(SqlSession session, Map<String, String> map);

	public List<User> searchUser(SqlSession session, Map<String, String> map);
	
	public User selectByUNo(SqlSession session, int uNo);
}
