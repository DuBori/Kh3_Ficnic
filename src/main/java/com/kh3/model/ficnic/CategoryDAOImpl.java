package com.kh3.model.ficnic;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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



    @Override
    public void setCategoryRank(String cateid, int rank) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("cateid", cateid);
        map.put("rank", rank);

        this.sqlSession.update("adminCategoryRank", map);
    }





}