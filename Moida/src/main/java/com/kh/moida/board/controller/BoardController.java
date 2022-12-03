package com.kh.moida.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;
import com.kh.moida.board.model.service.BoardService;
import com.kh.moida.board.model.vo.Board;
import com.kh.moida.board.model.vo.Challenge;
import com.kh.moida.board.model.vo.Greet;
import com.kh.moida.board.model.vo.Reply;
import com.kh.moida.common.util.PageInfo;
import com.kh.moida.moim.model.service.MoimService;
import com.kh.moida.moim.model.vo.MoimMember;
import com.kh.moida.user.model.vo.User;

@RequestMapping("/board")
@Controller
public class BoardController {

	@Autowired
	private BoardService bService;

	@Autowired
	private MoimService mService;

	// page 8 모임 게시글 목록 조회
	// 제한 사항 : loginUser != null, loginUser.getUNo == moimMember.getUno / page :
	// list 10, page 10
	// session : loginUser
	// searchBoard Map : gNo / bcNo / searchType(writer, title, content) /
	// searchValue
	// reqParam : page / gNo / bcNo / [searchType / searchValue]
	// resp : pageInfo / boardList
	@GetMapping("/list")
	public String boardList(@RequestParam Map<String, String> param, HttpSession session, Model model) {
		// moim 내 공통 코드
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		int gNo = (int) session.getAttribute("gNo");
		param.put("gNo", "" + gNo);
		param.put("uNo", "" + loginUser.getuNo());
		MoimMember member = mService.selectMoimMemberDetail(param);
		if (loginUser == null || member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		// 여기까지
		// 실제 게시글 리스트 통신
		int page = 1;
		try {
			page = Integer.parseInt(param.get("page"));
		} catch (Exception e) {
		}
		PageInfo pageInfo = new PageInfo(page, 10, bService.boardCnt(param), 10);
		List<Board> bList = bService.boardList(pageInfo, param);
		model.addAttribute("bList", bList);
		model.addAttribute("pageInfo", pageInfo);
		// 여기까지

		String bcName = "";
		String bcNo = param.get("bcNo");

		switch (bcNo) {
		case "1":
			bcName = "공지";
			break;
		case "2":
			bcName = "자유";
			break;
		case "3":
			bcName = "사진";
			break;
		case "4":
			bcName = "정모 후기";
			break;
		case "5":
			bcName = "도전 인증";
			break;
		}
		// 모임 내 공통 resp
		model.addAttribute("bcName", bcName);
		model.addAttribute("member", member);
		model.addAttribute("bcNo", param.get("bcNo"));
		// 여기까지
		if (bcNo.equals("3")) {
			return "board/img";
		} else {
			return "board/list";
		}
	}

	// page 9 게시글 작성 이동
	// session : loginUser
	// param : gNo
	// insert 필요 항목 : bNo, 제목, 내용, 사진, 사진, 날짜 2종, 상태, 챌린지, 카테, 유저, 모임, 조회수
	// 입력 항목 : 제목 , 내용 , 사진 *2 , 챌린지, 카테
	// 자동 항목 : bNo , 날짜 , 상태, 조회수
	// 필요 Param : gNo, uNo(session), 카테
	@GetMapping("/write")
	public String boardWrite(@RequestParam Map<String, String> param, HttpSession session, Model model) {

		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> searchMem = new HashMap<>();
		searchMem.put("gNo", "" + gNo);
		searchMem.put("uNo", "" + loginUser.getuNo());
		MoimMember member = mService.selectMoimMemberDetail(searchMem);
		if (loginUser == null || member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		if (member.getpNo()>=2) {
			model.addAttribute("msg", "징계 인원입니다. 모임장에게 문의하세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		model.addAttribute("member", member);
		model.addAttribute("bcNo", param.get("bcNo"));
		return "board/write";
	}

	// Page 9 게시글 작성 -> detail view
	// reqParam : upfile, 제목, 내용, 카테고리, 챌린지
	@PostMapping("/write")
	public String boardWrite(HttpSession session, @RequestParam Map<String, String> param,
			@RequestParam("fileName") String[] fileName, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> searchMem = new HashMap<>();
		searchMem.put("gNo", "" + gNo);
		searchMem.put("uNo", "" + loginUser.getuNo());
		MoimMember member = mService.selectMoimMemberDetail(searchMem);
		if (loginUser == null || member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		if (member.getpNo()>=2) {
			model.addAttribute("msg", "징계 인원입니다. 모임장에게 문의하세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		String bcNo = param.get("bcNo");
		String bContent = param.get("content");

		Board board = new Board();
		board.setgNo(gNo);
		board.setbTitle(param.get("bTitle"));
		board.setuNo(loginUser.getuNo());
		board.setbCont(bContent);
		board.setbOri(null);
		board.setbRen(null);
		if (param.containsKey("cNo")) {
			try {
				int cNo = Integer.parseInt(param.get("cNo"));
				board.setcNo(cNo);
			} catch (Exception e) {
				model.addAttribute("msg", "도전 과제를 선택해 주세요!!");
				model.addAttribute("location", "/board/list?gNo=" + gNo + "&bcNo=" + bcNo);
				return "common/msg";
			}
		}
		if (bcNo.equals("3")) {
			if (fileName.length == 0) {
				model.addAttribute("msg", "사진을 첨부해 주세요!!");
				model.addAttribute("location", "/board/list?gNo=" + gNo + "&bcNo=" + bcNo);
				return "common/msg";
			} else {
				board.setbRen(fileName[1]);
			}
		}

		try {
			board.setBcNo(Integer.parseInt(bcNo));
		} catch (Exception e) {
			model.addAttribute("msg", "게시글 작성 실패");
			model.addAttribute("location", "/board/list?gNo=" + board.getgNo() + "&bcNo=" + board.getBcNo());
			return "common/msg";
		}

		int result = bService.saveBoard(board);
		if (result > 0) {
			model.addAttribute("msg", "게시글 작성 완료!");
			model.addAttribute("location", "/board/list?gNo=" + board.getgNo() + "&bcNo=" + board.getBcNo());
		} else {
			model.addAttribute("msg", "게시글 작성 실패");
			model.addAttribute("location", "/board/list?gNo=" + board.getgNo() + "&bcNo=" + board.getBcNo());
		}
		model.addAttribute("member", member);
		return "common/msg";
	}

	@GetMapping("/update")
	public String updateBoard(@RequestParam("bNo") int bNo, HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> searchMem = new HashMap<>();
		searchMem.put("gNo", "" + gNo);
		searchMem.put("uNo", "" + loginUser.getuNo());
		MoimMember member = mService.selectMoimMemberDetail(searchMem);
		if (loginUser == null || member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		if (member.getpNo()>=2) {
			model.addAttribute("msg", "징계 인원입니다. 모임장에게 문의하세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}

		Board b = bService.boardDetail(bNo);
		model.addAttribute("b", b);

		return "board/update";
	}

	@PostMapping("/update")
	public String boardUpdate(HttpSession session, @RequestParam Map<String, String> param,
			@RequestParam("fileName") String[] fileName, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> searchMem = new HashMap<>();
		searchMem.put("gNo", "" + gNo);
		searchMem.put("uNo", "" + loginUser.getuNo());
		MoimMember member = mService.selectMoimMemberDetail(searchMem);
		if (loginUser == null || member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		if (member.getpNo()>=2) {
			model.addAttribute("msg", "징계 인원입니다. 모임장에게 문의하세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		String bcNo = param.get("bcNo");
		String bContent = param.get("content");

		Board board = new Board();
		board.setbNo(Integer.parseInt(param.get("bNo")));
		board.setgNo(gNo);
		board.setbTitle(param.get("bTitle"));
		board.setuNo(loginUser.getuNo());
		board.setbCont(bContent);
		board.setbOri(null);
		board.setbRen(param.get("oriName"));
		if (bcNo.equals("3")) {
			if (bContent.contains("img src") == false) {
				model.addAttribute("msg", "사진을 첨부해 주세요!!");
				model.addAttribute("location", "/board/list?gNo=" + gNo + "&bcNo=" + bcNo);
				return "common/msg";
			}
			if (bContent.contains(param.get("oriName").replace("/", "")) == false || board.getbRen().length() == 0) {
				board.setbRen(fileName[1]);
			}
			if (board.getbRen() == null || board.getbRen().length() == 0) {
				model.addAttribute("msg", "게시글 수정 실패");
				model.addAttribute("location", "/board/list?gNo=" + board.getgNo() + "&bcNo=" + board.getBcNo());
				return "common/msg";
			}
		}

		try {
			board.setBcNo(Integer.parseInt(bcNo));
		} catch (Exception e) {
			model.addAttribute("msg", "게시글 수정 실패");
			model.addAttribute("location", "/board/list?gNo=" + board.getgNo() + "&bcNo=" + board.getBcNo());
			return "common/msg";
		}

		int result = bService.saveBoard(board);
		if (result > 0) {
			model.addAttribute("msg", "게시글 수정 완료!");
			model.addAttribute("location", "/board/list?gNo=" + board.getgNo() + "&bcNo=" + board.getBcNo());
		} else {
			model.addAttribute("msg", "게시글 수정 실패");
			model.addAttribute("location", "/board/list?gNo=" + board.getgNo() + "&bcNo=" + board.getBcNo());
		}
		model.addAttribute("member", member);
		return "common/msg";
	}

	@GetMapping("chalList")
	public ResponseEntity<List<Challenge>> getChList(HttpSession session) {
		List<Challenge> cList = bService.selectChalList((int) session.getAttribute("gNo"));

		return new ResponseEntity<List<Challenge>>(cList, HttpStatus.OK);
	}

	@GetMapping("greet")
	public String greet(HttpSession session, Model model, @RequestParam Map<String, String> param) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> searchMem = new HashMap<>();
		searchMem.put("gNo", "" + gNo);
		searchMem.put("uNo", "" + loginUser.getuNo());
		MoimMember member = mService.selectMoimMemberDetail(searchMem);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		// greet 글 가져오기
		int page = 1;
		int grCnt = bService.selectGrCnt(gNo);
		Map<String, String> grMap = new HashMap<>();
		PageInfo pageInfo = new PageInfo(page, 10, grCnt, 10);
		grMap.put("gNo", "" + gNo);
		grMap.put("start", "" + pageInfo.getStartList());
		grMap.put("end", "" + pageInfo.getEndList());
		List<Greet> gList = bService.selectGreet(grMap);

		model.addAttribute("gList", gList);
		model.addAttribute("grCnt", grCnt);
		model.addAttribute("page", page);
		return "board/greet";
	}

	@GetMapping("/grt")
	public ResponseEntity<List<Greet>> getGreet(HttpSession session, @RequestParam("page") int page) {
		int gNo = (int) session.getAttribute("gNo");
		int grCnt = bService.selectGrCnt(gNo);
		PageInfo pageInfo = new PageInfo(page, 10, grCnt, 10);
		Map<String, String> grMap = new HashMap<>();
		grMap.put("gNo", "" + gNo);
		grMap.put("start", "" + pageInfo.getStartList());
		grMap.put("end", "" + pageInfo.getEndList());
		List<Greet> gList = bService.selectGreet(grMap);

		return new ResponseEntity<List<Greet>>(gList, HttpStatus.OK);
	}

	@RequestMapping(value = "/upload", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile,
			HttpServletRequest request, HttpSession session) {
		JsonObject jsonObject = new JsonObject();
		String contextRoot = session.getServletContext().getRealPath("resources");
		String fileRoot = contextRoot + "/upload/board/";
		String originalFileName = multipartFile.getOriginalFilename(); // 오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 파일 확장자
		String savedFileName = UUID.randomUUID() + extension; // 저장될 파일 명

		File targetFile = new File(fileRoot + savedFileName);
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장
			jsonObject.addProperty("url", "/resources/upload/board/" + savedFileName); // contextroot + resources+
																								// 저장할 내부 폴더명
			jsonObject.addProperty("fileName", savedFileName);
			jsonObject.addProperty("responseCode", "success");

		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile); // 저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		return jsonObject.toString();
	}

	@GetMapping("/detail")
	public String boardDetail(@RequestParam Map<String,String> param, HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}		
		Enumeration<String> aa = session.getAttributeNames();
		boolean flag = false;
		while(aa.hasMoreElements()) {
			String str = aa.nextElement();
			if (str.equals("gNo")) {
				flag=true;
			}
		}
		int gNo = 0;
		try {
			gNo = Integer.parseInt(param.get("gNo"));
			session.setAttribute("gNo", gNo);
		} catch (Exception e) {
		}
		if (flag == true) {
			gNo = (int) session.getAttribute("gNo");
		}
		Map<String, String> searchMem = new HashMap<>();
		searchMem.put("gNo", "" + gNo);
		searchMem.put("uNo", "" + loginUser.getuNo());
		MoimMember member = mService.selectMoimMemberDetail(searchMem);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		int bNo = 0;
		try {
			bNo = Integer.parseInt(param.get("bNo"));
		} catch (Exception e) {
			model.addAttribute("msg", "Access Denied");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		List<Reply> r = bService.replyList(bNo);
		Board b = bService.boardDetail(bNo);
		model.addAttribute("b", b);
		model.addAttribute("rList", r);
//		r.rNo,	r.rCont,	r.rMdf,
//		r.uNo,	r.gNo,	r.bNo,
//		u.uNick,	u.uRen
		return "board/detail";
	}

	@PostMapping("/rWrite")
	public String addReply(@RequestParam Map<String, String> param, HttpSession session, Model model) {
//		seq_rNo.nextval		#{rCont},			default,
//		default,			default,			#{uNo},
//		#{bNo},				#{gNo}
		
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> searchMem = new HashMap<>();
		searchMem.put("gNo", "" + gNo);
		searchMem.put("uNo", "" + loginUser.getuNo());
		MoimMember member = mService.selectMoimMemberDetail(searchMem);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		if (member.getpNo()>=1) {
			model.addAttribute("msg", "징계 인원입니다. 모임장에게 문의하세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		
		String bNo = param.get("bNo");
		String rCont = param.get("rCont");
		int uNo = loginUser.getuNo();

		Reply r = new Reply();
		r.setgNo(gNo);
		r.setuNo(uNo);
		r.setrCont(rCont);
		try {

			r.setbNo(Integer.parseInt(bNo));
		} catch (Exception e) {
			model.addAttribute("msg", "비정상적인 접근입니다.");
			model.addAttribute("location", "/board/detail?bNo=" + bNo);
			return "common/msg";
		}
		int result = bService.saveReply(r);

		if (result > 0) {
			model.addAttribute("msg", "댓글 작성 성공하셨습니다.");
			model.addAttribute("location", "/board/detail?bNo=" + bNo);
		} else {
			model.addAttribute("msg", "댓글 작성 실패하셨습니다.");
			model.addAttribute("location", "/board/detail?bNo=" + bNo);
		}
		return "common/msg";
	}

	@GetMapping("/delete")
	public String boardDelete(HttpSession session, @RequestParam Map<String, String> param, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> searchMem = new HashMap<>();
		searchMem.put("gNo", "" + gNo);
		searchMem.put("uNo", "" + loginUser.getuNo());
		MoimMember member = mService.selectMoimMemberDetail(searchMem);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		Board b = bService.boardDetail(Integer.parseInt(param.get("bNo")));
		if (b.getuNo() != loginUser.getuNo()) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/board/detail?bNo=" + param.get("bNo"));
			return "common/msg";
		}
		String contextRoot = session.getServletContext().getRealPath("resources");
		String filePath = contextRoot + "/resources/upload/board";
		int result = bService.deleteBoard(b.getbNo(), filePath);
		if (result > 0) {
			model.addAttribute("msg", "게시글 삭제에 성공하였습니다.");
			model.addAttribute("location", "/board/list?bcNo=" + b.getBcNo());
		} else {
			model.addAttribute("msg", "게시글 삭제에 실패하였습니다.");
			model.addAttribute("location", "/board/detail?bNo=" + b.getbNo());
		}
		return "common/msg";
	}

	@PostMapping("/rUpdate")
	public String replyUpdate(HttpSession session, @RequestParam Map<String, String> param, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> searchMem = new HashMap<>();
		searchMem.put("gNo", "" + gNo);
		searchMem.put("uNo", "" + loginUser.getuNo());
		MoimMember member = mService.selectMoimMemberDetail(searchMem);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		if (member.getpNo()>=1) {
			model.addAttribute("msg", "징계 인원입니다. 모임장에게 문의하세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}

		Reply r = bService.selectReplyDetail(Integer.parseInt(param.get("rNo")));
		r.setrCont(param.get("rCont"));
		int result = bService.saveReply(r);

		if (result > 0) {
			model.addAttribute("msg", "댓글 수정에 성공하였습니다.");
			model.addAttribute("location", "/board/detail?bNo=" + r.getbNo());
		} else {
			model.addAttribute("msg", "댓글 수정에 실패하였습니다.");
			model.addAttribute("location", "/board/detail?bNo=" + r.getbNo());
		}

		return "common/msg";
	}

	@GetMapping("/rDelete")
	public String replyDelete(HttpSession session, @RequestParam Map<String, String> param, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		int gNo = (int) session.getAttribute("gNo");
		if (loginUser == null) { // 로그인 되있는지
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		Map<String, String> searchMem = new HashMap<>();
		searchMem.put("gNo", "" + gNo);
		searchMem.put("uNo", "" + loginUser.getuNo());
		MoimMember member = mService.selectMoimMemberDetail(searchMem);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		Reply r = bService.selectReplyDetail(Integer.parseInt(param.get("rNo")));

		if (r != null) {
			int result = bService.deleteReply(r.getrNo());
			if (result > 0) {
				model.addAttribute("msg", "댓글 삭제에 성공하였습니다.");
				model.addAttribute("location", "/board/detail?bNo=" + r.getbNo());
			} else {
				model.addAttribute("msg", "댓글 삭제에 실패하였습니다.");
				model.addAttribute("location", "/board/detail?bNo=" + r.getbNo());
			}
		} else {
			model.addAttribute("msg", "잘못된 접근입니다.");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		return "common/msg";
	}
	
	@PostMapping("/grAdd")
	public String grAdd(@RequestParam("grCont") String grCont, HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> searchMem = new HashMap<>();
		searchMem.put("gNo", "" + gNo);
		searchMem.put("uNo", "" + loginUser.getuNo());
		MoimMember member = mService.selectMoimMemberDetail(searchMem);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		if (member.getpNo()>=2) {
			model.addAttribute("msg", "징계 인원입니다. 모임장에게 문의하세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		
		Greet gr = new Greet();
		gr.setuNo(loginUser.getuNo());
		gr.setgNo(gNo);
		gr.setGrCont(grCont);
		
		int result = bService.writeGreet(gr);
		if (result >0) {
			model.addAttribute("msg", "가입 인사 작성에 성공하였습니다.");
			model.addAttribute("location", "/board/greet");
		} else {
			model.addAttribute("msg", "가입 인사 작성에 실패하였습니다.");
			model.addAttribute("location", "/board/greet");
		}
		return "common/msg";
	}
	
	@PostMapping("/grUpdate")
	public String grUpdate(@RequestParam("grNo") int grNo,@RequestParam("grCont") String grCont, HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		int gNo = (int) session.getAttribute("gNo");
		Map<String, String> searchMem = new HashMap<>();
		searchMem.put("gNo", "" + gNo);
		searchMem.put("uNo", "" + loginUser.getuNo());
		MoimMember member = mService.selectMoimMemberDetail(searchMem);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		if (member.getpNo()>=2) {
			model.addAttribute("msg", "징계 인원입니다. 모임장에게 문의하세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		
		Greet gr = bService.selectGrByNo(grNo);
		if (gr.getuNo() != loginUser.getuNo()) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			model.addAttribute("location", "/board/greet");
			return "common/msg";
		}
		gr.setGrCont(grCont);
		
		int result = bService.writeGreet(gr);
		
		if (result >0) {
			model.addAttribute("msg", "가입 인사 수정에 성공하였습니다.");
			model.addAttribute("location", "/board/greet");
		} else {
			model.addAttribute("msg", "가입 인사 수정에 실패하였습니다.");
			model.addAttribute("location", "/board/greet");
		}
		return "common/msg";
	}
	
	@GetMapping("/grDelete")
	public String grDelete(@RequestParam("grNo") int grNo, HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		int gNo = (int) session.getAttribute("gNo");
		if (loginUser == null) { // 로그인 되있는지
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("location", "/");
			return "common/msg";
		}
		Map<String, String> searchMem = new HashMap<>();
		searchMem.put("gNo", "" + gNo);
		searchMem.put("uNo", "" + loginUser.getuNo());
		MoimMember member = mService.selectMoimMemberDetail(searchMem);
		if (member == null) {
			model.addAttribute("msg", "모임 가입 후 이용해 주세요!");
			model.addAttribute("location", "/moim?gNo=" + gNo);
			return "common/msg";
		}
		Greet gr = bService.selectGrByNo(grNo);
		if (gr.getuNo() != loginUser.getuNo()) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			model.addAttribute("location", "/board/greet");
			return "common/msg";
		}
		
		int result = bService.deleteGreet(gr.getGrNo());
		if (result >0) {
			model.addAttribute("msg", "가입 인사 삭제에 성공하였습니다.");
			model.addAttribute("location", "/board/greet");
		} else {
			model.addAttribute("msg", "가입 인사 삭제에 실패하였습니다.");
			model.addAttribute("location", "/board/greet");
		}
		
		return "common/msg";
	}
}
