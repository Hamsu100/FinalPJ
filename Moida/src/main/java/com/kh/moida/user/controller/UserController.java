package com.kh.moida.user.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.kh.moida.board.model.service.BoardService;
import com.kh.moida.board.model.vo.Board;
import com.kh.moida.board.model.vo.Challenge;
import com.kh.moida.moim.model.service.MoimService;
import com.kh.moida.moim.model.vo.Moim;
import com.kh.moida.plan.model.service.PlanService;
import com.kh.moida.plan.model.vo.Plan;
import com.kh.moida.plan.model.vo.PlanMember;
import com.kh.moida.user.model.service.UserService;
import com.kh.moida.user.model.vo.User;

@RequestMapping("/user")
@Controller
public class UserController {

	@Autowired
	private UserService service;

	@Autowired
	private BoardService bService;

	@Autowired
	private MoimService mService;

	@Autowired
	private PlanService pService;

	@GetMapping("/gugun")
	public ResponseEntity<List<String>> getGugun(@RequestParam Map<String, String> param) {
		return new ResponseEntity<List<String>>(service.getGugun(param.get("sido")), HttpStatus.OK);
	}

	@GetMapping("/emd")
	public ResponseEntity<List<String>> getEmd(@RequestParam Map<String, String> param) {
		return new ResponseEntity<List<String>>(service.getEmd(param), HttpStatus.OK);
	}

	@GetMapping("/ri")
	public ResponseEntity<List<JSONObject>> getRi(@RequestParam Map<String, String> param) {
		List<JSONObject> jsonList = new ArrayList<>();
		for (Map<String, String> map : service.getRi(param)) {
			JSONObject json = new JSONObject(map);
			jsonList.add(json);
		}
		return new ResponseEntity<List<JSONObject>>(jsonList, HttpStatus.OK);
	}

	@GetMapping("/dupId")
	public ResponseEntity<Boolean> dupId(@RequestParam("uId") String uId) {
		return new ResponseEntity<Boolean>(service.duplicateId(uId), HttpStatus.OK);
	}

	@GetMapping("/dupNick")
	public ResponseEntity<Boolean> dupNick(@RequestParam("uNick") String uNick) {
		return new ResponseEntity<Boolean>(service.duplicateId(uNick), HttpStatus.OK);
	}

