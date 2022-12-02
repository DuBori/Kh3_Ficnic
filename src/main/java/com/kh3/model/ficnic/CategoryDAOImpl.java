package com.kh3.model.ficnic;

import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CategoryDAOImpl implements CategoryDAO {

    @Inject
    private SqlSessionTemplate sqlSession;



    @Override
    public List<CategoryDTO> getCategoryList() {
        return this.sqlSession.selectList("adminCategoryList");
    }





}