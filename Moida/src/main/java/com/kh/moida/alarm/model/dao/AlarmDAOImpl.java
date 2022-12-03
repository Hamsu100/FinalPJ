package com.kh.moida.alarm.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.moida.alarm.model.vo.Alarm;

@Repository
public class AlarmDAOImpl implements AlarmDAO {

	@Override
	public List<Alarm> selectAlarm(SqlSession session, int uNo) {
		return session.selectList("alarmMapper.selectAlarm", uNo);
	}

	@Override
	public int insertAlarm(SqlSession session, Alarm alarm) {
		return session.insert("alarmMapper.insertAlarm", alarm);
	}

	@Override
	public int deleteAlarm(SqlSession session, Map<String, String> map) {
		return session.delete("alarmMapper.deleteAlarm", map);
	}

	@Override
	public List<Alarm> selectAlarmByGNo(SqlSession session, Map<String, String> map) {
		return session.selectList("alarmMapper.selectAlarmByGNo", map);
	}

}
