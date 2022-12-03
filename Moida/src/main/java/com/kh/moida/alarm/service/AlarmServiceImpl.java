package com.kh.moida.alarm.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.moida.alarm.model.dao.AlarmDAO;
import com.kh.moida.alarm.model.vo.Alarm;
@Service
public class AlarmServiceImpl implements AlarmService {

	@Autowired
	private AlarmDAO dao;
	
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public List<Alarm> selectAlarm(int uNo) {
		return dao.selectAlarm(session, uNo);
	}

	@Override
	public int insertAlarm(Alarm alarm) {
		return dao.insertAlarm(session, alarm);
	}

	@Override
	public int deleteAlarm(Map<String, String> map) {
		return dao.deleteAlarm(session, map);
	}

	@Override
	public List<Alarm> alarmGno(Map<String, String> map) {
		return dao.selectAlarmByGNo(session, map);
	}

}
