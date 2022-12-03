package com.kh.moida.board.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.kh.moida.board.model.vo.Board;
import com.kh.moida.board.model.vo.Challenge;
import com.kh.moida.board.model.vo.Greet;
import com.kh.moida.board.model.vo.Reply;
import com.kh.moida.common.util.PageInfo;

public interface BoardService {
	// 1. 게시�? 개수
	public int boardCnt(Map<String, String> map);
	// 2. 게시�? 리스?��
	public List<Board> boardList(PageInfo pageInfo, Map<String, String> map);
	// 3. 게시�? ?��?��
	public Board boardDetail(int bNo);
	// 4. ?���? 리스?��
	public List<Reply> replyList(int bNo);
	// 5. 게시�? ?��?�� / ?��?��
	public int saveBoard(Board board);
	// 7. 게시�? ?��?��
	public int deleteBoard(int bNo, String rootPath);
	// 8. ?���? ?��?�� / ?��?��
	public int saveReply(Reply reply);
	// 10. ?���? ?��?��
	public int deleteReply(int rNo);
	// 11. �??��?��?�� 리스?��
	public List<Greet> selectGreet(Map<String, String> map);
	// 12. �??��?��?�� ?��?�� / ?��?��
	public int writeGreet(Greet greet);
	// 14. �??��?��?�� ?��?��
	public int deleteGreet(int grNo);
	// 15. ?��?�� ?��로드
	public String fileSave(MultipartFile upfile, String savePath);
	// 16. ?��?�� ?��?��
	public void fileDelete(String filePath);
	
	// 17. greet cnt
	public int selectGrCnt(int gNo);
	// 18. chalList
	public List<Challenge> selectChalList(int gNo);
	
	public Reply selectReplyDetail(int rNo);
	
	public Greet selectGrByNo(int grNo);
	
	public List<Board> notice(int gNo);
	
	public List<Board> img(int gNo);
	
	public List<Board> after(int gNo);
	
	public List<Board> chal(int gNo);
	
	public List<Board> mainBoard(int gNo);
	public List<Challenge> myChal(Map<String, String> map);
	
	public Challenge chalDetail(int cNo);
	
	public List<Challenge> chalList(Map<String, String> map);
	
	public int addChal(Challenge chal);
	
}
