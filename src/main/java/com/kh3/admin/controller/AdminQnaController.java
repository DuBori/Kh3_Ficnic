package com.kh3.admin.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh3.model.qna.QnaCommentDAO;
import com.kh3.model.qna.QnaCommentDTO;
import com.kh3.model.qna.QnaDAO;
import com.kh3.model.qna.QnaDTO;

@Controller
public class AdminQnaController {

	

	@Inject
    private QnaDAO dao;
	@Inject
	private QnaCommentDAO cdao;
	
	

	@RequestMapping("admin/qna/qna_list.do")
	public String list(Model model) {
		
		List<QnaDTO> list = this.dao.getQnaList();
		
		model.addAttribute("List", list);
		
		return "admin/qna/qna_list";
		

}
	

	@RequestMapping("admin/qna/qna_view.do")
	public String view(Model model,  @RequestParam("no") int no) {
		
		QnaDTO dto = this.dao.qnaView(no);
		List<QnaCommentDTO> list = this.cdao.getQnaCommentList(no);
		
		model.addAttribute("dto", dto);
		model.addAttribute("cdto", list);
		
		return "admin/qna/qna_view";
	
	}
	
	
	@RequestMapping("admin/qna/qna_reply_ok.do")
	public void reply(QnaCommentDTO dto, HttpServletResponse response) throws Exception {
		

		int check = this.cdao.qnaReply(dto);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			out.println("location.href='admin/qna/qna_view.do?no="+dto.getComment_no()+"'");
		} else {
			out.println("<script>");
			out.println("alert('댓글 등록 실패.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		
		
	}
	
	
	
}
