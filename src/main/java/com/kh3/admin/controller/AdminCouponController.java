package com.kh3.admin.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh3.model.coupon.CouponDAO;
import com.kh3.model.coupon.CouponDTO;
import com.kh3.model.ficnic.CategoryDAO;
import com.kh3.model.ficnic.CategoryDTO;
import com.kh3.util.PageDTO;
import com.kh3.util.Paging;

@Controller
public class AdminCouponController {

    @Autowired
    private CouponDAO dao;
    
    @Autowired
    private CategoryDAO cdto;

    // 한 페이지당 보여질 게시물의 수
    private final int rowsize = 10;

    // 전체 게시물의 수
    private int totalRecord = 0;



    // 쿠폰 목록 페이지
    @RequestMapping("admin/coupon/coupon_list.do")
    public String couponList(Model model, HttpServletRequest request) {
        // 검색 처리
        String search_type = request.getParameter("search_type");
        if (search_type == null) search_type = "";

        String search_name = request.getParameter("search_name");
        if (search_name == null) search_name = "";

        Map<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("search_type", search_type);
        searchMap.put("search_name", search_name);


        // 페이징 처리
        int page; // 현재 페이지 변수
        if (request.getParameter("page") != null && request.getParameter("page") != "") {
            page = Integer.parseInt(request.getParameter("page"));
        } else {
            page = 1;
        }
        totalRecord = this.dao.getCouponCount(searchMap);

        // 페이징 DTO
        PageDTO dto = new PageDTO(page, rowsize, totalRecord, searchMap);

        // 페이지 이동 URL
        String pageUrl = request.getContextPath() + "/admin/coupon/coupon_list.do?search_type=" + search_type + "&search_name=" + search_name;

        List<CouponDTO> list = this.dao.getCouponList(dto.getStartNo(), dto.getEndNo(), searchMap);
        model.addAttribute("List", list);

        model.addAttribute("totalCount", totalRecord);
        model.addAttribute("paging", dto);
        model.addAttribute("search_type", search_type);
        model.addAttribute("search_name", search_name);
        model.addAttribute("pagingWrite", Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));

        return "admin/coupon/coupon_list";
    }


    // 쿠폰 상세내역 페이지
    @RequestMapping("admin/coupon/coupon_view.do")
    public String couponView(Model model, @RequestParam("no") int no, CategoryDTO cdto) {
        CouponDTO dto = this.dao.couponView(no);
        String check = "";
        // 쿠폰을 사용할 수 있는 카테고리 내역 가져오기
        if(dto.getCoupon_use_value() != null) {
        	String[] category = dto.getCoupon_use_value().split("★");
        	for(int i=0;i<category.length;i++) {
        		check += "☆"+this.cdto.checkCategory(category[i]);
        	}
        	model.addAttribute("category", check);
        }
        model.addAttribute("dto", dto);
        
        return "admin/coupon/coupon_view";
    }


    // 쿠폰 등록 페이지
    @RequestMapping("admin/coupon/coupon_write.do")
    public String couponWrite() {
        return "admin/coupon/coupon_write";
    }


    // 쿠폰 등록하기
    @RequestMapping("admin/coupon/coupon_write_ok.do")
    public void couponWriteOk(CouponDTO dto, @RequestParam("coupon_date_valueCheck") String coupon_date_valueCheck, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        // 발급 후 값 입력 했을때
        if(dto.getCoupon_date_type().equals("after")) {
        	dto.setCoupon_date_value(Integer.parseInt(coupon_date_valueCheck));
        }
        
        String value = "";
        String[] category = dto.getCoupon_category_value().split(",");
        for(int i = 0; i < category.length; i++) {
        	value += category[i]+"★";
        }
        
        dto.setCoupon_use_value(value);
        int check = this.dao.couponWrite(dto);
        
        if (check > 0) {
            out.println("<script>alert('쿠폰이 추가되었습니다.'); location.href='coupon_list.do';</script>");
        } else {
            out.println("<script>alert('쿠폰 추가 실패했습니다.'); history.back();</script>");
        }        
        
    }


    // 쿠폰 수정 페이지
    @RequestMapping("admin/coupon/coupon_modify.do")
    public String couponModify(@RequestParam("no") int no, Model model) {
        CouponDTO dto = this.dao.couponView(no);
        model.addAttribute("Modify", dto);

        return "admin/coupon/coupon_modify";
    }


    // 쿠폰 수정하기
    @RequestMapping("admin/coupon/coupon_modify_ok.do")
    public void couponModifyOk(CouponDTO dto, @RequestParam("coupon_date_valueCheck") String coupon_date_valueCheck, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        System.out.println("값 ========= " + coupon_date_valueCheck);
        // 발급 후 값 입력 했을때
        if(dto.getCoupon_date_type().equals("after")) {
        	dto.setCoupon_date_value(Integer.parseInt(coupon_date_valueCheck));
        }
        if(dto.getCoupon_price_type().equals("cart")) {
        	dto.setCoupon_use_value("null");
        }else {
        	System.out.println("값111111111111111111111111111111111111111");
        	String value = "";
        	String[] category = dto.getCoupon_category_value().split(",");
        	System.out.println("값222222222222222222222222222222222222222" + dto.getCoupon_category_value());
        	for(int i = 0; i < category.length; i++) {
        		value += category[i]+"★";
        		System.out.println("값33333333333333333333333333333333333333333");
        	}
        	dto.setCoupon_use_value(value);
        }
        
        	
        System.out.println("+++++++++++++++" + dto.getCoupon_category_value());
        System.out.println("값5555555555555555555555555555555555555555555555");
        int check = this.dao.couponModify(dto);
        System.out.println("값666666666666666666666666666666666666666666666");
      
        if (check > 0) {
        	System.out.println("값7777777777777777777777777777777777777777777777");
            out.println("<script>alert('쿠폰이 수정되었습니다.'); location.href='coupon_view.do?no=" + dto.getCoupon_no() + "';</script>");
        } else {
        	System.out.println("값888888888888888888888888888888888888888");
            out.println("<script>alert('쿠폰 수정에 실패했습니다.'); history.back();</script>");
        }
        System.out.println("값999999999999999999999999999999999999999");

    }


    // 쿠폰 삭제
    @RequestMapping("admin/coupon/coupon_delete.do")
    public void couponDelete(@RequestParam("no") int no, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        int check = this.dao.couponDelete(no);
        
        if (check > 0) {
            this.dao.updateSeq(no);
            out.println("<script>alert('쿠폰이 삭제되었습니다.'); location.href='coupon_list.do';</script>");

        } else {
            out.println("<script>alert('쿠폰 삭제에 실패했습니다.'); history.back();</script>");

        }
    }

}
