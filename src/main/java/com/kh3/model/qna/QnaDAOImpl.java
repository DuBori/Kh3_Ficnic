package com.kh3.model.qna;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class QnaDAOImpl implements QnaDAO {

    @Inject
    private SqlSessionTemplate sqlSession;


    @Override
    public int getQnaCount(Map<String, Object> searchMap) {
        return this.sqlSession.selectOne("adminQnaCount", searchMap);
    }


    @Override
    public List<QnaDTO> getQnaList(int startNo, int endNo, Map<String, Object> searchMap) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("startNo", startNo);
        map.put("endNo", endNo);
        map.put("search_ficnic", searchMap.get("search_ficnic"));
        map.put("search_qna", searchMap.get("search_qna"));
        map.put("search_writer", searchMap.get("search_writer"));

        return this.sqlSession.selectList("adminQnaList", map);
    }


    @Override
    public QnaDTO qnaView(int no) {
        return this.sqlSession.selectOne("adminQnaView", no);
    }


    @Override
    public int qnaDelete(int no) {
        return this.sqlSession.delete("adminQnaDelete", no);
    }

    // 마이페이지 문의글 리스트
	@Override
	public List<QnaDTO> siteQnaList(String member_id) {
		return this.sqlSession.selectList("siteQnaList", member_id);
	}

}