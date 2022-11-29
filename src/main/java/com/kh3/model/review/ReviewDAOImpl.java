package com.kh3.model.review;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

    @Inject
    private SqlSessionTemplate sqlSession;





}