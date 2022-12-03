package com.kh.moida.msg.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.moida.msg.model.vo.Msg;

@Repository
public class MsgDAOImpl implements MsgDAO {

	@Override
	public List<Msg> selectMsg(SqlSession session, Map<String,String> map) {
		return session.selectList("msgMapper.selectMsg", map);
	}

	@Override
	public Msg selectMsgDetail(SqlSession session, int mNo) {
		return session.selectOne("msgMapper.selectMsgDetail", mNo);
	}

	@Override
	public int insertMsg(SqlSession session, Msg msg) {
		return session.insert("msgMapper.insertMsg", msg);
	}

	@Override
	public int updateYN(SqlSession session, int mNo) {
		return session.update("msgMapper.updateMsg", mNo);
	}

	@Override
	public List<Msg> newMsg(SqlSession session, int uNo) {
		// TODO Auto-generated method stub
		return session.selectList("msgMapper.newMsg", uNo);
	}

	@Override
	public int deleteMsg(SqlSession session, int mNo) {
		return session.delete("msgMapper.deleteMsg",mNo);
	}

}
