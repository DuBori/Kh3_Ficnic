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

	@Override
	public int deleteBoardComm(Map<String, Object> map) {
		return this.sqlSession.delete("SiteBoardCommDelete", map);
	}

	@Override
	public int insertBoardComm(Map<String, Object> map) {
		
		return this.sqlSession.insert("SiteBoardCommentInsert",map);
	}
    





}
