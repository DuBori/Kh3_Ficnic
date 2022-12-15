package com.kh3.site.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SiteMypageController {



    // =====================================================================================
    // 마이페이지 - 예약 목록
    // =====================================================================================
    @RequestMapping("mypage/mypage_reserv_list.do")
    public String reserv_list() {
        return "site/mypage/mypage_reserv_list";
    }





    // =====================================================================================
    // 마이페이지 - 위시 리스트
    // =====================================================================================
    @RequestMapping("mypage/mypage_wish_list.do")
    public String wish_list() {
        return "site/mypage/mypage_wish_list";
    }





    // =====================================================================================
    // 마이페이지 - 쿠폰 보관함
    // =====================================================================================
    @RequestMapping("mypage/mypage_coupon_list.do")
    public String coupon_list() {
        return "site/mypage/mypage_coupon_list";
    }





    // =====================================================================================
    // 마이페이지 - 적립금 내역
    // =====================================================================================
    @RequestMapping("mypage/mypage_point_list.do")
    public String point_list() {
        return "site/mypage/mypage_point_list";
    }





    // =====================================================================================
    // 마이페이지 - 내 1:1 문의 목록
    // =====================================================================================
    @RequestMapping("mypage/mypage_qna_list.do")
    public String qna_list() {
        return "site/mypage/mypage_qna_list";
    }





    // =====================================================================================
    // 마이페이지 - 회원정보 수정
    // =====================================================================================
    @RequestMapping("mypage/mypage_info_modify.do")
    public String info_modify() {
        return "site/mypage/mypage_info_modify";
    }








}