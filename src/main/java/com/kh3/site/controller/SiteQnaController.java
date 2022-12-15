package com.kh3.site.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.kh3.model.ficnic.FicnicDAO;
import com.kh3.model.ficnic.FicnicDTO;
import com.kh3.model.qna.QnaCommentDAO;
import com.kh3.model.qna.QnaCommentDTO;
import com.kh3.model.qna.QnaDAO;
import com.kh3.model.qna.QnaDTO;

@Controller
public class SiteQnaController {

    @Autowired
    private QnaDAO qdao;

    @Autowired
    private QnaCommentDAO cdao;

    @Autowired
    private FicnicDAO fdao;    

    
    // =====================================================================================
    // 마이페이지 - 내 1:1 문의 상세목록
    // =====================================================================================
    @RequestMapping("/site/mypage/mypage_qna_view.do")
    public String qna_view(Model model, QnaDTO dto, @RequestParam("no") int no) {
        dto = this.qdao.qnaView(no);
        List<QnaCommentDTO> cdto = this.cdao.getQnaCommentList(no);
        FicnicDTO fdto = this.fdao.getFicnicCont(dto.getFicnic_no());
        
        model.addAttribute("dto", dto);
        model.addAttribute("cdto", cdto);
        model.addAttribute("fdto", fdto);       
    	return "site/mypage/mypage_qna_view";
    }
    


    // =====================================================================================
    // 1:1 문의 삭제 처리
    // =====================================================================================
    @RequestMapping("/site/mypage/mypage_qna_deleteOk.do")
    public void delete(@RequestParam("qna_no") int no, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        int check = this.qdao.qnaDelete(no);
        if (check > 0) {
            this.cdao.qnaCommentAllDelete(no);
            out.println("<script>alert('문의글이 삭제되었습니다.'); location.href='qna_list.do';</script>");
        } else {
            out.println("<script>alert('문의글 삭제중 에러가 발생하였습니다.'); history.back();</script>");
        }
    }




    // =====================================================================================
    // 1:1 문의 댓글 작성 처리
    // =====================================================================================
    @RequestMapping("/site/mypage/mypage_qna_commentOk.do")
    public void reply(HttpServletRequest request, HttpServletResponse response) throws Exception {
        QnaCommentDTO cdto = new QnaCommentDTO();

        cdto.setComment_content(request.getParameter("comment_content"));
        cdto.setComment_writer_name(request.getParameter("comment_writer_name"));
        cdto.setComment_writer_pw(request.getParameter("comment_writer_pw"));
        cdto.setMember_id(request.getParameter("member_id"));
        
        cdto.setQna_no(Integer.parseInt(request.getParameter("qna_no")));

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        int check = this.cdao.qnaReply(cdto);
        out.println(check);
    }




    // =====================================================================================
    // 1:1 문의 댓글 삭제 처리
    // =====================================================================================
    @RequestMapping("/site/mypage/mypage_qna_deleteOk.do")
    public void commentDelete(@RequestParam("comment_no") int no, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        int res = this.cdao.qnaCommentDelete(no);
        out.println(res);
    } 

    
    
    
    // =====================================================================================
    // 1:1 문의 수정 페이지
    // =====================================================================================
    @RequestMapping("/site/mypage/mypage_qna_modify.do")
    public String info_modify() {
    	
    	
        return "site/mypage/mypage_info_modify";
    }

    
    
    
  
}
