package com.kh3.model.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

    @Inject
    private SqlSessionTemplate sqlSession;


    @Override
    public int getReviewCount(Map<String, Object> searchMap) {
        return this.sqlSession.selectOne("adminReviewCount", searchMap);
    }


    @Override
    public List<ReviewDTO> getReviewList(int startNo, int endNo, Map<String, Object> searchMap) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("startNo", startNo);
        map.put("endNo", endNo);
        map.put("search_ficnic", searchMap.get("search_ficnic"));
        map.put("search_review", searchMap.get("search_review"));
        map.put("search_writer", searchMap.get("search_writer"));

        return this.sqlSession.selectList("adminReviewList", map);
    }


    @Override
    public ReviewDTO reviewView(int no) {
        return this.sqlSession.selectOne("adminReviewView", no);
    }


    @Override
    public int reviewModify(ReviewDTO dto) {
        return this.sqlSession.update("adminReviewModify", dto);
    }


    @Override
    public int reviewDelete(int no) {
        return this.sqlSession.delete("adminReviewDelete", no);
    }


    @Override
    public void updateSeq(int no) {
        this.sqlSession.update("adminReviewSeq", no);
    }

}