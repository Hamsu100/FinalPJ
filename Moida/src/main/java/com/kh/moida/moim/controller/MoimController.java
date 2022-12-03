package com.kh.moida.moim.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.moida.alarm.model.vo.Alarm;
import com.kh.moida.alarm.service.AlarmService;
import com.kh.moida.board.model.service.BoardService;
import com.kh.moida.board.model.vo.Challenge;
import com.kh.moida.common.util.PageInfo;
import com.kh.moida.moim.model.service.MoimService;
import com.kh.moida.moim.model.vo.BanMember;
import com.kh.moida.moim.model.vo.JoinMember;
import com.kh.moida.moim.model.vo.Moim;
import com.kh.moida.moim.model.vo.MoimMember;
import com.kh.moida.plan.model.service.PlanService;
import com.kh.moida.plan.model.vo.Plan;
import com.kh.moida.plan.model.vo.PlanMember;
import com.kh.moida.user.model.vo.User;

@RequestMapping("/moim")
@Controller
public class MoimController {

	@Autowired
	private MoimService service;

	@Autowired
	private BoardService bService;

	@Autowired
	private AlarmService alService;

	@Autowired
	private PlanService pService;

	// 들어오는 parameter
	// default : uNo(session), aNo(session), page
	// need : uNo , iNo , keyword
	@GetMapping("/list")
	public String getList(@RequestParam Map<String, String> map, HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");

		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		map.put("uNo", "" + loginUser.getuNo());
		String iNo = "0";
		try {
			iNo = map.get("iNo");
			if (iNo == "0") {
				map.remove("iNo");
			}
		} catch (Exception e) {
		}

		int page = 1;

		try {
			page = Integer.parseInt(map.get("page"));
		} catch (Exception e) {
		}
		int moimCnt= service.selectMoimCnt(map);
		PageInfo pageInfo = new PageInfo(page, 10, moimCnt, 10);
		List<Moim> mList = service.selectMoim(map, pageInfo);
		model.addAttribute("moimCnt", moimCnt);
		model.addAttribute("mList", mList);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("iNo", iNo);
		return "moim/list";
	}

	@GetMapping("/insert")
	public String insertMoim(HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");

		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		return "moim/insert";
	}

	@PostMapping("/insert")
	public String insertMoim(@RequestParam("thumb") MultipartFile thumb, @RequestParam("cover") MultipartFile cover,
			@RequestParam("gName") String gName, @RequestParam("gShort") String gShort,
			@RequestParam("gIntro") String gIntro, @RequestParam("iNo") String iNo, @RequestParam("aNo") String aNo,
			Model model, HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");

		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}

		Moim iMoim = new Moim();
		iMoim.setgName(gName);
		iMoim.setgShort(gShort);
		iMoim.setgIntro(gIntro);
		try {
			iMoim.setaNo(Integer.parseInt(aNo));
			iMoim.setiNo(Integer.parseInt(iNo));
			String rootPath = session.getServletContext().getRealPath("resources");
			String savePath = rootPath + "/upload/moim";
			String coverRen = service.fileSave(cover, savePath);
			String thumbRen = service.fileSave(thumb, savePath);

			if (coverRen != null && thumbRen != null) {
				iMoim.setgCoverOri(cover.getOriginalFilename());
				iMoim.setgThumbOri(thumb.getOriginalFilename());

				iMoim.setgCoverRen(coverRen);
				iMoim.setgThumbRen(thumbRen);
			}
		} catch (Exception e) {
			model.addAttribute("msg", "모임 생성이 실패하였습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		int result = service.insertMoim(iMoim, loginUser.getuNo());

		if (result < 0) {
			model.addAttribute("msg", "모임 생성이 실패하였습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		model.addAttribute("msg", "모임 생성에 성공하였습니다.");
		model.addAttribute("location", "/");
		return "common/msg";
	}

	@GetMapping
	public String moveMoim(@RequestParam("gNo") int gNo, Model model, HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		session.setAttribute("gNo", gNo);
		String uNo = "" + loginUser.getuNo();
		Map<String, String> map = new HashMap<>();
		map.put("uNo", uNo);
		map.put("gNo", "" + gNo);
		MoimMember mm = service.selectMoimMemberDetail(map);
		session.setAttribute("mm", mm);
		List<Alarm> alList = alService.alarmGno(map);
		if (alList != null && alList.isEmpty() == false) {
			Map<String, String> resultMap = new HashMap<>();
			resultMap.put("uNo", uNo);
			resultMap.put("gNo", "" + gNo);
			int result = alService.deleteAlarm(resultMap);
			if (!(result > 0)) {
				model.addAttribute("msg", "DB 에러");
				model.addAttribute("location", "/");
				return "common/msg";
			}
		}

		List<Plan> plList = pService.moimPlan(gNo);

		model.addAttribute("plList", plList);
		model.addAttribute("notice", bService.notice(gNo));
		model.addAttribute("img", bService.img(gNo));
		model.addAttribute("after", bService.after(gNo));
		model.addAttribute("chal", bService.chal(gNo));

		return "moim/main";
	}

	@GetMapping("/member")
	public String moimMember(HttpSession session, Model model, @RequestParam Map<String, String> map) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}

		int gNo = (int) session.getAttribute("gNo");

		MoimMember mm = (MoimMember) session.getAttribute("mm");
		if (mm.getlNo() == 3) {
			model.addAttribute("msg", "access denied");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}

		Map<String, String> param = new HashMap<String, String>();
		param.put("gNo", "" + gNo);
		param.put("uNo", "" + loginUser.getuNo());
		MoimMember member = service.selectMoimMemberDetail(param);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}

		List<MoimMember> m = service.selectMoimMember(gNo);
		model.addAttribute("m", m);
		int page = 1;

		try {
			page = Integer.parseInt(map.get("page"));
		} catch (Exception e) {
		}
		int cnt = service.memCnt(gNo);
		PageInfo pageInfo = new PageInfo(page, 10, cnt, 20);

		param.put("start", "" + pageInfo.getStartList());
		param.put("end", "" + pageInfo.getEndList());

		List<MoimMember> mem = service.memberPaging(param);
		model.addAttribute("mem", mem);

		return "moim/member";
	}

