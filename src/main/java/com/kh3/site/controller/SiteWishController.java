package com.kh3.site.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh3.model.member.WishDAO;

@Controller
public class SiteWishController {

	@Inject
	private WishDAO wdao;
	
	// =====================================================================================
    // 찜 취소하기
    // =====================================================================================
	@RequestMapping("mypage/wish_cancel.do")
	public String wishCancel(
			HttpSession session,@RequestParam(value = "ficnic_no") int ficnic_no
			){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("ficnic_no", ficnic_no);
		map.put("sess_id", (String)session.getAttribute("sess_id"));
		
		this.wdao.wishCancel(map);
		
		return "mypage/mypage_wish_list.do";
		

		
	}
}
