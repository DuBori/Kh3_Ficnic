package com.kh3.model.board;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BoardCategoryDAOImpl implements BoardCategoryDAO {

    @Inject
    private SqlSessionTemplate sqlSession;






}