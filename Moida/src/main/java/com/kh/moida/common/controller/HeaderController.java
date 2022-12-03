package com.kh.moida.common.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.moida.alarm.model.vo.Alarm;
import com.kh.moida.alarm.service.AlarmService;
import com.kh.moida.msg.model.service.MsgService;
import com.kh.moida.msg.model.vo.Msg;
import com.kh.moida.user.model.vo.User;

@RequestMapping("/header")
@Controller
public class HeaderController {

	@Autowired
	private MsgService mService;

	@Autowired
	private AlarmService aService;

	// header data : 1. Msg / 2. Alarm
	@ResponseBody
	@GetMapping("/msg")
	public ResponseEntity<List<Msg>> getMsg(HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");

		List<Msg> mList = mService.newMsg(loginUser.getuNo());

		return new ResponseEntity<List<Msg>>(mList, HttpStatus.OK);
	}

	@ResponseBody
	@GetMapping("/alarm")
	public ResponseEntity<List<Alarm>> getAlarm(HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");
		List<Alarm> aList = aService.selectAlarm(loginUser.getuNo());
		return new ResponseEntity<List<Alarm>>(aList, HttpStatus.OK);
	}

}
