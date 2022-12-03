package com.kh.moida.alarm.service;

import java.util.List;
import java.util.Map;

import com.kh.moida.alarm.model.vo.Alarm;

public interface AlarmService {
	
	public List<Alarm> selectAlarm(int uNo);
	
	public int insertAlarm(Alarm alarm);
	
	public int deleteAlarm(Map<String, String> map);
	
	public List<Alarm> alarmGno(Map<String, String> map);
	
}
