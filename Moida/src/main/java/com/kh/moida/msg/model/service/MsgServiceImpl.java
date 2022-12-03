package com.kh.moida.msg.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.moida.msg.model.dao.MsgDAO;
import com.kh.moida.msg.model.vo.Msg;

@Service
public class MsgServiceImpl implements MsgService {

	@Autowired
	private MsgDAO dao;
	
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public List<Msg> selectMsg(Map<String,String> map) {
		List<Msg> mList = dao.selectMsg(session, map);
		for (Msg m : mList) {
			int result = dao.updateYN(session, m.getmNo());
			if (result < 0) {
				return null;
			}
		}
		return mList;
	}

	@Override
	public Msg selectMsgDetail(int mNo) {
		return dao.selectMsgDetail(session, mNo);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertMsg(Msg msg) {
		return dao.insertMsg(session, msg);
	}

	@Override
	public List<Msg> newMsg(int uNo) {
		return dao.newMsg(session, uNo);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteMsg(int mNo) {
		int result = dao.deleteMsg(session, mNo);
		return result;
	}
	
}
