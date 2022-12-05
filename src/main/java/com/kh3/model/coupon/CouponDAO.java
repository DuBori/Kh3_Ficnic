package com.kh3.model.coupon;

import java.util.List;
import java.util.Map;

public interface CouponDAO {

    int getCouponCount(Map<String, Object> map);
    // 쿠폰 전체 리스트
    List<CouponDTO> getCouponList(int startNo, int endNo, Map<String, Object> map);

    int couponWrite(CouponDTO dto);
    // 쿠폰 보기
    CouponDTO couponView(int no);

    int couponModify(CouponDTO dto);

    int couponDelete(int no);

    void updateSeq(int no);

}