	@PostMapping("/changeLeader")
	public String changeLeader(HttpSession session, @RequestParam Map<String, String> param, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}

		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> map = new HashMap<String, String>();
		map.put("gNo", "" + gNo);
		map.put("uNo", "" + loginUser.getuNo());
		MoimMember member = service.selectMoimMemberDetail(map);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}

		if (member.getlNo() != 1) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}

		map.put("newLeader", param.get("leaderName"));
		int result = service.changeLeader(map);
		if (result > 0) {
			model.addAttribute("msg", "모임장 교체에 성공하였습니다");
			model.addAttribute("location", "/moim/member");
		} else {
			model.addAttribute("msg", "DB Error");
			model.addAttribute("location", "/moim/member");
		}

		return "common/msg";
	}

	@PostMapping("/updateLv")
	public String updateLv(HttpSession session, @RequestParam("uNo") String[] uNo, @RequestParam("lNo") String[] lNo,
			Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}

		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> map = new HashMap<String, String>();
		map.put("gNo", "" + gNo);
		map.put("uNo", "" + loginUser.getuNo());
		MoimMember member = service.selectMoimMemberDetail(map);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}

		int result = service.changeLv(uNo, lNo, gNo);

		if (result > 0) {
			model.addAttribute("msg", "변경 성공");
			model.addAttribute("location", "/moim/member");
		} else {
			model.addAttribute("msg", "변경 실패");
			model.addAttribute("location", "/moim?gNo=" + gNo);
		}

		return "common/msg";
	}

	@PostMapping("/punish")
	public String punish(HttpSession session, @RequestParam Map<String, String> map, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}

		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> chkMap = new HashMap<String, String>();
		chkMap.put("gNo", "" + gNo);
		chkMap.put("uNo", "" + loginUser.getuNo());
		MoimMember member = service.selectMoimMemberDetail(chkMap);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}

		if (member.getlNo() > 2) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		Map<String, String> resultMap = new HashMap<>();

		resultMap.put("pNo", map.get("pNo"));
		resultMap.put("mgCont", map.get("mgCont"));
		resultMap.put("uNo", map.get("puNo"));
		resultMap.put("gNo", "" + gNo);

		int result = service.punish(resultMap);

		if (result > 0) {
			model.addAttribute("msg", "징계 성공");
			model.addAttribute("location", "/moim/member");
		} else {
			model.addAttribute("msg", "징계 실패");
			model.addAttribute("location", "/moim/member");
		}
		return "common/msg";
	}

	@GetMapping("/depunish")
	public String depunish(@RequestParam Map<String, String> param, HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}

		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> chkMap = new HashMap<String, String>();
		chkMap.put("gNo", "" + gNo);
		chkMap.put("uNo", "" + loginUser.getuNo());
		MoimMember member = service.selectMoimMemberDetail(chkMap);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		Map<String, String> resultMap = new HashMap<>();

		resultMap.put("uNo", param.get("uNo"));
		resultMap.put("gNo", "" + gNo);
		resultMap.put("pNo", null);
		resultMap.put("mgCont", null);

		int result = service.depunish(resultMap);

		if (result > 0) {
			model.addAttribute("msg", "징계 해제 성공");
			model.addAttribute("location", "/moim/member");
		} else {
			model.addAttribute("msg", "징계 해제 실패");
			model.addAttribute("location", "/moim/member");
		}
		return "common/msg";
	}

	@PostMapping("/ban")
	public String ban(HttpSession session, @RequestParam Map<String, String> map, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}

		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> chkMap = new HashMap<String, String>();
		chkMap.put("gNo", "" + gNo);
		chkMap.put("uNo", "" + loginUser.getuNo());
		MoimMember member = service.selectMoimMemberDetail(chkMap);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}

		Map<String, String> resultMap = new HashMap<>();

		resultMap.put("gNo", "" + gNo);
		resultMap.put("uNo", map.get("buNo"));
		resultMap.put("bmCont", map.get("banText"));

		int result = service.ban(resultMap);
		if (result > 0) {
			model.addAttribute("msg", "추방 성공");
			model.addAttribute("location", "/moim/member");
		} else {
			model.addAttribute("msg", "추방 실패");
			model.addAttribute("location", "/moim/member");
		}
		return "common/msg";
	}

	@GetMapping("/invite")
	public String moimInvite(HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}

		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> chkMap = new HashMap<String, String>();
		chkMap.put("gNo", "" + gNo);
		chkMap.put("uNo", "" + loginUser.getuNo());
		MoimMember member = service.selectMoimMemberDetail(chkMap);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}

		List<User> uList = service.inviteUser(gNo);
		model.addAttribute("uList", uList);

		return "moim/invite";
	}

	@GetMapping("/inviteMember")
	public String inviteMember(HttpSession session, Model model, @RequestParam("uNo") int uNo) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}

		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> chkMap = new HashMap<String, String>();
		chkMap.put("gNo", "" + gNo);
		chkMap.put("uNo", "" + loginUser.getuNo());
		MoimMember member = service.selectMoimMemberDetail(chkMap);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		Map<String, String> resultMap = new HashMap<>();
		resultMap.put("uNo", "" + uNo);
		resultMap.put("gNo", gNo + "");
		int result = service.insertInvite(resultMap);
		if (result > 0) {
			model.addAttribute("msg", "초대에 성공하였습니다.");
			model.addAttribute("location", "/moim/invite");
		} else {
			model.addAttribute("msg", "초대에 실패하였습니다.");
			model.addAttribute("location", "/moim/invite");
		}
		return "common/msg";
	}

	@GetMapping("/block")
	public String moimBlock(HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}

		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> chkMap = new HashMap<String, String>();
		chkMap.put("gNo", "" + gNo);
		chkMap.put("uNo", "" + loginUser.getuNo());
		MoimMember member = service.selectMoimMemberDetail(chkMap);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		List<BanMember> bmList = service.banList(gNo);
		model.addAttribute("bmList", bmList);
		return "moim/block";
	}

	@GetMapping("/cancelBan")
	public String cancelBan(@RequestParam("uNo") int uNo, HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}

		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> chkMap = new HashMap<String, String>();
		chkMap.put("gNo", "" + gNo);
		chkMap.put("uNo", "" + loginUser.getuNo());
		MoimMember member = service.selectMoimMemberDetail(chkMap);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		Map<String, String> resultMap = new HashMap<>();
		resultMap.put("uNo", "" + uNo);
		resultMap.put("gNo", "" + gNo);
		int result = service.delBan(resultMap);

		if (result > 0) {
			model.addAttribute("msg", "추방 해제 성공");
			model.addAttribute("location", "/moim/block");
		} else {
			model.addAttribute("msg", "추방 해제 실패");
			model.addAttribute("location", "/moim/block");
		}
		return "common/msg";
	}

	@GetMapping("/setting")
	public String moimSetting(HttpSession session, Model model) {
		int gNo = (int) session.getAttribute("gNo");
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		Map<String, String> chkMap = new HashMap<String, String>();
		chkMap.put("gNo", "" + gNo);
		chkMap.put("uNo", "" + loginUser.getuNo());
		MoimMember member = service.selectMoimMemberDetail(chkMap);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}

		Moim m = service.selectMoimDetail(gNo);

		model.addAttribute("m", m);

		return "moim/setting";
	}

	@PostMapping("/setting")
	public String updateMoim(HttpSession session, Model model, @RequestParam("cover") MultipartFile cover,
			@RequestParam("thumb") MultipartFile thumb, @RequestParam Map<String, String> param) {
		int gNo = (int) session.getAttribute("gNo");
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		Map<String, String> chkMap = new HashMap<String, String>();
		chkMap.put("gNo", "" + gNo);
		chkMap.put("uNo", "" + loginUser.getuNo());
		MoimMember member = service.selectMoimMemberDetail(chkMap);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		Moim m = service.selectMoimDetail(gNo);
		/*
		 * param name gName gShort gIntro thumb cover gq1 gq2 gq3 apply(가입 신청 가능 여부)
		 */
		// 원래 파일부터 지우기
		String gName = param.get("gName");
		String gShort = param.get("gShort");
		String gIntro = param.get("gIntro");
		String gQ1 = param.get("gQ1");
		String gQ2 = param.get("gQ2");
		String gQ3 = param.get("gQ3");
		String joinYN = param.get("apply");
		try {
			String rootPath = session.getServletContext().getRealPath("resources");
			String savePath = rootPath + "/upload/moim";
			if (thumb.isEmpty() == false) {
				String thumbPath = savePath + "/" + m.getgThumbRen();
				service.fileDelete(thumbPath);
				String thumbRen = service.fileSave(thumb, savePath);
				m.setgThumbOri(thumb.getOriginalFilename());
				m.setgThumbRen(thumbRen);
			}
			if (cover.isEmpty() == false) {
				String coverPath = savePath + "/" + m.getgCoverRen();
				service.fileDelete(coverPath);
				String coverRen = service.fileSave(cover, savePath);
				m.setgCoverOri(cover.getOriginalFilename());
				m.setgCoverRen(coverRen);
			}
		} catch (Exception e) {
			model.addAttribute("msg", "file error!!");
			model.addAttribute("location", "/moim/setting");
			return "common/msg";
		}

		m.setgName(gName);
		m.setgShort(gShort);
		m.setgIntro(gIntro);
		m.setgQ1(gQ1);
		m.setgQ2(gQ2);
		m.setgQ3(gQ3);
		m.setgJoinYN(joinYN);

		int result = service.updateSetting(m);

		if (result > 0) {
			model.addAttribute("msg", "설정 변경 성공");
			model.addAttribute("location", "/moim/setting");
		} else {
			model.addAttribute("msg", "설정 변경 실패");
			model.addAttribute("location", "/moim/setting");
		}

		return "common/msg";
	}

	@GetMapping("/join")
	public String moimJoin(HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}

		int gNo = (int) session.getAttribute("gNo");
		
		
		Map<String, String> chkMap = new HashMap<String, String>();
		chkMap.put("gNo", "" + gNo);
		chkMap.put("uNo", "" + loginUser.getuNo());
		MoimMember member = service.selectMoimMemberDetail(chkMap);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		Moim moim = service.selectMoimDetail(gNo);
		List<JoinMember> jmList = service.jmList(gNo);

		model.addAttribute("m", moim);
		model.addAttribute("jmList", jmList);

		return "moim/join";
	}

	@PostMapping("/apply")
	public String apply(@RequestParam Map<String, String> param, HttpSession session, Model model) {
		int gNo = (int) session.getAttribute("gNo");
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		
		JoinMember jm = new JoinMember();
		jm.setuNo(loginUser.getuNo());
		jm.setgNo(gNo);
		jm.setJmA1(param.get("text1"));
		jm.setJmA2(param.get("text2"));
		jm.setJmA3(param.get("text3"));

		int result = service.insertApply(jm);

		if (result > 0) {
			model.addAttribute("msg", "가입 신청 성공");
			model.addAttribute("location", "/moim?gNo=" + gNo);
		} else {
			model.addAttribute("msg", "가입 신청 실패");
			model.addAttribute("location", "/moim?gNo=" + gNo);
		}

		return "common/msg";
	}

	@GetMapping("/accept")
	public String accept(HttpSession session, Model model, @RequestParam("uNo") int uNo) {
		int gNo = (int) session.getAttribute("gNo");
		User loginUser = (User) session.getAttribute("loginUser");
		MoimMember mm = new MoimMember();
		Map<String, String> map = new HashMap<>();
		map.put("gNo", "" + gNo);
		map.put("uNo", "" + loginUser.getuNo());
		boolean ban = service.detBanMem(map);
		if (ban == false) {
			model.addAttribute("msg", "차단 중 입니다.");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}

		mm.setuNo(uNo);
		mm.setgNo(gNo);
		mm.setlNo(3);
		int result = service.addJoin(mm);
		if (result > 0) {
			model.addAttribute("msg", "가입 허가 성공");
			model.addAttribute("location", "/moim/join");
		} else {
			model.addAttribute("msg", "가입 허가 실패");
			model.addAttribute("location", "/moim/join");
		}

		return "common/msg";
	}

	@GetMapping("/deny")
	public String deny(HttpSession session, Model model, @RequestParam("uNo") int uNo) {
		int gNo = (int) session.getAttribute("gNo");
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}

		Map<String, String> map = new HashMap<>();

		map.put("uNo", "" + uNo);
		map.put("gNo", "" + gNo);

		int result = service.applyDeny(map);
		if (result > 0) {
			model.addAttribute("msg", "가입 거절하였습니다");
			model.addAttribute("location", "/moim/join");
		} else {
			model.addAttribute("msg", "가입 거절에 실패하였습니다.");
			model.addAttribute("location", "/moim/join");
		}
		return "common/msg";
	}

	@GetMapping("/delMoim")
	public String delMoim(HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		int gNo = (int) session.getAttribute("gNo");
		MoimMember mm = (MoimMember) session.getAttribute("mm");

		if (mm.getlNo() != 1) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			model.addAttribute("location", "/moim/setting");
			return "common/msg";
		}

		int cnt = service.memCnt(gNo);
		if (cnt != 1) {
			model.addAttribute("msg", "모임원이 존재합니다.");
			model.addAttribute("location", "/moim/setting");
			return "common/msg";
		}

		int result = service.delMoim(gNo);
		if (result > 0) {
			model.addAttribute("msg", "모임 삭제에 성공하였습니다.");
			model.addAttribute("location", "/");
		} else {
			model.addAttribute("msg", "모임 삭제에 실패하였습니다.");
			model.addAttribute("location", "/moim/setting");
		}
		session.setAttribute("mm", null);
		session.setAttribute("gNo", null);
		model.addAttribute("msg", "모임 삭제에 성공하였습니다.");
		model.addAttribute("location", "/");
		return "common/msg";
	}

	@GetMapping("/outMoim")
	public String outMoim(@RequestParam("gNo") int gNo, HttpSession session, Model model) {
		Map<String, String> resultMap = new HashMap<>();
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		resultMap.put("uNo", "" + loginUser.getuNo());
		resultMap.put("gNo", "" + gNo);
		MoimMember moim = service.selectMoimMemberDetail(resultMap);
		if (moim.getlNo() == 1) {
			model.addAttribute("msg", "모임장은 탈퇴할 수 없습니다.");
			model.addAttribute("location", "/user/myMoim");
			return "common/msg";
		}
		int result = service.deleteMoim(resultMap);
		if (result > 0) {
			model.addAttribute("msg", "탈퇴에 성공하였습니다.");
			model.addAttribute("location", "/user/myMoim");
		} else {
			model.addAttribute("msg", "탈퇴에 실패하였습니다.");
			model.addAttribute("location", "/user/myMoim");
		}

		return "common/msg";
	}

	@GetMapping("/plan")
	public String plan(HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다!");
			model.addAttribute("location", "/");
			return "common/msg";
		}

		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> chkMap = new HashMap<String, String>();
		chkMap.put("gNo", "" + gNo);
		chkMap.put("uNo", "" + loginUser.getuNo());
		MoimMember member = service.selectMoimMemberDetail(chkMap);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}

		return "moim/plan";
	}

	@GetMapping("/planList")
	public ResponseEntity<List<Plan>> planList(HttpSession session,
			@RequestParam(name = "month", required = false) Date month) {
		String date = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		int gNo = (int) session.getAttribute("gNo");
		if (month == null) {
			Date d = new Date();
			date = sdf.format(d);
		} else {
			date = sdf.format(month);
		}
		Map<String, String> resultMap = new HashMap<>();

		resultMap.put("gNo", "" + gNo);
		resultMap.put("month", date);

		List<Plan> pList = pService.planList(resultMap);
		return new ResponseEntity<List<Plan>>(pList, HttpStatus.OK);
	}

	@GetMapping("/chalList")
	public ResponseEntity<List<Challenge>> chalList(HttpSession session,
			@RequestParam(name = "month", required = false) Date month) {
		String date = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		int gNo = (int) session.getAttribute("gNo");
		if (month == null) {
			Date d = new Date();
			date = sdf.format(d);
		} else {
			date = sdf.format(month);
		}
		Map<String, String> resultMap = new HashMap<>();

		resultMap.put("gNo", "" + gNo);
		resultMap.put("month", date);

		List<Challenge> cList = bService.chalList(resultMap);

		return new ResponseEntity<List<Challenge>>(cList, HttpStatus.OK);
	}

	@PostMapping("/addPlan")
	public String addPlan(HttpSession session, @RequestParam Map<String, String> map, Model model) {
		int gNo = (int) session.getAttribute("gNo");
		String strDate = map.get("plDate") + map.get("time");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-ddhh:mm");
		Date date = null;
		double plX = 0;
		double plY = 0;
		int memLimit = 0;
		try {
			date = sdf.parse(strDate);
			plX = Double.parseDouble(map.get("x"));
			plY = Double.parseDouble(map.get("y"));
			memLimit = Integer.parseInt(map.get("limit"));
		} catch (ParseException e) {
			model.addAttribute("msg", "잘못된 요청 입니다!");
			model.addAttribute("location", "/moim/plan");
			return "common/msg";
		}
		Plan plan = new Plan();

		plan.setPlDate(date);
		plan.setPlTitle(map.get("plName"));
		plan.setPlCont(map.get("plCont"));
		plan.setPlMemLimit(memLimit);
		plan.setPlPlace(map.get("plPlace"));
		plan.setPlX(plX);
		plan.setPlY(plY);
		plan.setgNo(gNo);

		int result = pService.addPlan(plan);
		if (result > 0) {
			model.addAttribute("msg", "일정을 생성했습니다!");
			model.addAttribute("location", "/moim/plan");
		} else {
			model.addAttribute("msg", "일정 생성에 실패하였습니다.");
			model.addAttribute("location", "/moim/plan");
		}

		return "common/msg";
	}

	@PostMapping("/addChal")
	public String addChal(HttpSession session, @RequestParam Map<String, String> map, Model model) {
		int gNo = (int) session.getAttribute("gNo");
		String strDate = map.get("cDate") + map.get("time");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-ddhh:mm");
		Date date = null;
		try {
			date = sdf.parse(strDate);
		} catch (Exception e) {

		}
		Challenge chal = new Challenge();

		chal.setcCont(map.get("cCont"));
		chal.setcTitle(map.get("cTitle"));
		chal.setgNo(gNo);
		chal.setcDate(date);
		int result = bService.addChal(chal);

		if (result > 0) {
			model.addAttribute("msg", "도전 과제를 생성했습니다!");
			model.addAttribute("location", "/moim/plan");
		} else {
			model.addAttribute("msg", "도전 과제 생성에 실패하였습니다.");
			model.addAttribute("location", "/moim/plan");
		}

		return "common/msg";
	}

	@GetMapping("/planData")
	public ResponseEntity<Plan> getPlan(@RequestParam("plNo") int plNo) {
		Plan p = pService.selectPlanDetail(plNo);
		return new ResponseEntity<Plan>(p, HttpStatus.OK);
	}

	@GetMapping("/attMem")
	public ResponseEntity<List<PlanMember>> getMember(@RequestParam("plNo") int plNo) {
		List<PlanMember> pm = pService.selectPlanMember(plNo);

		return new ResponseEntity<List<PlanMember>>(pm, HttpStatus.OK);
	}

	@GetMapping("/att")
	public String attPlan(@RequestParam("plNo") int plNo, HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> map = new HashMap<>();

		map.put("uNo", "" + loginUser.getuNo());
		map.put("plNo", "" + plNo);

		int result = pService.insertPm(map);

		if (result > 0) {
			model.addAttribute("msg", "참석 성공");
			model.addAttribute("location", "/moim?gNo=" + gNo);
		} else {
			model.addAttribute("msg", "참석 실패");
			model.addAttribute("location", "/moim?gNo=" + gNo);
		}
		return "common/msg";
	}
}
