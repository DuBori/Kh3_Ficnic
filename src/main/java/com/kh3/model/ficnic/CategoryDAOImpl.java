package com.kh3.model.ficnic;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CategoryDAOImpl implements CategoryDAO {

    @Inject
    private SqlSessionTemplate sqlSession;





}