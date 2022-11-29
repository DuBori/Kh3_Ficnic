package com.kh3.model.qna;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class QnaDAOImpl implements QnaDAO {

    @Inject
    private SqlSessionTemplate sqlSession;




}