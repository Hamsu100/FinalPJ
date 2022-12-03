package com.kh.moida.board.model.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.moida.board.model.dao.BoardDAO;
import com.kh.moida.board.model.vo.Board;
import com.kh.moida.board.model.vo.Challenge;
import com.kh.moida.board.model.vo.Greet;
import com.kh.moida.board.model.vo.Reply;
import com.kh.moida.common.util.PageInfo;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDAO dao;

	@Autowired
	private SqlSessionTemplate sqlSession;

	// 1. 게시�? �??�� / 조회 ?�� 개수
	// Param : gNo, bcNo, searchType, searchValue
	@Override
	public int boardCnt(Map<String, String> map) {
		Map<String, String> searchMap = new HashMap<String, String>();

		searchMap.put("gNo", map.get("gNo"));
		searchMap.put("bcNo", map.get("bcNo"));
		if (map.get("searchType") != null) {
			searchMap.put(map.get("searchType"), map.get("searchValue"));
		}

		return dao.selectBoardCnt(sqlSession, searchMap);
	}

	// 2. 게시�? 목록 �??�� / 조회
	// param : gNo bcNo searchType searchValue Page Start / end
	@Override
	public List<Board> boardList(PageInfo pageInfo, Map<String, String> map) {
		Map<String, String> searchMap = new HashMap<String, String>();

		searchMap.put("gNo", map.get("gNo"));
		searchMap.put("bcNo", map.get("bcNo"));
		if (map.containsKey("searchType")) {
			if (map.containsKey("searchValue")) {
				searchMap.put(map.get("searchType"), map.get("searchValue"));
			}
		}
		searchMap.put("start", "" + pageInfo.getStartList());
		searchMap.put("end", "" + pageInfo.getEndList());
		return dao.selectBoard(sqlSession, searchMap);
	}

	// 3. 게시�? ?��?�� 조회
	// logic : 게시�? ?��?��?�� 불러?���? + rd ?��?��
	@Override
	@Transactional(rollbackFor = Exception.class)
	public Board boardDetail(int bNo) {
		Board b = dao.selectBoardDetail(sqlSession, bNo);
		b.setbRdCnt(b.getbRdCnt() + 1);
		dao.updateRdCnt(sqlSession, b);
		return b;
	}

	// 4. ?���? 조회
	@Override
	public List<Reply> replyList(int bNo) {
		return dao.selectReply(sqlSession, bNo);
	}

	// 5. 게시�? ?��?�� / ?��?��
	// bNo != 0 ?��?�� / == 0 ?��?��
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int saveBoard(Board board) {
		int result = 0;

		if (board.getbNo() != 0) {
			result = dao.updateBoard(sqlSession, board);
		} else {
			result = dao.insertBoard(sqlSession, board);
		}
		return result;
	}

	// 6. 게시�? ?��?��
	//
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int deleteBoard(int bNo, String rootPath) {
		Board board = dao.selectBoardDetail(sqlSession, bNo);
		if (board.getbRen() != null) {
			fileDelete(rootPath + "\\" + board.getbRen());
		}
		return dao.deleteBoard(sqlSession, bNo);
	}

	// 7. ?���? ?��?�� / ?��?��
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int saveReply(Reply reply) {
		int result = 0;
		if (reply.getrNo() != 0) {
			result = dao.updateReply(sqlSession, reply);
		} else {
			result = dao.insertReply(sqlSession, reply);
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int deleteReply(int rNo) {
		return dao.deleteReply(sqlSession, rNo);
	}

	@Override
	public List<Greet> selectGreet(Map<String, String> map) {
		return dao.selectGreet(sqlSession, map);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int writeGreet(Greet greet) {
		int result = 0;
		if (greet.getGrNo() != 0) {
			result = dao.updateGreet(sqlSession, greet);
		} else {
			result = dao.insertGreet(sqlSession, greet);
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int deleteGreet(int grNo) {
		return dao.deleteGreet(sqlSession, grNo);
	}

	@Override
	public String fileSave(MultipartFile upfile, String savePath) {
		File folder = new File(savePath);

		if (folder.exists() == false) {
			folder.mkdir();
		}

		String ori = upfile.getOriginalFilename();

		String ren = new SimpleDateFormat("yyyyMMdd_hhmmss").format(new Date()) + new Random().nextInt(10)
				+ new Random().nextInt(10) + ori.substring(ori.lastIndexOf("."));

		String renPath = savePath + "/" + ren;

		try {
			upfile.transferTo(new File(renPath));
		} catch (Exception e) {
			return null;
		}
		return ren;
	}

	@Override
	public void fileDelete(String filePath) {
		File file = new File(filePath);
		if (file.exists()) {
			file.delete();
		}
	}

	@Override
	public int selectGrCnt(int gNo) {
		return dao.selectGrCnt(sqlSession, gNo);
	}

	@Override
	public List<Challenge> selectChalList(int gNo) {
		return dao.selectChalList(sqlSession, gNo);
	}

	@Override
	public Reply selectReplyDetail(int rNo) {
		return dao.selectReplyDetail(sqlSession, rNo);
	}

	@Override
	public Greet selectGrByNo(int grNo) {
		return dao.selectGrByNo(sqlSession, grNo);
	}

	@Override
	public List<Board> notice(int gNo) {
		return dao.selectNotice(sqlSession, gNo);
	}

	@Override
	public List<Board> img(int gNo) {
		return dao.selectImg(sqlSession, gNo);
	}

	@Override
	public List<Board> after(int gNo) {
		return dao.selectAfter(sqlSession, gNo);
	}

	@Override
	public List<Board> chal(int gNo) {
		return dao.selectChal(sqlSession, gNo);
	}

	@Override
	public List<Board> mainBoard(int gNo) {
		return dao.mainBoard(sqlSession, gNo);
	}

	@Override
	public List<Challenge> myChal(Map<String, String> map) {
		return dao.myChalList(sqlSession, map);
	}

	@Override
	public Challenge chalDetail(int cNo) {
		return dao.chalDetail(sqlSession, cNo);
	}

	@Override
	public List<Challenge> chalList(Map<String, String> map) {
		return dao.chalList(sqlSession, map);
	}

	@Override
	public int addChal(Challenge chal) {
		return dao.addChal(sqlSession, chal);
	}


}
