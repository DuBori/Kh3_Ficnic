package com.kh3.model.member;

import java.util.List;

public interface McouponDAO {
	
	// 회원 쿠폰 내역 보여주기
	List<McouponDTO> getCouponView(String id);

}
