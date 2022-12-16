package com.kh3.site.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.kh3.model.ficnic.FicnicDAO;
import com.kh3.model.ficnic.FicnicDTO;
import com.kh3.model.member.McouponDAO;
import com.kh3.model.member.McouponDTO;
import com.kh3.model.member.MemberDAO;
import com.kh3.model.member.PointDAO;
import com.kh3.model.member.PointDTO;
import com.kh3.model.member.WishDAO;
import com.kh3.model.member.WishDTO;
import com.kh3.model.qna.QnaCommentDAO;
import com.kh3.model.qna.QnaCommentDTO;
import com.kh3.model.qna.QnaDAO;
import com.kh3.model.qna.QnaDTO;
import com.kh3.model.reserv.ReservDAO;
import com.kh3.util.PageDTO;
import com.kh3.util.Paging;


@Controller
public class SiteMypageController {

    @Autowired
    private PointDAO pdao;
    
    @Autowired
    private QnaDAO qdao;

  
    @Inject
    private WishDAO wdao;
    
	@Inject
	private ReservDAO reservDAO;

	@Inject
	private McouponDAO mcouponDAO;
	
    // 한 페이지당 보여질 게시물의 수
    private final int rowsize = 10;


    // 전체 게시물의 수
    private int totalRecord = 0;
    
    // =====================================================================================
    // 마이페이지 - 예약 목록
    // =====================================================================================
    @RequestMapping("mypage/mypage_reserv_list.do")
    public String reserv_list(
    		@RequestParam( value = "page", required = false, defaultValue = "1") int page,
    		@RequestParam( value = "field", required = false, defaultValue = "") String field,
    		@RequestParam( value = "keyword", required = false, defaultValue = "") String keyword,
    		@RequestParam( value = "getType", required = false, defaultValue = "") String getType,
    		Model model,
    		HttpServletRequest request,
    		HttpSession session) {
   
    	
    	String member_id = (String) session.getAttribute("sess_id");
    	
    	Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("field", field);
		searchMap.put("keyword", keyword);
		searchMap.put("member_id", member_id);
		searchMap.put("getType", getType);
		
		totalRecord = this.reservDAO.getSiteReservCount(searchMap);

		PageDTO dto = new PageDTO(page, rowsize, totalRecord, searchMap);


		// 페이지 이동 URL
		String pageUrl = request.getContextPath()+"mypage/mypage_reserv_list.do?field=" + field + "&keyword=" + keyword+"&page="+page;
		
		model.addAttribute("List", this.reservDAO.getBoardList(dto.getStartNo(), dto.getEndNo(), searchMap));
		model.addAttribute("paging", dto);
		model.addAttribute("field", field);
		model.addAttribute("keyword", keyword);
		model.addAttribute("page", page);
		
		model.addAttribute("getType", getType);
		
		model.addAttribute("pagingWrite",Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));
		
        return "site/mypage/mypage_reserv_list";
    }





    // =====================================================================================
    // 마이페이지 - 위시 리스트
    // =====================================================================================
    @RequestMapping("mypage/mypage_wish_list.do")
    public String wish_list(
    		HttpSession session,
    		Model model
    		) {
    	
    	List<WishDTO> List=wdao.getMemberWishList((String)session.getAttribute("sess_id"));
   
    	model.addAttribute("List", List);
    	
        return "site/mypage/mypage_wish_list";
    }





    // =====================================================================================
    // 마이페이지 - 쿠폰 보관함
    // =====================================================================================
    @RequestMapping("mypage/mypage_coupon_list.do")
    public String coupon_list(
    		HttpSession session, Model model) {
    	
    	List<McouponDTO> List =  this.mcouponDAO.getCouponView((String)session.getAttribute("sess_id"));
    	
    	model.addAttribute("List", List);
        return "site/mypage/mypage_coupon_list";
    }





    // =====================================================================================
    // 마이페이지 - 적립금 내역
    // =====================================================================================
    @RequestMapping("mypage/mypage_point_list.do")
    public String point_list(Model model, HttpSession session, HttpServletRequest request) {
    	session = request.getSession();
    	String id = (String) session.getAttribute("sess_id");
    	
    	List<PointDTO> pList = this.pdao.getPointView(id);
    	model.addAttribute("pList", pList);
        return "site/mypage/mypage_point_list";
    }





    // =====================================================================================
    // 마이페이지 - 내 1:1 문의 목록
    // =====================================================================================
    @RequestMapping("mypage/mypage_qna_list.do")
    public String qna_list(Model model, HttpSession session, HttpServletRequest request) {
    	session = request.getSession();
    	String id = (String) session.getAttribute("sess_id");    	
    	
    	List<QnaDTO> qList = this.qdao.siteQnaList(id);
    	model.addAttribute("qList", qList);
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