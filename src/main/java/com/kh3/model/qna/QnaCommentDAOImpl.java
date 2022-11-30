package com.kh3.model.qna;

import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository

public class QnaCommentDAOImpl implements QnaCommentDAO {
	@Inject
	private SqlSessionTemplate sqlSession;


	
	@Override
	public List<QnaCommentDTO> getQnaCommentList(int no) {
		
		return this.sqlSession.selectList("adminQnaCommentList", no);
	}
	
	
	@Override
	public int qnaReply(QnaCommentDTO dto) {
		
		return this.sqlSession.insert("adminQnaCommentReply", dto);
		
	}

	
	@Override
	public int qnaCommentDelete(int no) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void qnaCommentUpdateSeq(int no) {
		// TODO Auto-generated method stub
		
	}


	}
