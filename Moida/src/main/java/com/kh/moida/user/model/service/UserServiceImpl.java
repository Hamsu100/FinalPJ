package com.kh.moida.user.model.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.moida.moim.model.vo.Moim;
import com.kh.moida.user.model.dao.UserDAO;
import com.kh.moida.user.model.vo.User;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO dao;

	@Autowired
	private SqlSessionTemplate session;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@Override
	public User login(Map<String, String> map) {
		User user = dao.selectById(session, map.get("uLoginId"));
		if (user == null) {
			return null;
		}
		String pwd = map.get("uPwd");
		if (passwordEncoder.matches(pwd, user.getuPwd()) == false) {
			return null;
		}

		return user;
	}

	@Override
	public List<String> getGugun(String sido) {
		return dao.selectAreaBySido(session, sido);
	}

	@Override
	public List<String> getEmd(Map<String, String> map) {
		return dao.selectAreaByGugun(session, map);
	}

	@Override
	public List<Map<String, String>> getRi(Map<String, String> map) {
		return dao.selectAreaByEmd(session, map);
	}

	@Override
	public boolean duplicateId(String uId) {
		String id = dao.duplicateId(session, uId);
		if (id != null) {
			return false;
		}
		return true;
	}

	@Override
	public boolean duplicateNick(String uNick) {
		String nick = dao.duplicateNick(session, uNick);
		if (nick != null) {
			return false;
		}
		return true;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int join(User user) {
		int result = 0;
		user.setuPwd(passwordEncoder.encode(user.getuPwd()));

		result = dao.insertUser(session, user);

		User joinUser = dao.selectById(session, user.getuLoginId());

		String uNo = "" + joinUser.getuNo();
		Map<String, String> map = new HashMap<String, String>();

		for (String interest : user.getuInterest()) {
			map.put("uNo", uNo);
			map.put("iNo", interest);
			dao.insertUserInterest(session, map);
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
	public User autoLogin(String uId) {
		User user = dao.selectById(session, uId);
		return user;
	}

	@Override
	public List<Moim> myMoim(int uNo) {
		return dao.myMoim(session, uNo);
	}

	@Override
	public List<Object> interest(int uNo) {
		return dao.interest(session, uNo);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateUser(User user) {
		int result = dao.updateUser(session, user);
		if (result > 0) {
			result = dao.deleteInterest(session, user.getuNo());
			if (result > 0) {
				for (String i : user.getuInterest()) {
					Map<String, String> map = new HashMap<>();
					map.put("uNo", "" + user.getuNo());
					map.put("iNo", i);
					result = dao.insertUserInterest(session, map);
				}
			}
		}
		return result;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updatePwd(User user) {
		user.setuPwd(passwordEncoder.encode(user.getuPwd()));
		int result = dao.updatePwd(session, user);

		return result;
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int outUser(User user) {
		return dao.outUser(session, user);
	}

	@Override
	public User userNick(Map<String, String> map) {
		return dao.userNick(session, map);
	}

	@Override
	public List<User> searchUser(Map<String, String> map) {
		return dao.searchUser(session, map);
	}

}
