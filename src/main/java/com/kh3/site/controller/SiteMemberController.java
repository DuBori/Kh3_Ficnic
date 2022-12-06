package com.kh3.site.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh3.model.member.MemberDAO;
import com.kh3.model.member.MemberDTO;
import com.kh3.model.qna.QnaCommentDTO;
import com.kh3.model.qna.QnaDTO;

@Controller
public class SiteMemberController {

	
	@Autowired
	private MemberDAO dao;

	
	// 로그인 페이지로 가는 매핑
	@RequestMapping("member/member_login.do")
	public String login() {

		return "site/member/member_login";
	}
	
	// 로그인
	@RequestMapping("member/member_login_check.do")
	public void login_check(MemberDTO dto, HttpSession session, HttpServletResponse response) throws IOException {

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		// 아이디 체크
		int result = this.dao.loginCheck(dto);

		// 비밀번호 체크
		int check = this.dao.pwCheck(dto);

		if (result == 0) { 
			out.println("<script>");
			out.println("alert('존재하지 않는 회원입니다.')");
			out.println("history.back()");
			out.println("</script>");

		} else if (check == 0) { 
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

	/* 로그 아웃
	 * @RequestMapping("site/member/member_logout.do") public ModelAndView
	 * logout(HttpSession session, ModelAndView mav) {
	 * MemberService.logout(session); mav.setViewName("member/login");
	 * mav.addObject("message", "logout"); return mav; }
	 */
	
	
	// 아이디 찾는 창으로 가는 매핑
	@RequestMapping("member/member_find.do")
	public String find() {

		return "site/member/member_find";
	}
	
	// 비밀번호 찾는 창으로 가는 매핑
	@RequestMapping("member/member_find_pw.do")
	public String findpw() {
		
		return "site/member/member_find_pw";
	}
	
	
	 // 아이디 찾기
    @RequestMapping("member/member_find_id_result.do")
    public String findidresult(Model model, HttpServletResponse response, MemberDTO dto) throws IOException {

    	response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();			

	
		// 아이디 찾기 - 이메일 체크
		int check = this.dao.findIdEmail(dto);
		
		// 아이디 찾기 - 둘 다 맞는 경우
		int result = this.dao.findIdAll(dto);
		
		// 아이디 불러오기
		String id = this.dao.findId(dto);
		System.out.println("id" + id);
		
		
		if (check == 0) { // 이메일 틀린 경우
			out.println("<script>");
			out.println("alert('존재하지 않는 이메일입니다.')");
			out.println("history.back()");
			out.println("</script>");
		} else if (result == 0) { // 이름이 틀릴 경우
			out.println("<script>");
			out.println("alert('이름이 틀립니다.')");
			out.println("history.back()");
			out.println("</script>");

		} else {
			// 아이디 바인딩하기 (view 페이지로 넘길 정보)
			model.addAttribute("id", id);
			return "site/member/member_find_id_result";
		} 
		
		return null;
		
	}
    
    	
    // 비밀번호 찾기
    @RequestMapping("member/member_find_pw_result.do")
    public String findpwresult(Model model, HttpServletResponse response, MemberDTO dto) throws IOException {

    	response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();			

		// 비밀번호 찾기 - 이메일 체크
		int check = this.dao.findIdEmail(dto);
		
		// 비밀번호 찾기 - 둘 다 맞는 경우
		int result = this.dao.findPwAll(dto);
		
		// 아이디 불러오기
		String pw = this.dao.findPw(dto);
		System.out.println("pw" + pw);
		
		
		if (check == 0) { // 이메일 틀린 경우
			out.println("<script>");
			out.println("alert('존재하지 않는 이메일입니다.')");
			out.println("history.back()");
			out.println("</script>");
		} else if (result == 0) { // 이름이 틀릴 경우
			out.println("<script>");
			out.println("alert('아이디를 다시 확인해주세요.')");
			out.println("history.back()");
			out.println("</script>");

		} else {
			// 아이디 바인딩하기 (view 페이지로 넘길 정보)
			model.addAttribute("pw", pw);
			return "site/member/member_find_pw_result";
		} 
		
		return null;
		
	}
	
}
