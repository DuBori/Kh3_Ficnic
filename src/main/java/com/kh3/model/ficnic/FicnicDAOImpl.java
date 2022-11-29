package com.kh3.model.ficnic;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class FicnicDAOImpl implements FicnicDAO {

    @Inject
    private SqlSessionTemplate sqlSession;





}