	@PostMapping("/signUp")
	public String enroll(@RequestParam("uId") String uId, @RequestParam("uPwd1") String uPwd1,
			@RequestParam("uNick") String uNick, @RequestParam("uBirthValue") String uBirth,
			@RequestParam("uGender") String uGender, @RequestParam("upfile") MultipartFile upfile,
			@RequestParam("check") String[] interest, @RequestParam("aNo") String aNo, Model model,
			HttpSession session) {

		User joinUser = new User();

		try {
			Date uBirthDate = new SimpleDateFormat("yyyy-MM-dd").parse(uBirth);
			joinUser.setuBirth(uBirthDate);
			joinUser.setaNo(Integer.parseInt(aNo));
			String rootPath = session.getServletContext().getRealPath("resources");
			String savePath = rootPath + "/upload/user";
			String ren = service.fileSave(upfile, savePath);
			if (ren != null) {
				joinUser.setuRen(ren);
				joinUser.setuOri(upfile.getOriginalFilename());
			}
		} catch (ParseException e) {
			model.addAttribute("msg", "회원가입에 실패했습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		boolean dupl = service.duplicateId(uId);
		if (dupl == false) {
			model.addAttribute("msg", "중복된 아이디입니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		joinUser.setuLoginId(uId);
		joinUser.setuPwd(uPwd1);
		joinUser.setuNick(uNick);
		joinUser.setuGender(uGender);
		joinUser.setuInterest(interest);
		int result = service.join(joinUser);

		if (result > 0) {
			model.addAttribute("msg", "회원가입에 성공했습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		} else {
			model.addAttribute("msg", "회원가입에 실패했습니다.");
			model.addAttribute("location", "/");
			return "common/msg";			
		}
	}

	@PostMapping("/login")
	public String userLogin(@RequestParam Map<String, String> param, HttpSession session, HttpServletResponse resp,
			Model model) {
		User loginUser = service.login(param);
		if (loginUser == null) {
			model.addAttribute("msg", "로그인에 실패하였습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		session.setAttribute("loginUser", loginUser);
		if (param.get("saveId") != null) {
			Cookie cookie = new Cookie("saveId", loginUser.getuLoginId());
			cookie.setMaxAge(60 * 60 * 24 * 7);
			cookie.setPath("/");
			resp.addCookie(cookie);
		} else {
			Cookie cookie = new Cookie("saveId", null);
			cookie.setPath("/");
			cookie.setMaxAge(0);
			resp.addCookie(cookie);
		}
			
		if (param.get("auto") != null) {
			Cookie cookie = new Cookie("auto", loginUser.getuLoginId());
			cookie.setMaxAge(60 * 60 * 24 * 7);
			cookie.setPath("/");
			resp.addCookie(cookie);
		} else {
			Cookie cookie = new Cookie("auto", null);
			cookie.setPath("/");
			cookie.setMaxAge(0);
			resp.addCookie(cookie);
		}
		return "user/main";
	}

	@GetMapping("/logout")
	public String logOut(HttpSession session, HttpServletResponse resp) {
		session.invalidate();
		Cookie cookie = new Cookie("auto", null);
		cookie.setPath("/");
		cookie.setMaxAge(0);
		resp.addCookie(cookie);
		return "home";
	}

	@GetMapping("/myMoim")
	public String myMoim(@SessionAttribute("loginUser") User loginUser, Model model) {
		List<Moim> m = service.myMoim(loginUser.getuNo());
		model.addAttribute("mList", m);
		return "user/myMoim";
	}

	@GetMapping("/myPage")
	public String myPage(@SessionAttribute("loginUser") User loginUser) {
		return "user/myPage";
	}

	@GetMapping("/interest")
	public ResponseEntity<List<Object>> getInter(@SessionAttribute("loginUser") User loginUser) {
		List<Object> list = service.interest(loginUser.getuNo());
		return new ResponseEntity<List<Object>>(list, HttpStatus.OK);
	}

	@PostMapping("/update")
	public String userUpdate(HttpSession session, @RequestParam Map<String, String> param,
			@RequestParam("check") String[] interest, @RequestParam("upfile") MultipartFile upfile, Model model) {

		User u = (User) session.getAttribute("loginUser");
		if (u == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		int aNo = 0;
		String uNick = param.get("uNick");
		try {
			aNo = Integer.parseInt(param.get("aNo"));
		} catch (Exception e) {
			model.addAttribute("msg", "Access denied");
			model.addAttribute("location", "/user/myPage");
			return "common/msg";
		}
		u.setaNo(aNo);
		u.setuNick(uNick);

		String uOri = upfile.getOriginalFilename();
		String uRen = "";
		if (uOri.length() != 0) {
			String rootPath = session.getServletContext().getRealPath("resources");
			String savePath = rootPath + "/upload/user";
			service.fileDelete(savePath + "/" + u.getuRen());
			uRen = service.fileSave(upfile, savePath);
			u.setuOri(uOri);
			u.setuRen(uRen);
		}
		u.setuInterest(interest);
		int result = service.updateUser(u);

		if (result > 0) {
			model.addAttribute("msg", "회원 정보 수정에 성공하셨습니다!");
			model.addAttribute("location", "/user/myPage");
		} else {
			model.addAttribute("msg", "회원 정보 수정에 실패하셨습니다!");
			model.addAttribute("location", "/user/myPage");
		}

		return "common/msg";
	}

	@PostMapping("/pwdUpdate")
	public String updatePwd(@RequestParam Map<String, String> param, @SessionAttribute("loginUser") User loginUser,
			Model model) {
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		Map<String, String> map = new HashMap<>();
		map.put("uLoginId", loginUser.getuLoginId());
		map.put("uPwd", param.get("currentpassword"));
		User user = service.login(map);

		if (user == null) {
			model.addAttribute("msg", "비밀번호가 틀렸습니다!");
			model.addAttribute("location", "/user/myPage");
			return "common/msg";
		}

		String newPwd = param.get("uPwd1");

		loginUser.setuPwd(newPwd);

		int result = service.updatePwd(loginUser);

		if (result > 0) {
			model.addAttribute("msg", "비밀번호 변경에 성공하였습니다!");
			model.addAttribute("location", "/user/myPage");
		} else {
			model.addAttribute("msg", "비밀번호 변경에 실패하였습니다!");
			model.addAttribute("location", "/user/myPage");
		}
		return "common/msg";
	}

	@PostMapping("/out")
	public String out(HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		session.invalidate();
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		int result = service.outUser(loginUser);

		if (result > 0) {
			model.addAttribute("msg", "탈퇴에 성공하였습니다!");
			model.addAttribute("location", "/");
		} else {
			model.addAttribute("msg", "탈퇴에 실패하였습니다!");
			model.addAttribute("location", "/");
		}
		return "common/msg";
	}

	@GetMapping("/myGroup")
	public ResponseEntity<List<Moim>> mainGroup(@SessionAttribute("loginUser") User loginUser) {

		List<Moim> mList = service.myMoim(loginUser.getuNo());
		return new ResponseEntity<List<Moim>>(mList, HttpStatus.OK);
	}

	@GetMapping("/myBoard")
	public ResponseEntity<List<Board>> mainBoard(@RequestParam int gNo) {
		List<Board> bList = bService.mainBoard(gNo);
		return new ResponseEntity<List<Board>>(bList, HttpStatus.OK);
	}

	@GetMapping("/mySchedule")
	public String myPlan(@SessionAttribute("loginUser") User loginUser, Model model) {
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		return "user/myPlan";
	}

	@GetMapping("/planList")
	public ResponseEntity<List<Plan>> plList(@SessionAttribute("loginUser") User loginUser, @RequestParam(name = "month", required = false) Date month) {
		Map<String, String> map = new HashMap<>();
		String date = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		if (month == null) {
			Date d = new Date();
			date = sdf.format(d);
		} else {
			date = sdf.format(month);
		}
		map.put("uNo", loginUser.getuNo() + "");
		map.put("month", date);
		List<Plan> plList = pService.myPlan(map);
		return new ResponseEntity<List<Plan>>(plList, HttpStatus.OK);
	}

	@GetMapping("/chalList")
	public ResponseEntity<List<Challenge>> chalList(@SessionAttribute("loginUser") User loginUser, @RequestParam(name = "month", required = false) Date month) {
		Map<String, String> map = new HashMap<>();
		String date = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		if (month == null) {
			Date d = new Date();
			date = sdf.format(d);
		} else {
			date = sdf.format(month);
		}

		
		map.put("uNo", loginUser.getuNo() + "");
		map.put("month", date);

		List<Challenge> cList = bService.myChal(map);

		return new ResponseEntity<List<Challenge>>(cList, HttpStatus.OK);
	}

	@GetMapping("/planDetail")
	public ResponseEntity<Plan> ajaxPlan(@RequestParam("plNo") int plNo) {
		Plan p = pService.selectPlanDetail(plNo);

		return new ResponseEntity<Plan>(p, HttpStatus.OK);
	}

	@GetMapping("/cDetail")
	public ResponseEntity<Challenge> ajaxChal(@RequestParam("cNo") int cNo) {
		Challenge p = bService.chalDetail(cNo);
		return new ResponseEntity<Challenge>(p, HttpStatus.OK);
	}

	@GetMapping("/recommand")
	public ResponseEntity<List<Moim>> mainRec(@SessionAttribute("loginUser") User loginUser) {
		List<Moim> mList = mService.rec(loginUser.getuNo());
		return new ResponseEntity<List<Moim>>(mList, HttpStatus.OK);
	}

	@GetMapping("/planMember")
	public ResponseEntity<List<PlanMember>> getMember(@RequestParam("plNo") String plNo) {
		List<PlanMember> pm = pService.selectPlanMember(Integer.parseInt(plNo));
		return new ResponseEntity<List<PlanMember>>(pm, HttpStatus.OK);
	}

	@GetMapping("/mainPlan")
	public ResponseEntity<List<Plan>> getMainPlan(@SessionAttribute("loginUser") User loginUser) {
		List<Plan> list = pService.mainPlan(loginUser.getuNo());

		return new ResponseEntity<List<Plan>>(list, HttpStatus.OK);
	}
	
	@GetMapping("/dday")
	public ResponseEntity<Integer> getDday(@RequestParam("plNo") int plNo) {
		
		return new ResponseEntity<Integer>(pService.dayCnt(plNo), HttpStatus.OK);
	}
}
