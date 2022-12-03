package com.kh.moida.msg.model.service;

import java.util.List;
import java.util.Map;

import com.kh.moida.msg.model.vo.Msg;

public interface MsgService {
	public List<Msg> selectMsg(Map<String,String> map);
	public List<Msg> newMsg(int uNo);
	public Msg selectMsgDetail(int mNo);
	
	public int insertMsg(Msg msg);
	
	public int deleteMsg(int mNo);
}
