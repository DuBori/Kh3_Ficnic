package com.kh3.admin.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh3.model.board.BoardCategoryDAO;
import com.kh3.model.board.BoardConfDAO;
import com.kh3.model.board.BoardConfDTO;
import com.kh3.model.board.BoardDAO;

@Controller
public class AdminBoardController {

	@Inject
	private BoardDAO board_Dao;
	
	@Inject
	private BoardCategoryDAO board_CategoryDao;
	
	@Inject
	private BoardConfDAO board_ConfDao; 
	
	
	// 환경설정_게시판 설정 페이지
	@RequestMapping("admin_board.do")
	public String admin_board(Model model) {
		
		// 테이블 이름을 통해서 해당 테이블리스트를 넣어서 가져올 수 있나요?
		model.addAttribute("List",this.board_ConfDao.getConfBoardList());
		return "/admin/board/board_list";
	}
	
	// 환경설정_게시판설정_게시판추가 페이지
	@RequestMapping("config_board_write.do")
	public String admin_board_write() {
		
		return "/admin/board/board_write";
	}
	
	// 환경설정_게시판설정_게시판추가 받은 데이터 처리
	@RequestMapping("config_board_write_Ok.do")
	public void admin_board_writeOk(BoardConfDTO confdto, HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out=response.getWriter();
		
		if(this.board_ConfDao.writeBoard(confdto)>0) {
			out.println("<script>");
			out.println("alert('게시판 생성 완료')");
			out.println("location.href='admin_board.do'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('게시판 생성 실패')");
			out.println("history.back()");
			out.println("</script>");	
		}	
	}
	@RequestMapping("config_board_content.do")
	public String admin_board_content(@RequestParam("board_no") int board_no, Model model) {
		
		model.addAttribute("Cont", this.board_ConfDao.getCont(board_no));
		model.addAttribute("modify", "m");
		return "/admin/board/board_write";
	}
	
	
	
	
}
