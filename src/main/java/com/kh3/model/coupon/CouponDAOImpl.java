package com.kh3.model.coupon;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CouponDAOImpl implements CouponDAO {

    @Inject
    private SqlSessionTemplate sqlSession;





}