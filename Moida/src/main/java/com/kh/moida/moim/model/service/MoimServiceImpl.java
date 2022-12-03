package com.kh.moida.moim.model.service;

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

import com.kh.moida.alarm.model.dao.AlarmDAO;
import com.kh.moida.alarm.model.vo.Alarm;
import com.kh.moida.common.util.PageInfo;
import com.kh.moida.moim.model.dao.MoimDAO;
import com.kh.moida.moim.model.vo.BanMember;
import com.kh.moida.moim.model.vo.JoinMember;
import com.kh.moida.moim.model.vo.Moim;
import com.kh.moida.moim.model.vo.MoimMember;
import com.kh.moida.plan.model.dao.PlanDAO;
import com.kh.moida.user.model.dao.UserDAO;
import com.kh.moida.user.model.vo.User;

@Service
public class MoimServiceImpl implements MoimService {

	@Autowired
	private MoimDAO dao;

	@Autowired
	private SqlSessionTemplate session;

	@Autowired
	private AlarmDAO alDao;

	@Autowired
	private UserDAO uDao;
	
	@Autowired
	private PlanDAO pDao;

	@Override
	public Moim selectMoimDetail(int gNo) {
		return dao.selectMoimDetail(session, gNo);
	}

	@Override
	public List<MoimMember> selectMoimMember(int gNo) {
		return dao.selectMoimMember(session, gNo);
	}

	@Override
	public MoimMember selectMoimMemberDetail(Map<String, String> map) {
		MoimMember mm = dao.selectMoimMemberDetail(session, map);
		return mm;
	}

