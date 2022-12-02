package com.kh3.model.coupon;

import java.util.List;
import java.util.Map;

public interface CouponDAO {

    int getCouponCount(Map<String, Object> map);

    List<CouponDTO> getCouponList(int startNo, int endNo, Map<String, Object> map);

    int couponWrite(CouponDTO dto);

    CouponDTO couponView(int no);

    int couponModify(CouponDTO dto);

    int couponDelete(int no);

    void updateSeq(int no);

}
