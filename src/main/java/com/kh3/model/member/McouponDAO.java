package com.kh3.model.member;

import java.util.List;
import java.util.Map;

public interface McouponDAO {
	
	// 회원 쿠폰 내역 보여주기
	List<McouponDTO> getCouponView(String id);

	// 사용한 회원 쿠폰 삭제하기
	void deleteMemberCoupon(Map<String, Object> couponMap);

	// 해당 회원 보유 해당 쿠폰 가져오기 
	McouponDTO getCouponNum(Map<String, Object> couponMap);

	// 회원 사용 해당 쿠폰 제거 후 번호 정렬
	void updateMcouponNo(int coupon_no);
	
	// 쿠폰 삭제 시 회원쿠폰 가지고 있는거 삭제
	void mCouponDelete(int no);

}
