package com.kh.moida.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.moida.board.model.vo.Board;
import com.kh.moida.board.model.vo.Challenge;
import com.kh.moida.board.model.vo.Greet;
import com.kh.moida.board.model.vo.Reply;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Override
	public int selectBoardCnt(SqlSession session, Map<String, String> map) {
		return session.selectOne("boardMapper.selectBoardCnt", map);
	}

	@Override
	public List<Board> selectBoard(SqlSession session, Map<String, String> map) {
		return session.selectList("boardMapper.selectBoard", map);
	}

	@Override
	public Board selectBoardDetail(SqlSession session, int bNo) {
		return session.selectOne("boardMapper.selectBoardDetail", bNo);
	}

	@Override
	public List<Reply> selectReply(SqlSession session, int bNo) {
		return session.selectList("boardMapper.selectReply", bNo);
	}

	@Override
	public int insertBoard(SqlSession session, Board board) {
		return session.insert("boardMapper.insertBoard", board);
	}

	@Override
	public int updateBoard(SqlSession session, Board board) {
		return session.update("boardMapper.updateBoard", board);
	}

	@Override
	public int deleteBoard(SqlSession session, int bNo) {
		return session.update("boardMapper.deleteBoard", bNo);
	}

	@Override
	public int insertReply(SqlSession session, Reply reply) {
		return session.insert("boardMapper.insertReply", reply);
	}

	@Override
	public int updateReply(SqlSession session, Reply reply) {
		return session.update("boardMapper.updateReply", reply);
	}

	@Override
	public int deleteReply(SqlSession session, int rNo) {
		return session.update("boardMapper.deleteReply", rNo);
	}

	@Override
	public List<Greet> selectGreet(SqlSession session, Map<String, String> map) {
		return session.selectList("boardMapper.selectGreet", map);
	}

	@Override
	public int insertGreet(SqlSession session, Greet greet) {
		return session.insert("boardMapper.insertGreet", greet);
	}

	@Override
	public int updateGreet(SqlSession session, Greet greet) {
		return session.update("boardMapper.updateGreet", greet);
	}

	@Override
	public int deleteGreet(SqlSession session, int grNo) {
		return session.update("boardMapper.deleteGreet", grNo);
	}

	@Override
	public int selectGrCnt(SqlSession session, int gNo) {
		return session.selectOne("boardMapper.selectGrCnt", gNo);
	}

	@Override
	public List<Challenge> selectChalList(SqlSession sqlSession, int gNo) {
		return sqlSession.selectList("boardMapper.selectChalList", gNo);
	}

	@Override
	public int updateRdCnt(SqlSession sqlSession, Board b) {
		return sqlSession.update("boardMapper.rdBoard",b);
	}

	@Override
	public Reply selectReplyDetail(SqlSession session, int rNo) {
		return session.selectOne("boardMapper.selectReplyDetail", rNo);
	}

	@Override
	public Greet selectGrByNo(SqlSession session, int grNo) {
		return session.selectOne("boardMapper.selectGrByNo", grNo);
	}

	@Override
	public List<Board> selectNotice(SqlSession session, int gNo) {
		return session.selectList("boardMapper.selectNotice", gNo);
	}

	@Override
	public List<Board> selectImg(SqlSession session, int gNo) {
		return session.selectList("boardMapper.selectImg", gNo);
	}

	@Override
	public List<Board> selectAfter(SqlSession session, int gNo) {
		return session.selectList("boardMapper.selectAfter", gNo);
	}

	@Override
	public List<Board> selectChal(SqlSession session, int gNo) {
		return session.selectList("boardMapper.selectChal", gNo);
	}

	@Override
	public List<Board> mainBoard(SqlSession session, int gNo) {
		return session.selectList("boardMapper.mainBoard", gNo);
	}

	@Override
	public List<Challenge> myChalList(SqlSession session, Map<String, String> map) {
		return session.selectList("boardMapper.myChalList", map);
	}

	@Override
	public Challenge chalDetail(SqlSession session, int cNo) {
		return session.selectOne("boardMapper.myChal", cNo);
	}

	@Override
	public List<Challenge> chalList(SqlSession session, Map<String, String> map) {
		return session.selectList("boardMapper.chalList", map);
	}

	@Override
	public int addChal(SqlSession session, Challenge chal) {
		return session.insert("boardMapper.insertChal", chal);
	}

	

}
