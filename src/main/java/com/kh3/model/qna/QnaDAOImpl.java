package com.kh3.model.qna;

import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class QnaDAOImpl implements QnaDAO {

    @Inject
    private SqlSessionTemplate sqlSession;

    @Override
    public List<QnaDTO> getReviewList() {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public QnaDTO reviewView(int no) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public int reviewModify(QnaDTO dto) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int reviewDelete(int no) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public void updateSeq(int no) {
        // TODO Auto-generated method stub
        
    }




}