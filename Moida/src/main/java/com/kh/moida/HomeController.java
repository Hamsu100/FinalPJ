package com.kh.moida;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.moida.user.model.service.UserService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private UserService service;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpSession session, 
			@CookieValue(value="saveId", required=false) Cookie saveId,
			@CookieValue(value="auto", required=false) Cookie auto) {
		//cookie 값 불러오기
		if (session.getAttribute("loginUser") !=null) {
			return "user/main";
		}
		if (saveId != null) {
			model.addAttribute("saveId", saveId.getValue());
		}
		if (auto != null) {
			session.setAttribute("loginUser", service.autoLogin(auto.getValue()));
			return "user/main";
		}
		return "home";
	}
	
}
