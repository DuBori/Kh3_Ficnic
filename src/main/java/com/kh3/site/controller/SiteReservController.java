package com.kh3.site.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh3.model.reserv.ReservDAO;
import com.kh3.model.reserv.ReservDTO;


@Controller
public class SiteReservController {

	@Inject
	private ReservDAO reservDAO;

	/* 회원 예약 상세 페이지 */
	@RequestMapping("mypage/mypage_reserv_view.do")
	public	void mypage_reserv_view(
			@RequestParam( value = "reserv_no",required = false, defaultValue ="1" )int reserv_no,
			HttpSession session,HttpServletRequest request,
			HttpServletResponse response
			) throws IOException
	{
		ReservDTO dto=reservDAO.getResevCont(reserv_no);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out =  response.getWriter();
		
		if(session.getAttribute("sess_id").equals(dto.getMember_id())){
			out.println("<script>location.href='"+request.getContextPath()+"/mypage/mypage_reserv_view_ok.do?reserv_no="+reserv_no+"';</script>");
		}else {
			out.println("<script>alert('잘못된 접근입니다.');history.back();</script>");
		}
	}
	/* 회원 예약 상세 페이지 확인 이동*/
	@RequestMapping("mypage/mypage_reserv_view_ok.do")
	public String mypage_reserv_viewOk( @RequestParam("reserv_no") int reserv_no
			,Model model) {
	
		ReservDTO dto=reservDAO.getResevCont(reserv_no);
		
		model.addAttribute("reservDto", dto);
		
		return "site/mypage/mypage_reserv_view";
	}
	
	@RequestMapping("mypage/mypage_reserv_cancel.do")
	public void mypage_reserv_cancel(
			@RequestParam("reserv_no") int reserv_no,
			@RequestParam("reserv_sess") String reserv_sess ,
			HttpServletRequest request,
			HttpServletResponse response ) throws IOException {
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out =  response.getWriter();
		
		if(this.reservDAO.modifyReservStatus(reserv_no, reserv_sess, "cancel")>0) {
			out.println("<script>location.href='"+request.getContextPath()+"/mypage/mypage_reserv_view.do';</script>");
		}else {
			out.println("<script>alert('예약취소 실패');history.back();</script>");
		}
		
	}






}