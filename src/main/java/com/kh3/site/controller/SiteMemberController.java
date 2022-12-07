package com.kh3.site.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh3.model.member.MemberDAO;
import com.kh3.model.member.MemberDTO;
import com.kh3.model.member.PointDAO;
import com.kh3.model.member.PointDTO;
import com.kh3.model.qna.QnaCommentDTO;
import com.kh3.model.qna.QnaDTO;

@Controller
public class SiteMemberController {

	
	@Autowired
	private MemberDAO dao;
	private PointDAO pdao;

	
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
			out.println("alert('환영합니다.')");
			out.println("location.href='../main.do'");
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
    
	 // 로그인 페이지로 가는 매핑
	 	@RequestMapping("member/member_join.do")
	 	public String join() {
	
	 		return "site/member/member_join";
	 	}
	 	
		/*
		 * // 아이디 중복 체크
		 * 
		 * @RequestMapping("member/memberIdCheck.do")
		 * 
		 * @ResponseBody public int checkId(@RequestParam("paramId") String paramId) {
		 * return this.dao.checkId(paramId); }
		 */
	    
	 	
	    
	 	// 회원가입
	    @RequestMapping("member/member_join_ok.do")
	    public void joinOk(@Valid MemberDTO dto, BindingResult result, PointDTO pdto, HttpServletResponse response) throws IOException {
	    	
	    	response.setContentType("text/html; charset=UTF-8");
	    	PrintWriter out = response.getWriter();
	    	
	    	// 비밀번호 일치 확인
	    	if(!dto.getMember_pw().equals(dto.getMember_pw_re())) {
				out.println("<script>alert('[비밀번호]가 일치하지 않습니다. 다시 입력해주세요.'); history.back();</script>");
	    	}
	    	// 유효성 검사
	    	if(result.hasErrors()) {
				List<ObjectError> list = result.getAllErrors();
				
				for (ObjectError error : list) {
					
					if(error.getDefaultMessage().equals("id")) {
						System.out.println("id오류");
						out.println("<script>alert('아이디를 6자 이상 입력해주세요.'); history.back();</script>"); break;
					}else if(error.getDefaultMessage().equals("name")) {
						
						System.out.println("name오류");
						out.println("<script>alert('이름을 2~8자 사이로 입력해주세요.'); history.back();</script>"); break;
					}else if(error.getDefaultMessage().equals("pw")) {
						System.out.println("pw오류");
						out.println("<script>alert('비밀번호는 영문자와 숫자, 특수기호가 적어도 1개 이상 포함된 6자~12자의 비밀번호여야 합니다.'); history.back();</script>"); break;
					}else if(error.getDefaultMessage().equals("email")) {
						System.out.println("email오류");
						out.println("<script>alert('잘못된 이메일 형식입니다. 다시 입력해 주세요.'); history.back();</script>"); break;
					}else if(error.getDefaultMessage().equals("phone")) {
						System.out.println("phone오류");
						out.println("<script>alert('잘못된 전화번호 형식입니다. 다시 입력해 주세요.'); history.back();</script>"); break;
					} 
				} 
	    	}else {				// 이상 없을 때 실행
	    		int check = this.dao.joinMember(dto);
	    		if (check > 0) {
	    			// 회원 가입 포인트 적립
					 this.pdao.joinPoint(pdto); 
	    			out.println("<script>alert('회원 등록 되었습니다.'); location.href='../main.do'; </script>");
	    		} else {
	    			out.println("<script>alert('회원 등록 중 에러가 발생하였습니다.'); history.back();</script>");
	    		}
	    	}
	    		
			// 중복 찾기
			int check = this.dao.idCheck(dto);
			
			if (check == 1) { // 중복인 경우
				out.println("<script>");
				out.println("alert('중복 아이디입니다.')");
				out.println("history.back()");
				out.println("</script>");
			}
			
			
			
	    }


}
