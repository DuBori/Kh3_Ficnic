package com.kh3.model.member;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class McouponDAOImpl implements McouponDAO {

    @Inject
    private SqlSessionTemplate sqlSession;
    
    // 회원 쿠폰내역 보여주기
	@Override
	public List<McouponDTO> getCouponView(String id) {
		return this.sqlSession.selectList("siteMcouponList", id);
	}

	// 사용한 회원 쿠폰 삭제하기
	@Override
	public void deleteMemberCoupon(Map<String, Object> couponMap) {
		
		this.sqlSession.delete("siteMemberCouponDelete", couponMap);
		
	}

	@Override
	public McouponDTO getCouponNum(Map<String, Object> couponMap) {
		return this.sqlSession.selectOne("siteMemberCouponNum", couponMap);
	}

	@Override
	public void updateMcouponNo(int coupon_no) {
		
		this.sqlSession.update("siteMCouponNumUpdate", coupon_no);
		
	}





}