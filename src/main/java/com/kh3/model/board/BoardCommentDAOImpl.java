package com.kh3.model.board;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BoardCommentDAOImpl implements BoardCommentDAO {

    @Inject
    private SqlSessionTemplate sqlSession;

    /* 해당 게시판 > 해당 게시글 > 댓글 리스트 출력 */
	@Override
	public List<BoardCommentDTO> getBoardCommList(Map<String, Object> map) {
		
		return sqlSession.selectList("SiteBoardCommList", map);
	}
	/* 게시글 댓글 삭제 */
	@Override
	public int deleteBoardComm(Map<String, Object> map) {
		return this.sqlSession.delete("SiteBoardCommDelete", map);
	}
	/* 게시글 댓글 등록 */
	@Override
	public int insertBoardComm(Map<String, Object> map) {
		
		return this.sqlSession.insert("SiteBoardCommentInsert",map);
	}

	/* 게시글 댓글 개수 업데이트 처리 */
	@Override
	public void updateCommentCount(Map<String, Object> map) {
		this.sqlSession.update("SiteBoardCommentCount",map);
	}
	
	
	/* 게시글 삭제 시, 해당 게시글 댓글 전체 삭제 */
	@Override
	public void deleteBoardCommList(Map<String, Object> map) {
		/* 게시글 삭제 시, 해당 게시글 댓글 전체 삭제 */
		this.sqlSession.delete("SiteBoardCommDelList",map);	
	}
    





}
