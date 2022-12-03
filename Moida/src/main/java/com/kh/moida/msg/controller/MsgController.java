package com.kh.moida.msg.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.moida.msg.model.service.MsgService;
import com.kh.moida.msg.model.vo.Msg;
import com.kh.moida.user.model.service.UserService;
import com.kh.moida.user.model.vo.User;

@RequestMapping("/msg")
@Controller
public class MsgController {

	@Autowired
	private MsgService service;

	@Autowired
	private UserService uService;

	@GetMapping("/list")
	public String msgList(HttpSession session, Model model, @RequestParam Map<String, String> param) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		param.put("uNo", "" + loginUser.getuNo());
		List<Msg> mList = service.selectMsg(param);
		if (mList == null) {
			model.addAttribute("msg", "관리팀으로 연락 부탁합니다.(DB update Error)");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		model.addAttribute("mList", mList);

		return "msg/list";
	}

	@PostMapping("/delete")
	public String deleteMsg(HttpSession session, Model model, @RequestParam("chk") Integer[] param) {
		for (Integer s : param) {
			int result = service.deleteMsg(s);
			if (result < 0) {
				model.addAttribute("msg", "삭제에 실패했습니다");
				model.addAttribute("location", "/msg/list");
				return "common/msg";
			}
		}
		model.addAttribute("msg", "삭제에 성공했습니다.");
		model.addAttribute("location", "/msg/list");
		return "common/msg";
	}

	@GetMapping("/detail")
	public String datailMsg(HttpSession session, Model model, @RequestParam("mNo") int mNo) {
		User loginUser = (User) session.getAttribute("loginUser");

		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}

		Msg m = service.selectMsgDetail(mNo);
		model.addAttribute("m", m);
		return "msg/detail";
	}

	@GetMapping("/send")
	public String resend(HttpSession session, Model model, @RequestParam Map<String, String> param) {
		User loginUser = (User) session.getAttribute("loginUser");

		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		param.put("loginUser", "" + loginUser.getuNo());
		if (param.containsKey("uNo")) {
			User send = uService.userNick(param);
			model.addAttribute("send", send);
		}
		List<User> uList = uService.searchUser(param);
		model.addAttribute("u", uList);
		return "msg/send";
	}

	@GetMapping("/userSeach")
	public ResponseEntity<List<User>> getUser(HttpSession session, @RequestParam Map<String, String> map) {
		User loginUser = (User) session.getAttribute("loginUser");
		map.put("loginUser", "" + loginUser.getuNo());
		List<User> uList = uService.searchUser(map);
		return new ResponseEntity<List<User>>(uList, HttpStatus.OK);
	}

	@PostMapping("/send")
	public String sendMsg(HttpSession session, @RequestParam Map<String, String> param, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		Msg m = new Msg();
		m.setmSender(loginUser.getuNo());
		m.setmContent(param.get("sendText"));
		try {
			m.setmReceiver(Integer.parseInt(param.get("selectId")));
		} catch (Exception e) {
			model.addAttribute("msg", "Access denied");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		int result = service.insertMsg(m);
		if (result > 0) {
			model.addAttribute("msg", "메세지 작성 성공");
			model.addAttribute("location", "/");
		} else {
			model.addAttribute("msg", "메세지 작성 실패");
			model.addAttribute("location", "/");
		}
		return "common/msg";
	}
}
