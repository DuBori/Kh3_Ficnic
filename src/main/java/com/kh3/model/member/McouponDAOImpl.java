package com.kh3.model.member;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class McouponDAOImpl implements McouponDAO {

    @Inject
    private SqlSessionTemplate sqlSession;





}