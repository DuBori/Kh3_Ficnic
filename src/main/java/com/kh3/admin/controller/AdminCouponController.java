package com.kh3.admin.controller;

import java.io.PrintWriter;
import java.lang.System.Logger;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import com.kh3.model.ficnic.FicnicDAO;
import com.kh3.util.PageDTO;
import com.kh3.util.Paging;

@Controller
public class AdminCouponController {

    @Autowired
    private CouponDAO dao;

    @Autowired
    private CategoryDAO cdao;

    @Autowired
    private FicnicDAO fdao;


    // 한 페이지당 보여질 게시물의 수
    private final int rowsize = 10;

    // 전체 게시물의 수
    private int totalRecord = 0;



    // 쿠폰 목록 페이지
    @RequestMapping("admin/coupon/coupon_list.do")
    public String couponList(Model model, HttpServletRequest request) {
        // 검색 처리
        String search_type = request.getParameter("search_type");
        if (search_type == null)
            search_type = "";

        String search_name = request.getParameter("search_name");
        if (search_name == null)
            search_name = "";

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
        String pageUrl = request.getContextPath() + "/admin/coupon/coupon_list.do?search_type=" + search_type
                + "&search_name=" + search_name;

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


        // 카테고리 쿠폰일 경우
        List<HashMap<String, Object>> cateList = new ArrayList<HashMap<String,Object>>();
        if(dto.getCoupon_use_type().equals("category")) {
            String epd_cate[] = dto.getCoupon_use_value().split("★");

            for(int i=0; i<epd_cate.length; i++) {
                CategoryDTO ccdto = cdao.getCategoryCont(epd_cate[i]);
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("cate_id", ccdto.getCategory_id());
                map.put("cate_path", ccdto.getCategory_path());
                cateList.add(map);
            }
        }


        model.addAttribute("dto", dto);
        model.addAttribute("cateList", cateList);

        return "admin/coupon/coupon_view";
    }



    // 쿠폰 등록 페이지
    @RequestMapping("admin/coupon/coupon_write.do")
    public String couponWrite(Model model) {
        LocalDate startNowDate = LocalDate.now(); // 이번달 첫째
        String startDate = startNowDate.format(DateTimeFormatter.ofPattern("yyyy-MM-01"));
        LocalDate endNowDate = LocalDate.now().with(TemporalAdjusters.lastDayOfMonth()); // 오늘로부터 30일후 까지
        String endDate = endNowDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        List<CategoryDTO> cList = cdao.getCategoryList();

        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("clist", cList);

        return "admin/coupon/coupon_write";
    }



    // 쿠폰 등록하기
    @RequestMapping("admin/coupon/coupon_write_ok.do")
    public void couponWriteOk(CouponDTO dto, HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        String coupon_date_valueCheck = request.getParameter("coupon_date_valueCheck");
        String[] coupon_use_category_value = request.getParameterValues("coupon_use_category_value[]");


        // 카테고리 쿠폰일때 카테고리 지정
        if(coupon_use_category_value != null) {
            String done_use_category_value = "";
            for(int i=0; i<coupon_use_category_value.length; i++) {
                done_use_category_value += coupon_use_category_value[i] + "★";
            }
            done_use_category_value = done_use_category_value.substring(0, done_use_category_value.length() - 1);
            dto.setCoupon_use_value(done_use_category_value);
        }


        // 발급 후 값 입력 했을때
        if (dto.getCoupon_date_type().equals("after")) {
            dto.setCoupon_date_value(Integer.parseInt(coupon_date_valueCheck));
        }


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
        List<CategoryDTO> cList = cdao.getCategoryList();

        // 카테고리 쿠폰일 경우
        List<HashMap<String, Object>> cateList = new ArrayList<HashMap<String,Object>>();
        if(dto.getCoupon_use_type().equals("category")) {
            String epd_cate[] = dto.getCoupon_use_value().split("★");

            for(int i=0; i<epd_cate.length; i++) {
                CategoryDTO cdto = cdao.getCategoryCont(epd_cate[i]);
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("cate_id", cdto.getCategory_id());
                map.put("cate_path", cdto.getCategory_path());
                cateList.add(map);
            }
        }

        model.addAttribute("Modify", dto);
        model.addAttribute("clist", cList);
        model.addAttribute("cateList", cateList);

        return "admin/coupon/coupon_modify";
    }



    // 쿠폰 수정하기
    @RequestMapping("admin/coupon/coupon_modify_ok.do")
    public void couponModifyOk(CouponDTO dto, HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();


        String coupon_date_valueCheck = request.getParameter("coupon_date_valueCheck");
        String[] coupon_use_category_value = request.getParameterValues("coupon_use_category_value[]");


        // 발급 후 값 입력 했을때
        if (dto.getCoupon_date_type().equals("after")) {
            dto.setCoupon_date_value(Integer.parseInt(coupon_date_valueCheck));
        }


        // 쿠폰 사용 구분 = 장바구니 일때
        if (dto.getCoupon_use_type().equals("cart")) {
            dto.setCoupon_use_value(null);

        // 쿠폰 사용 구분 = 카테고리 일때
        } else if (dto.getCoupon_use_type().equals("category")) {
            if(coupon_use_category_value != null) {
                String done_use_category_value = "";
                for(int i=0; i<coupon_use_category_value.length; i++) {
                    done_use_category_value += coupon_use_category_value[i] + "★";
                }
                done_use_category_value = done_use_category_value.substring(0, done_use_category_value.length() - 1);
                dto.setCoupon_use_value(done_use_category_value);
            }
        }


        int check = this.dao.couponModify(dto);
        if (check > 0) {
            out.println("<script>alert('쿠폰이 수정되었습니다.'); location.href='coupon_list.do';</script>");
        } else {
            out.println("<script>alert('쿠폰 수정에 실패했습니다.'); history.back();</script>");
        }
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
