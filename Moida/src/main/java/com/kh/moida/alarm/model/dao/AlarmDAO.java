package com.kh.moida.alarm.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.moida.alarm.model.vo.Alarm;

public interface AlarmDAO {
	
	// 2. alarm 조회
	
	public List<Alarm> selectAlarm(SqlSession session, int uNo);
	
	public int insertAlarm(SqlSession session, Alarm alarm);
	
	public int deleteAlarm(SqlSession session, Map<String, String> map);
	
	public List<Alarm> selectAlarmByGNo(SqlSession session, Map<String, String> map);
}
