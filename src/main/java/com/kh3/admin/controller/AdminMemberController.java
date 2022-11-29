package com.kh3.admin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh3.model.member.MemberDAO;
import com.kh3.model.member.MemberDTO;
import com.kh3.model.member.PointDAO;
import com.kh3.model.member.PointDTO;

@Controller
public class AdminMemberController {

	@Autowired
	private MemberDAO dao;
	
	@Autowired
	private PointDAO pdao;
	
	// 회원의 전체리스트 메핑
	@RequestMapping("admin/member_list.do")
	public String list(Model model) {
		
		List<MemberDTO> list = this.dao.getMemberList();
		model.addAttribute("List", list);
		
		return "admin/member/member_list";
	}
	
	// 회원 상세내역 메핑
	@RequestMapping("member_view.do")
	public String view(Model model ,@RequestParam("no") int no) {
		
		MemberDTO dto = this.dao.getMemberView(no);
		model.addAttribute("dto", dto);
		
		return "admin/member/member_view";
	}
	
	// 회원 등록 페이지로 가는 메핑
	@RequestMapping("member_write.do")
	public String write() {
			
		return "admin/member/member_write";
	}
	
	// 회원 등록 하는 메핑
	@RequestMapping("memberWriteOk.do")
	public void writeOk(MemberDTO dto, PointDTO pdto, HttpServletResponse response) throws IOException {
		
		int check = this.dao.writeOkMember(dto);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			this.pdao.joinPoint(pdto);
            out.println("<script>alert('회원 등록 되었습니다.'); location.href='admin/member_list.do';</script>");
		} else {

			out.println("<script>alert('회원 등록 중 에러가 발생하였습니다.'); history.back();</script>");
		}
		
		
		
	}

		
		
		
		
		
		
	
}
