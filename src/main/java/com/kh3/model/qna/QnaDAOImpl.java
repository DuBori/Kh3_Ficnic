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
	public List<QnaDTO> getQnaList() {
		
		return this.sqlSession.selectList("adminQnaList");
		
	}

	@Override
	public QnaDTO qnaView(int no) {
		
		return this.sqlSession.selectOne("adminQnaView", no);
		
	}


	@Override
	public int qnaDelete(int no) {
		return this.sqlSession.delete("adminQnaDelete", no);

	}

	@Override
	public int qnaModify(QnaDTO dto) {
		return 0;
	}



}