package com.kh.moida.moim.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.kh.moida.common.util.PageInfo;
import com.kh.moida.moim.model.vo.BanMember;
import com.kh.moida.moim.model.vo.JoinMember;
import com.kh.moida.moim.model.vo.Moim;
import com.kh.moida.moim.model.vo.MoimMember;
import com.kh.moida.user.model.vo.User;

public interface MoimService {
	
	// Service List
	// 1. Select MoimDetail
	// 2. Select MoimMember
	// 3. Select MoimMemberDetail
	// 4. select moim
	// 5. insert moim
	// 6. file save
	// 7. file delete
	
	public Moim selectMoimDetail(int gNo);
	
	public List<MoimMember> selectMoimMember(int gNo);
	
	public MoimMember selectMoimMemberDetail(Map<String,String> map);
	
	public List<Moim> selectMoim(Map<String,String> map, PageInfo pageInfo);
	
	public int insertMoim(Moim moim, int uNo);
	
	public String fileSave(MultipartFile upfile, String savePath);
	
	public void fileDelete(String filePath);
	
	public int selectMoimCnt(Map<String,String> map);
	
	public boolean selectFavor(Map<String,String> map);
	
	public int insertFavor(Map<String, String> map);

	public int deleteMoim(Map<String, String> map);

	public int deleteFavor(Map<String, String> map);

	public int addJoin(MoimMember mm);

	public List<Moim> rec(int uNo);
	
	public boolean detBanMem(Map<String, String> map);
	
	public List<MoimMember> memberPaging(Map<String,String> map);
	
	public int memCnt(int gNo);
	
	public int changeLeader(Map<String,String> map);
	
	public int changeLv(String[] uNo, String[] lNo, int gNo);
	
	public int punish(Map<String, String> map);
	
	public int depunish(Map<String, String> map);
	
	public int ban(Map<String,String> map);
	
	public List<User> inviteUser(int gNo);
	
	public int insertInvite(Map<String, String> map);
	
	public List<BanMember> banList(int gNo);
	
	public int delBan(Map<String, String> map);
	
	public List<JoinMember> jmList(int gNo);
	
	public int insertApply(JoinMember jm);
	
	public int applyDeny(Map<String,String> map);
	
	public int updateSetting(Moim m);
	
	public int delMoim(int gNo);
	
	public boolean detJM(Map<String, String> map);
}
