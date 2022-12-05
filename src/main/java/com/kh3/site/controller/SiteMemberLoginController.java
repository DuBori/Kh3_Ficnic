package com.kh3.site.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.kh3.model.member.MemberDAO;
import com.kh3.model.member.MemberDTO;

@Controller
public class SiteMemberLoginController {

	@Autowired
	private MemberDAO dao;

	// 로그인 페이지로 가는 매핑
	@RequestMapping("site/member/member_login.do")
	public String login() {

		return "site/member/member_login";
	}

	@RequestMapping("site/member/member_login_check.do")
	public void login_check(MemberDTO dto, HttpSession session, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		// 아이디 체크
		int result = this.dao.loginCheck(dto);

		// 비밀번호 체크
		int check = this.dao.pwCheck(dto);

		if (result == 0) { // 로그인 성공 시
			out.println("<script>");
			out.println("alert('존재하지 않는 회원입니다.')");
			out.println("history.back()");
			out.println("</script>");

		} else if (check == 0) { // 로그인 실패 시
			out.println("<script>");
			out.println("alert('비밀번호가 일치하지 않습니다.')");
			out.println("history.back()");
			out.println("</script>");

		} else {
			out.println("<script>");
			out.println("alert('로그인 성공!')");
			out.println("location.href='main.do'");
			out.println("</script>");
		}

	}

	/*
	 * @RequestMapping("site/member/member_logout.do") public ModelAndView
	 * logout(HttpSession session, ModelAndView mav) {
	 * MemberService.logout(session); mav.setViewName("member/login");
	 * mav.addObject("message", "logout"); return mav; }
	 */

}
