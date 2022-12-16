package com.kh3.site.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.kh3.model.ficnic.FicnicDAO;
import com.kh3.model.ficnic.FicnicDTO;
import com.kh3.model.member.MemberDAO;
import com.kh3.model.member.MemberDTO;
import com.kh3.model.member.PointDAO;
import com.kh3.model.member.PointDTO;
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
	private ReservDAO reservDAO;
	
	@Autowired
	private MemberDAO mdao;

    BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
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
    // 마이페이지 - 회원정보 수정 페이지 이동
    // =====================================================================================
    @RequestMapping("mypage/mypage_info_modify.do")
    public String midify(Model model, HttpSession session, HttpServletRequest request) {
      
    	session = request.getSession();
    	String id = (String) session.getAttribute("sess_id");
    	
    	MemberDTO dto = this.mdao.getReservMember(id);
    	model.addAttribute("member", dto);


        return "site/mypage/mypage_info_modify";
        
    }

    
 // =====================================================================================
    // 마이페이지 - 회원정보 수정
    // =====================================================================================
    @RequestMapping("mypage/mypage_info_modifyOk.do")
    public void modifyOk(@Valid MemberDTO dto, BindingResult result, PointDTO pdto,
                        @RequestParam("pw") String member_pw, HttpServletResponse response) throws IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 비밀번호 일치 확인
        if (!member_pw.equals(dto.getMember_pw_re())) {
            out.println("<script>alert('[비밀번호]가 일치하지 않습니다. 다시 입력해주세요.'); history.back();</script>");

        } else if (member_pw.length() > 0) {
        	
        	// 새로운 비밀번호로 수정,  암호화 설정
            dto.setMember_pw(passwordEncoder.encode(member_pw));

            // 유효성 검사
            if (result.hasErrors()) {
                List<ObjectError> list = result.getAllErrors();

                for (ObjectError error : list) {
                    if (error.getDefaultMessage().equals("pw_re")) {
                        out.println("<script>alert('비밀번호는 영문자와 숫자, 특수기호가 적어도 1개 이상 포함된 6자~12자의 비밀번호여야 합니다.'); history.back();</script>");
                        break;
                    } else if (error.getDefaultMessage().equals("email")) {
                        out.println("<script>alert('잘못된 이메일 형식입니다. 다시 입력해 주세요.'); history.back();</script>");
                        break;
                    } else if (error.getDefaultMessage().equals("phone")) {
                        out.println("<script>alert('잘못된 전화번호 형식입니다. 다시 입력해 주세요.'); history.back();</script>");
                        break;
                    }
                }
            }


            int check = this.mdao.modifyOk(dto);
            if (check > 0) {
                out.println("<script>alert('회원 정보가 수정되었습니다.'); location.href='mypage_info_modify.do';</script>");
            } else {
                out.println("<script>alert('회원 정보 수정 중 에러가 발생하였습니다.'); history.back();</script>");
            }


        // 기존에 가지고 있던 비밀번호로 수정
        } else {
            // 유효성 검사
            if (result.hasErrors()) {
                List<ObjectError> list = result.getAllErrors();

                for (ObjectError error : list) {
                    if (error.getDefaultMessage().equals("email")) {
                        out.println("<script>alert('잘못된 이메일 형식입니다. 다시 입력해 주세요.'); history.back();</script>");
                        break;
                    } else if (error.getDefaultMessage().equals("phone")) {
                        out.println("<script>alert('잘못된 전화번호 형식입니다. 다시 입력해 주세요.'); history.back();</script>");
                        break;
                    }
                }
            }

            int check = this.mdao.modifyOk(dto);
            if (check > 0) {
                // 적립금이 바뀌면 실행
                if (pdto.getPoint_add() > 0) {
                    // 관리자 수정 포인트 적립
                    this.pdao.modifyPoint(pdto);
                }
                out.println("<script>alert('회원 정보가 수정되었습니다.'); location.href='mypage_info_modify.do';</script>");
            } else {
                out.println("<script>alert('회원 정보 수정 중 에러가 발생하였습니다.'); history.back();</script>");
            }

        }
        
        

    }







}