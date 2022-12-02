package com.kh3.admin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.eclipse.jdt.internal.compiler.ast.ThisReference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh3.model.coupon.CouponDTO;
import com.kh3.model.ficnic.CategoryDAO;
import com.kh3.model.ficnic.CategoryDTO;
import com.kh3.model.ficnic.FicnicDAO;

@Controller
public class AdminFicnicController {

    @Inject
    private FicnicDAO dao;

    @Inject
    private CategoryDAO cdao;



    // 한 페이지당 보여질 게시물의 수
    private final int rowsize = 10;

    // 전체 게시물의 수
    private int totalRecord = 0;



    // 피크닉 목록 페이지
    @RequestMapping("admin/ficnic/ficnic_list.do")
    public String ficnicList(Model model, HttpServletRequest request) {
        return "admin/ficnic/ficnic_list";
    }



    // 피크닉 보기 페이지
    @RequestMapping("admin/ficnic/ficnic_view.do")
    public String ficnicView(Model model, @RequestParam("no") int no) {
        return "admin/ficnic/ficnic_view";
    }



    // 피크닉 등록 페이지
    @RequestMapping("admin/ficnic/ficnic_write.do")
    public String ficnicWrite() {
        return "admin/ficnic/ficnic_write";
    }



    // 피크닉 등록 처리
    @RequestMapping("admin/ficnic/ficnic_write_ok.do")
    public void ficnicWriteOk(CouponDTO dto, HttpServletResponse response) throws Exception {
    }



    // 피크닉 수정 페이지
    @RequestMapping("admin/ficnic/ficnic_modify.do")
    public String ficnicModify(@RequestParam("no") int no, Model model) {
        return "admin/ficnic/ficnic_modify";
    }



    // 피크닉 수정 처리
    @RequestMapping("admin/ficnic/ficnic_modify_ok.do")
    public void ficnicModifyOk(CouponDTO dto, HttpServletResponse response) throws Exception {
    }



    // 피크닉 삭제 처리
    @RequestMapping("admin/ficnic/ficnic_delete.do")
    public void ficnicDelete(@RequestParam("no") int no, HttpServletResponse response) throws Exception {
    }



    

    // 카테고리 관리 목록 페이지
    @RequestMapping("admin/ficnic/category_list.do")
    public String categoryList(Model model) {
        List<CategoryDTO> list = cdao.getCategoryList();
        model.addAttribute("clist", list);

        return "admin/ficnic/category_list";
    }


    // 카테고리 정렬 순서 저장
    @RequestMapping("admin/ficnic/category_rank_ok.do")
    public void categoryRank(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String[] cateid = request.getParameterValues("category_id[]");
        for(int i=0; i<cateid.length; i++) {
            cdao.setCategoryRank(cateid[i], i+1);
        }

        PrintWriter out = response.getWriter();
        out.println("<script>location.href='category_list.do';</script>");
    }


    // 카테고리 추가
    @RequestMapping("admin/ficnic/category_write_ok.do")
    public void categoryWrite(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String ps_ctid = request.getParameter("ps_ctid");
        String category_show = request.getParameter("category_show");
        String category_name = request.getParameter("category_name");

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        int check = cdao.addCategory(ps_ctid, category_show, category_name);
        if(check > 0) {
            out.println("<script>location.href='category_list.do';</script>");
        }else{
            out.println("<script>alert('카테고리 등록 중 에러가 발생하였습니다.'); history.back();</script>");
        }
    }


    // 카테고리 수정
    @RequestMapping("admin/ficnic/category_modify_ok.do")
    public void categoryModify(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String ps_ctid = request.getParameter("ps_ctid");
        String category_show = request.getParameter("category_show");
        String category_name = request.getParameter("category_name");

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        int check = cdao.modifyCategory(ps_ctid, category_show, category_name);
        if(check > 0) {
            out.println("<script>location.href='category_list.do';</script>");
        }else{
            out.println("<script>alert('카테고리 수정 중 에러가 발생하였습니다.'); history.back();</script>");
        }
    }


    // 카테고리 삭제
    @RequestMapping("admin/ficnic/category_delete.do")
    public void categoryDelete(@RequestParam("category_no") int category_no, @RequestParam("ps_ctid") String ps_ctid, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        int check = cdao.deleteCategory(ps_ctid);
        if(check > 0) {
            cdao.updateCategorySeq(category_no);
            cdao.updateCategoryFicnic(ps_ctid);
            out.println("<script>location.href='category_list.do';</script>");
        }else{
            out.println("<script>alert('카테고리 삭제 중 에러가 발생하였습니다.'); history.back();</script>");
        }
    }




}