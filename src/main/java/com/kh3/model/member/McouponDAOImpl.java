package com.kh3.model.member;

import java.util.List;

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





}