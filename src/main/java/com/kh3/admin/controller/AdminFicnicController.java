package com.kh3.admin.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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




}