package com.kh3.admin.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	@RequestMapping("admin/qna/test.do")
	public void test(HttpServletRequest request) {
		
		System.out.println(request.getParameter("param"));
		
	}
	

	 @RequestMapping("admin/qna/qna_reply_ok.do") 
	 public void reply(QnaCommentDTO cdto, HttpServletResponse response) throws Exception { 
		 
		 
		 
		 int check = this.cdao.qnaReply(cdto);
	 
	 response.setContentType("text/html; charset=UTF-8");
	 
	 PrintWriter out = response.getWriter();
	 
	 if(check > 0) {
	 
	 out.println("<script>");
	 out.println("location.href='qna_view.do?no="+cdto.getQna_no()+"'");
	 out.println("</script>"); } 
	 else { out.println("<script>");
	 out.println("alert('댓글 등록 실패.')"); out.println("history.back()");
	 out.println("</script>"); 
	 
	 }

	 }

		
		
	@RequestMapping("/admin/qna/qna_delete.do")
	public void delete(@RequestParam("no") int no, HttpServletResponse response) throws Exception {
		
		int check = this.dao.qnaDelete(no);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			
			this.cdao.qnaCommentAllDelete(no);
			
			out.println("<script>");
			out.println("alert('삭제 성공')");
			out.println("location.href='qna_list.do'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('삭제 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
	}
	/*
	 * @RequestMapping("/admin/qna/qnaComment_delete.do") public void
	 * commentDelete(@RequestParam("no") int no, HttpServletResponse response,
	 * QnaDTO qdto, QnaCommentDTO dto) throws Exception {
	 * 
	 * int check = this.cdao.qnaCommentDelete(no);
	 * 
	 * response.setContentType("text/html; charset=UTF-8");
	 * 
	 * PrintWriter out = response.getWriter();
	 * 
	 * 
	 * // 나중에 세션으로 location 수정 if(check > 0) {
	 * 
	 * out.println("<script>"); out.println("alert('댓글 삭제 성공')");
	 * out.println("location.href='qna_view.do?no="+no+"'");
	 * out.println("</script>"); } else { out.println("<script>");
	 * out.println("alert('댓글 삭제 실패')"); out.println("history.back()");
	 * out.println("</script>"); }
	 * 
	 * }
	 */
	
	
}
