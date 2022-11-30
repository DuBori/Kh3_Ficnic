package com.kh3.admin.controller;

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

import com.kh3.model.review.ReviewDAO;
import com.kh3.model.review.ReviewDTO;
import com.kh3.util.PageDTO;
import com.kh3.util.Paging;

@Controller
public class AdminReviewController {

    @Inject
    private ReviewDAO dao;


    // 한 페이지당 보여질 게시물의 수
    private final int rowsize = 10;

    // 전체 게시물의 수
    private int totalRecord = 0;



    @RequestMapping("admin/review/review_list.do")
    public String list(Model model, HttpServletRequest request) {
        // 검색 처리
        String search_ficnic = request.getParameter("search_ficnic");
        if (search_ficnic == null) search_ficnic = "";

        String search_review = request.getParameter("search_review");
        if (search_review == null) search_review = "";

        String search_writer = request.getParameter("search_writer");
        if (search_writer == null) search_writer = "";

        Map<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("search_ficnic", search_ficnic);
        searchMap.put("search_review", search_review);
        searchMap.put("search_writer", search_writer);


        // 페이징 처리
        int page; // 현재 페이지 변수
        if (request.getParameter("page") != null && request.getParameter("page") != "") {
            page = Integer.parseInt(request.getParameter("page"));
        } else {
            page = 1;
        }
        totalRecord = this.dao.getReviewCount(searchMap);

        // 페이징 DTO
        PageDTO dto = new PageDTO(page, rowsize, totalRecord, searchMap);

        // 페이지 이동 URL
        String pageUrl = request.getContextPath() + "/admin/review/review_list.do?search_ficnic=" + search_ficnic + "&search_review=" + search_review + "&search_writer=" + search_writer;

        List<ReviewDTO> list = this.dao.getReviewList(dto.getStartNo(), dto.getEndNo(), searchMap);
        model.addAttribute("List", list);

        model.addAttribute("totalCount", totalRecord);
        model.addAttribute("paging", dto);
        model.addAttribute("search_ficnic", search_ficnic);
        model.addAttribute("search_review", search_review);
        model.addAttribute("search_writer", search_writer);
        model.addAttribute("pagingWrite", Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));

        return "admin/review/review_list";
    }



    @RequestMapping("admin/review/review_view.do")
    public String view(Model model, @RequestParam("no") int no) {
        ReviewDTO dto = this.dao.reviewView(no);
        model.addAttribute("dto", dto);

        return "admin/review/review_view";
    }



    @RequestMapping("admin/review/review_modify.do")
    public String update(@RequestParam("no") int no, Model model) {
        ReviewDTO dto = this.dao.reviewView(no);
        model.addAttribute("Modify", dto);

        return "admin/review/review_modify";
    }



    @RequestMapping("admin/review/review_modify_ok.do")
    public void updateOk(ReviewDTO dto, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        int check = this.dao.reviewModify(dto);

        if (check > 0) {
            out.println("<script>alert('리뷰가 수정되었습니다.'); location.href='review_view.do?no=" + dto.getReview_no() + "';</script>");
        } else {
            out.println("<script>alert('리뷰 수정에 실패했습니다.'); history.back();</script>");
        }

    }



    @RequestMapping("admin/review/review_delete.do")
    public void delete(@RequestParam("no") int no, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        int check = this.dao.reviewDelete(no);

        if (check > 0) {
            this.dao.updateSeq(no);
            out.println("<script>alert('리뷰가 삭제되었습니다.'); location.href='review_list.do';</script>");

        } else {
            out.println("<script>alert('리뷰 삭제에 실패했습니다.'); history.back();</script>");

        }
    }

}
