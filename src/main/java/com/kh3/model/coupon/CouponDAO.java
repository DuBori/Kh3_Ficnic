package com.kh3.model.coupon;

import java.util.List;
import java.util.Map;

public interface CouponDAO {

    int getCouponCount(Map<String, Object> map);
    // 쿠폰 전체 리스트
    List<CouponDTO> getCouponList(int startNo, int endNo, Map<String, Object> map);
    // 쿠폰 등록
    int couponWrite(CouponDTO dto);
    // 쿠폰 보기
    CouponDTO couponView(int no);
    // 쿠폰 수정
    int couponModify(CouponDTO dto);
    // 쿠폰 삭제
    int couponDelete(int no);
    // 쿠폰번호 재작업
    void updateSeq(int no);
    

}