	@Override
	public List<Moim> selectMoim(Map<String, String> map, PageInfo pageInfo) {
		// map k/v : keyword, start, end, interest
		map.put("start", "" + pageInfo.getStartList());
		map.put("end", "" + pageInfo.getEndList());
		return dao.selectMoim(session, map);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertMoim(Moim moim, int uNo) {
		int result = 0;
		if (moim.getgNo() != 0) {

		} else {
			result = dao.insertMoim(session, moim);
			if (result > 0) {
				int gNo = result;
				MoimMember mm = new MoimMember();

				mm.setgNo(gNo);
				mm.setuNo(uNo);
				mm.setlNo(1);

				result = dao.insertMoimMember(session, mm);
			}
		}
		return result;
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
	public int selectMoimCnt(Map<String, String> map) {
		return dao.selectMoimCnt(session, map);
	}

	@Override
	public boolean selectFavor(Map<String, String> map) {
		return dao.selectFavor(session, map) == null;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertFavor(Map<String, String> map) {
		int result = dao.insertFavor(session, map);
		if (result > 0) {
			Moim m = dao.selectMoimDetail(session, Integer.parseInt(map.get("gNo")));
			m.setgCnt(m.getgCnt() + 1);
			result = dao.updateMoim(session, m);
		}
		return result;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteMoim(Map<String, String> map) {
		int result = dao.outMoim(session, map);
		if (result >0) {
			List<String> detPm = pDao.detPm(session, map);
			if (detPm.isEmpty() == false) {
				result = pDao.delPm(session, map);
			}
		}
		return result;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteFavor(Map<String, String> map) {
		int result = dao.deleteFavor(session, map);
		if (result > 0) {
			Moim m = dao.selectMoimDetail(session, Integer.parseInt(map.get("gNo")));
			m.setgCnt(m.getgCnt() - 1);
			result = dao.updateMoim(session, m);
		}
		return result;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int addJoin(MoimMember mm) {

		int result = dao.insertMoimMember(session, mm);
		if (result > 0) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("gNo", "" + mm.getgNo());
			map.put("uNo", "" + mm.getuNo());
			result = dao.delJm(session, map);
			if (result > 0) {
				Moim moim = dao.selectMoimDetail(session, mm.getgNo());
				Alarm al = new Alarm();
				al.setAlCont(moim.getgName() + " : 가입 허가 되었습니다.");
				al.setUNo(mm.getuNo());
				al.setGNo(mm.getgNo());
				result = alDao.insertAlarm(session, al);
			}
		}
		return result;
	}

	@Override
	public List<Moim> rec(int uNo) {
		return dao.recommand(session, uNo);
	}

	@Override
	public boolean detBanMem(Map<String, String> map) {
		String result = dao.detBanMem(session, map);
		if (result != null) {
			return false;
		}
		return true;
	}

	@Override
	public List<MoimMember> memberPaging(Map<String, String> map) {
		return dao.selectMoimMemberPaging(session, map);
	}

	@Override
	public int memCnt(int gNo) {
		return dao.memCnt(session, gNo);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int changeLeader(Map<String, String> map) {
		Map<String, String> oriMap = new HashMap<String, String>();

		oriMap.put("uNo", map.get("uNo"));
		oriMap.put("gNo", map.get("gNo"));
		oriMap.put("lNo", "2");
		Map<String, String> newMap = new HashMap<String, String>();
		newMap.put("uNo", map.get("newLeader"));
		newMap.put("gNo", map.get("gNo"));
		newMap.put("lNo", "1");

		int result = dao.updateLv(session, oriMap);

		if (result > 0) {
			result = dao.updateLv(session, newMap);
			if (result > 0) {

				Alarm al = new Alarm();
				Moim moim = dao.selectMoimDetail(session, Integer.parseInt(map.get("gNo")));
				al.setAlCont(moim.getgName() + " : 모임장이 되셨습니다.");
				al.setUNo(Integer.parseInt(newMap.get("uNo")));
				al.setGNo(Integer.parseInt(newMap.get("gNo")));
				result = alDao.insertAlarm(session, al);
			}
		}

		return result;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int changeLv(String[] uNo, String[] lNo, int gNo) {
		int result = 0;
		for (int i = 0; i < uNo.length; i++) {
			Map<String, String> uMap = new HashMap<String, String>();

			uMap.put("uNo", uNo[i]);
			uMap.put("gNo", "" + gNo);
			uMap.put("lNo", lNo[i]);

			result = dao.updateLv(session, uMap);

			if (result > 0) {
				Alarm al = new Alarm();
				Moim moim = dao.selectMoimDetail(session, gNo);
				if (lNo[i].equals("2")) {
					al.setAlCont(moim.getgName() + " : 운영진으로 변경 되었습니다.");
				} else {
					al.setAlCont(moim.getgName() + " : 일반회원으로 변경 되었습니다.");
				}
				al.setUNo(Integer.parseInt(uMap.get("uNo")));
				al.setGNo(gNo);
				result = alDao.insertAlarm(session, al);
			}
		}

		return result;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int punish(Map<String, String> map) {
		int result = dao.punish(session, map);
		int gNo = Integer.parseInt(map.get("gNo"));
		if (result > 0) {
			Alarm al = new Alarm();
			Moim moim = dao.selectMoimDetail(session, gNo);
			if (map.get("pNo").equals("1")) {
				al.setAlCont(moim.getgName() + " : 댓글 금지 징계 처리 되었습니다.");
			} else if (map.get("pNo").equals("2")) {
				al.setAlCont(moim.getgName() + " : 댓글 + 게시글 금지 징계 처리 되었습니다.");
			} else {
				al.setAlCont(moim.getgName() + " : 댓글 + 게시글 + 모임참석 금지 징계 처리 되었습니다.");
			}
			al.setUNo(Integer.parseInt(map.get("uNo")));
			al.setGNo(gNo);
			result = alDao.insertAlarm(session, al);
		}
		return result;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int depunish(Map<String, String> map) {
		int result = dao.punish(session, map);
		int gNo = Integer.parseInt(map.get("gNo"));
		if (result > 0) {
			Alarm al = new Alarm();
			Moim moim = dao.selectMoimDetail(session, gNo);
			al.setAlCont(moim.getgName() + " : 징계 해제 되었습니다.");
			al.setUNo(Integer.parseInt(map.get("uNo")));
			al.setGNo(gNo);
			result = alDao.insertAlarm(session, al);
		}
		return dao.punish(session, map);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int ban(Map<String, String> map) {
		int result = dao.ban(session, map);
		int gNo = Integer.parseInt(map.get("gNo"));
		if (result > 0) {
			result = dao.outMoim(session, map);
			if (result > 0) {
				Alarm al = new Alarm();
				Moim moim = dao.selectMoimDetail(session, gNo);
				al.setAlCont(moim.getgName() + " : 추방 되었습니다.");
				al.setUNo(Integer.parseInt(map.get("uNo")));
				al.setGNo(gNo);
				result = alDao.insertAlarm(session, al);
			}
		}
		return result;
	}

	@Override
	public List<User> inviteUser(int gNo) {
		return dao.inviteList(session, gNo);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertInvite(Map<String, String> map) {
		int result = dao.insertInvite(session, map);
		int gNo = Integer.parseInt(map.get("gNo"));
		if (result > 0) {
			Moim moim = dao.selectMoimDetail(session, gNo);
			Alarm al = new Alarm();
			al.setAlCont(moim.getgName() + " : 초대 되었습니다.");
			al.setUNo(Integer.parseInt(map.get("uNo")));
			al.setGNo(gNo);
			result = alDao.insertAlarm(session, al);
		}
		return result;
	}

	@Override
	public List<BanMember> banList(int gNo) {
		return dao.banList(session, gNo);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int delBan(Map<String, String> map) {
		int result = dao.delBan(session, map);
		int gNo = Integer.parseInt(map.get("gNo"));
		if (result > 0) {
			Moim moim = dao.selectMoimDetail(session, gNo);
			Alarm al = new Alarm();
			al.setAlCont(moim.getgName() + " : 추방 해제 되었습니다.");
			al.setUNo(Integer.parseInt(map.get("uNo")));
			al.setGNo(gNo);
			result = alDao.insertAlarm(session, al);
		}
		return dao.delBan(session, map);
	}

	@Override
	public List<JoinMember> jmList(int gNo) {
		return dao.jmList(session, gNo);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertApply(JoinMember jm) {
		int gNo = jm.getgNo();
		int result = dao.apply(session, jm);
		if (result > 0) {
			Moim moim = dao.selectMoimDetail(session, gNo);
			Alarm al = new Alarm();
			User user = uDao.selectByUNo(session, jm.getuNo());
			al.setAlCont(moim.getgName() + " : " + user.getuNick() + " 님이 가입 신청하셨습니다.");
			al.setUNo(moim.getuNo());
			al.setGNo(gNo);
			result = alDao.insertAlarm(session, al);
		}
		return result;
	}

	@Override
	public int applyDeny(Map<String, String> map) {
		int result = dao.delJm(session, map);
		int gNo = Integer.parseInt(map.get("gNo"));
		int uNo = Integer.parseInt(map.get("uNo"));
		if (result > 0) {
			Moim moim = dao.selectMoimDetail(session, gNo);
			Alarm al = new Alarm();
			al.setAlCont(moim.getgName() + " : " + " 가입 거절 되었습니다.");
			al.setUNo(uNo);
			al.setGNo(gNo);
			result = alDao.insertAlarm(session, al);
		}
		return result;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateSetting(Moim m) {
		return dao.updateSetting(session, m);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int delMoim(int gNo) {
		return dao.delMoim(session, gNo);
	}

	@Override
	public boolean detJM(Map<String, String> map) {
		if (dao.selectJM(session, map) == null) {
			return true;
		}
		return false;
	}

}
