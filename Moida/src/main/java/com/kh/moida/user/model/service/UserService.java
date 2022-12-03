package com.kh.moida.user.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.kh.moida.moim.model.vo.Moim;
import com.kh.moida.user.model.vo.User;

public interface UserService {
	public User login(Map<String, String> map);
	
	public User autoLogin(String uId);
	
	public boolean duplicateId(String uId);
	
	public boolean duplicateNick(String uNick);
	
	public int join(User user);

	public List<String> getGugun(String sido);

	public List<String> getEmd(Map<String, String> map);

	public List<Map<String,String>> getRi(Map<String,String> map);
	
	public String fileSave(MultipartFile upfile, String savePath);
	
	public void fileDelete(String filePath);
	
	public List<Moim> myMoim(int uNo);
	
	public List<Object> interest(int uNo);
	
	public int updateUser(User user);

	public int updatePwd(User user);
	public int outUser(User user);
	
	public User userNick(Map<String, String> map);
	
	public List<User> searchUser(Map<String,String> map);
}
