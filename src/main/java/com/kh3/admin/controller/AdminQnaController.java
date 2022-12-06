package com.kh3.admin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.kh3.util.PageDTO;
import com.kh3.util.Paging;

@Controller
public class AdminQnaController {

    @Inject
    private QnaDAO dao;

    @Inject
    private QnaCommentDAO cdao;

    @Inject
    private FicnicDAO fdao;


    // 한 페이지당 보여질 게시물의 수
    private final int rowsize = 10;

    // 전체 게시물의 수
    private int totalRecord = 0;



    @RequestMapping("admin/qna/qna_list.do")
    public String list(Model model, HttpServletRequest request) {
        // 검색 처리
        String search_ficnic = request.getParameter("search_ficnic");
        if (search_ficnic == null) search_ficnic = "";

        String search_qna = request.getParameter("search_qna");
        if (search_qna == null) search_qna = "";

        String search_writer = request.getParameter("search_writer");
        if (search_writer == null) search_writer = "";

        Map<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("search_ficnic", search_ficnic);
        searchMap.put("search_qna", search_qna);
        searchMap.put("search_writer", search_writer);


        // 페이징 처리
        int page; // 현재 페이지 변수
        if (request.getParameter("page") != null && request.getParameter("page") != "") {
            page = Integer.parseInt(request.getParameter("page"));
        } else {
            page = 1;
        }
        totalRecord = this.dao.getQnaCount(searchMap);

        // 페이징 DTO
        PageDTO dto = new PageDTO(page, rowsize, totalRecord, searchMap);

        // 페이지 이동 URL
        String pageUrl = request.getContextPath() + "/admin/qna/qna_list.do?search_ficnic=" + search_ficnic + "&search_qna=" + search_qna + "&search_writer=" + search_writer;

        List<QnaDTO> list = this.dao.getQnaList(dto.getStartNo(), dto.getEndNo(), searchMap);
        model.addAttribute("List", list);

        model.addAttribute("totalCount", totalRecord);
        model.addAttribute("paging", dto);
        model.addAttribute("search_ficnic", search_ficnic);
        model.addAttribute("search_qna", search_qna);
        model.addAttribute("search_writer", search_writer);
        model.addAttribute("pagingWrite", Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));

        return "admin/qna/qna_list";
    }


    // 답글 상세내역 보여주는 매핑
    @RequestMapping("admin/qna/qna_view.do")
    public String view(Model model, @RequestParam("no") int no) {
        QnaDTO dto = this.dao.qnaView(no);
        List<QnaCommentDTO> list = this.cdao.getQnaCommentList(no);
        FicnicDTO fdto = this.fdao.getFicnicCont(dto.getFicnic_no());

        model.addAttribute("dto", dto);
        model.addAttribute("cdto", list);
        model.addAttribute("fdto", fdto);

        return "admin/qna/qna_view";
    }


    // 답글 등록 매핑
    @RequestMapping("admin/qna/qna_reply_ok.do")
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


    // 문의글 삭제 매핑
    @RequestMapping("/admin/qna/qna_delete.do")
    public void delete(@RequestParam("no") int no, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        int check = this.dao.qnaDelete(no);
        if (check > 0) {
            this.cdao.qnaCommentAllDelete(no);
            out.println("<script>alert('삭제 성공'); location.href='qna_list.do';</script>");
        } else {
            out.println("<script>alert('삭제 실패'); history.back();</script>");
        }
    }


    // 답글 삭제 매핑
    @RequestMapping("/admin/qna/comment_delete.do")
    public void commentDelete(@RequestParam("comment_no") int no, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        int res = this.cdao.qnaCommentDelete(no);
        out.println(res);
    } 
	        
  
}
