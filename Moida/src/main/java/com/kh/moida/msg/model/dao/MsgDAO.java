package com.kh.moida.msg.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.moida.msg.model.vo.Msg;

public interface MsgDAO {
	
	// msg 기능
	/*
	 * 1. msg 리스트 조회
	 * 2. msg 상세 조회
	 * 3. msg 센딩
	 */
	
	public List<Msg> selectMsg(SqlSession session, Map<String,String> map);
	public Msg selectMsgDetail(SqlSession session, int mNo);
	public int insertMsg(SqlSession session, Msg msg);
	public int updateYN(SqlSession session, int getmNo);
	public List<Msg> newMsg(SqlSession session, int uNo);
	public int deleteMsg(SqlSession session, int mNo);
}
