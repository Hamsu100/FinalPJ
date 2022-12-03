package com.kh.moida.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.moida.board.model.vo.Board;
import com.kh.moida.board.model.vo.Challenge;
import com.kh.moida.board.model.vo.Greet;
import com.kh.moida.board.model.vo.Reply;

public interface BoardDAO {

	// 14. 게시�? ?��?��
	public int selectBoardCnt(SqlSession session, Map<String, String> map);

	// 1. 게시�? 목록 �??�� / 조회
	// map key : gNo, bcNo, writer, title, content start, end
	public List<Board> selectBoard(SqlSession session, Map<String, String> map);

	// 2. ?��?�� 보기
	public Board selectBoardDetail(SqlSession session, int bNo);

	// 3. ?���? 조회
	public List<Reply> selectReply(SqlSession session, int bNo);

	// 4. 게시�? ?��?��
	public int insertBoard(SqlSession session, Board board);

	// 5. 게시�? ?��?��
	public int updateBoard(SqlSession session, Board board);

	// 6. 게시�? ?��?��
	public int deleteBoard(SqlSession session, int bNo);

	// 7. ?���? ?��?��
	public int insertReply(SqlSession session, Reply reply);

	// 8. ?���? ?��?��
	public int updateReply(SqlSession session, Reply reply);

	// 9. ?���? ?��?��
	public int deleteReply(SqlSession session, int rNo);

	// 10. �??��?��?�� 조회
	// map key : gNo, start, end
	public List<Greet> selectGreet(SqlSession session, Map<String, String> map);

	// 11. �??��?��?�� ?��?��
	public int insertGreet(SqlSession session, Greet greet);

	// 12. �??��?��?�� ?��?��
	public int updateGreet(SqlSession session, Greet greet);

	// 13. �??��?��?�� ?��?��
	public int deleteGreet(SqlSession session, int grNo);

	public int selectGrCnt(SqlSession session,int gNo);

	public List<Challenge> selectChalList(SqlSession sqlSession, int gNo);
	
	public int updateRdCnt(SqlSession sqlSession, Board b);
	
	public Reply selectReplyDetail(SqlSession session, int rNo);
	
	public Greet selectGrByNo(SqlSession session, int grNo);

	// 공지
	public List<Board> selectNotice(SqlSession session, int gNo);
	// 사진
	public List<Board> selectImg(SqlSession session, int gNo);
	// 후기
	public List<Board> selectAfter(SqlSession session, int gNo);
	// 과제
	public List<Board> selectChal(SqlSession session, int gNo);
	
	// 메인 보드
	public List<Board> mainBoard(SqlSession session, int gNo);
	
	// my page
	public List<Challenge> myChalList(SqlSession session, Map<String, String> map);
	public Challenge chalDetail(SqlSession session, int cNo);
	
	public List<Challenge> chalList(SqlSession session, Map<String, String> map);
	
	public int addChal(SqlSession session, Challenge chal);
}
