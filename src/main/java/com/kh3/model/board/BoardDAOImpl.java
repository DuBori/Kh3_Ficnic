package com.kh3.model.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAOImpl implements BoardDAO {

    @Inject
    private SqlSessionTemplate sqlSession;

	@Override
	public List<BoardDTO> getBoardList(String bbs_id) {
		return sqlSession.selectList("siteBoardList", bbs_id);	
	}

	/* 해당 게시판 테이블 개수 카운트 */
	@Override
	public int getListCount(String field, String keyword,String bbs_id) {
		 Map<String, Object> map = new HashMap<String, Object>();
	        map.put("field", field);
	        map.put("keyword", keyword);
	        map.put("bbs_id", bbs_id);

	   return this.sqlSession.selectOne("SiteBoardTotal", map);
		
	}

	/* 해당 게시판 리스트 */
	@Override
	public List<BoardDTO> getBoardList(int startNo, int endNo, Map<String, Object> map) {
		
		map.put("startNo", startNo);
		map.put("endNo", endNo);
	   
		return this.sqlSession.selectList("SiteBoardList", map);
	}

	@Override
	public int insertBoardCont(BoardDTO dto) {
		
		
		return 0;
	}
	
	/* 해당 게시판 > 해당 게시글 조회수 증가 */
	@Override
	public void updateBoardHit(Map<String, Object> map) {
		
		this.sqlSession.update("SiteBoardUpdateHit", map);
	}
	
	/* 해당 게시판 > 해당 게시글 출력 */
	@Override
	public BoardDTO getBoardCont(Map<String, Object> map) {
		
		return sqlSession.selectOne("SiteBoardDto",map);
	}



}