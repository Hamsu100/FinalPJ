package com.kh.moida.common.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kh.moida.moim.model.service.MoimService;
import com.kh.moida.moim.model.vo.Moim;
import com.kh.moida.moim.model.vo.MoimMember;
import com.kh.moida.user.model.vo.User;

@RequestMapping("/side")
@Controller
public class SideMenuController {
	// 필요한 데이터
	// 1. moim - 이름, 사진, 관심 갯수, 간단 설명
	// 2. moimMember
	// 3. Login User member 정보
	// 4. user Favor 정보

	@Autowired
	private MoimService mService;

	@GetMapping("/moim")
	public ResponseEntity<Moim> getMoim(@RequestParam("gNo") int gNo) {
		Moim m = mService.selectMoimDetail(gNo);
		return new ResponseEntity<Moim>(m, HttpStatus.OK);
	}

	@GetMapping("/member")
	public ResponseEntity<List<MoimMember>> getMember(@RequestParam("gNo") int gNo) {
		List<MoimMember> m = mService.selectMoimMember(gNo);
		return new ResponseEntity<List<MoimMember>>(m, HttpStatus.OK);
	}

	@GetMapping("/memDetail")
	public ResponseEntity<MoimMember> getUser(@RequestParam("gNo") String gNo,
			@SessionAttribute("loginUser") User loginUser, HttpSession session) {
		String uNo = "" + loginUser.getuNo();
		Map<String, String> map = new HashMap<>();
		map.put("uNo", uNo);
		map.put("gNo", gNo);
		MoimMember mm = mService.selectMoimMemberDetail(map);
		session.setAttribute("mm", mm);
		return new ResponseEntity<MoimMember>(mm, HttpStatus.OK);
	}

	@GetMapping("/favor")
	public ResponseEntity<Boolean> getFavor(@RequestParam("gNo") int gNo,
			@SessionAttribute("loginUser") User loginUser) {
		Map<String, String> map = new HashMap<>();
		map.put("gNo", "" + gNo);
		map.put("uNo", "" + loginUser.getuNo());
		return new ResponseEntity<Boolean>(mService.selectFavor(map), HttpStatus.OK);
	}

	@GetMapping("/addFavor")
	public String addFavor(@SessionAttribute("loginUser") User loginUser, @RequestParam("gNo") String gNo,
			Model model) {
		Map<String, String> map = new HashMap<>();
		map.put("gNo", gNo);
		map.put("uNo", "" + loginUser.getuNo());

		int result = mService.insertFavor(map);
		if (result > 0) {
			model.addAttribute("msg", "관심 모임 추가에 성공하였습니다.");
			model.addAttribute("location", "/moim?gNo=" + gNo);
		} else {
			model.addAttribute("msg", "관심 모임 추가에 실패하였습니다.");
			model.addAttribute("location", "/moim?gNo=" + gNo);
		}
		return "common/msg";
	}

	@GetMapping("/delFavor")
	public String delFavor(@SessionAttribute("loginUser") User loginUser, @RequestParam("gNo") String gNo,
			Model model) {
		Map<String, String> map = new HashMap<>();
		map.put("gNo", gNo);
		map.put("uNo", "" + loginUser.getuNo());

		int result = mService.deleteFavor(map);

		if (result > 0) {
			model.addAttribute("msg", "관심 모임 해제에 성공하였습니다.");
			model.addAttribute("location", "/moim?gNo=" + gNo);
		} else {
			model.addAttribute("msg", "관심 모임 해제에 실패하였습니다.");
			model.addAttribute("location", "/moim?gNo=" + gNo);
		}
		return "common/msg";
	}
	
	@GetMapping("/addJoin")
	public String addJoin(HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		int gNo=(int)session.getAttribute("gNo");
		Moim moim = mService.selectMoimDetail(gNo);
		Map<String, String> map = new HashMap<>();
		map.put("uNo", "" + loginUser.getuNo());
		map.put("gNo", "" + gNo);
		boolean detJM = mService.detJM(map);
		if (detJM ==false) {
			model.addAttribute("msg", "이미 신청하셨습니다.");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		
		if (moim.getgJoinYN().equals("N")) {
			model.addAttribute("msg", "가입 신청 불가!! 모임장에게 연락해주세요!!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		model.addAttribute("m",moim);
		return "moim/apply";
	}
	

	@GetMapping("/outJoin")
	public String outJoin(HttpSession session, Model model) {
		int gNo = (int) session.getAttribute("gNo");
		User loginUser = (User) session.getAttribute("loginUser");
		Map<String, String> map = new HashMap<>();
		map.put("gNo", ""+gNo);
		map.put("uNo", "" + loginUser.getuNo());
		MoimMember mm = (MoimMember) session.getAttribute("mm");
		
		if(mm.getlNo()==1) {
			model.addAttribute("msg", "모임장은 탈퇴할 수 없습니다.");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		int result = mService.deleteMoim(map);
		if (result > 0) {
			model.addAttribute("msg", "탈퇴에 성공하였습니다.");
			model.addAttribute("location", "/moim?gNo=" + gNo);
		} else {
			model.addAttribute("msg", "탈퇴에 실패하였습니다.");
			model.addAttribute("location", "/moim?gNo=" + gNo);
		}
		return "common/msg";
	}
	
}
