package com.kh3.model.review;

import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

    @Inject
    private SqlSessionTemplate sqlSession;

	@Override
	public List<ReviewDTO> getReviewList() {
		
		return this.sqlSession.selectList("adminReviewList"); 

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