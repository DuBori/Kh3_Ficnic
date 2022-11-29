package com.kh3.model.board;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BoardConfDAOImpl implements BoardConfDAO {

    @Inject
    private SqlSessionTemplate sqlSession;





}