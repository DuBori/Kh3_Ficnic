package com.kh3.model.coupon;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CouponDAOImpl implements CouponDAO {

    @Inject
    private SqlSessionTemplate sqlSession;


    // 쿠폰 목록 총 갯수
    @Override
    public int getCouponCount(Map<String, Object> map) {
        return 0;
    }


    // 쿠폰 목록
    @Override
    public List<CouponDTO> getCouponList(int startNo, int endNo, Map<String, Object> map) {
        return null;
    }


    // 쿠폰 등록
    @Override
    public int couponWrite(CouponDTO dto) {
        return 0;
    }


    // 쿠폰 보기
    @Override
    public CouponDTO couponView(int no) {
        return null;
    }


    // 쿠폰 수정
    @Override
    public int couponModify(CouponDTO dto) {
        return 0;
    }


    // 쿠폰 삭제
    @Override
    public int couponDelete(int no) {
        return 0;
    }


    // 쿠폰 번호 재작업
    @Override
    public void updateSeq(int no) {
    }

}