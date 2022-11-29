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
	@RequestMapping("board_list.do")
	public String board_list(Model model) {
		
		// 테이블 이름을 통해서 해당 테이블리스트를 넣어서 가져올 수 있나요?
		model.addAttribute("List",this.board_ConfDao.getConfBoardList());
		return "/admin/board/board_list";
	}
	
	// 환경설정_게시판설정_게시판추가 페이지
	@RequestMapping("board_write.do")
	public String board_write() {
		
		return "/admin/board/board_write";
	}
	
	// 환경설정_게시판설정_게시판추가 받은 데이터 처리
	@RequestMapping("board_write_ok.do")
	public void board_writeOk(BoardConfDTO confdto, HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out=response.getWriter();
		
		if(this.board_ConfDao.writeBoard(confdto)>0) {
			out.println("<script>");
			out.println("alert('게시판 생성 완료')");
			out.println("location.href='board_list.do'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('게시판 생성 실패')");
			out.println("history.back()");
			out.println("</script>");	
		}	
	}
	
	
	 @RequestMapping("board_modify.do") 
	 public String board_content(@RequestParam("board_no") int board_no, Model model) {
	  
		  model.addAttribute("Cont", this.board_ConfDao.getCont(board_no));
		  model.addAttribute("modify", "m"); 
		  
		  return "/admin/board/board_write"; 
	 }
	 
	 @RequestMapping("board_modify_ok.do")
	 public void board_modify_ok(BoardConfDTO dto, HttpServletResponse response) throws IOException {
		 
		 response.setContentType("text/html; charset=utf-8");
		 PrintWriter out=response.getWriter();
		 
			if(this.board_ConfDao.updateBoard(dto)>0 ) {
				out.println("<script>");
				out.println("alert('게시판 수정 완료')");
				out.println("location.href='board_list.do'");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("alert('게시판 수정 실패')");
				out.println("history.back()");
				out.println("</script>");	
			}	
		 
	 }
	 
	
	
	
	
}
