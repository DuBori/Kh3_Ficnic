package com.kh3.model.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BoardConfDAOImpl implements BoardConfDAO {

    @Inject
    private SqlSessionTemplate sqlSession;

	@Override
	public int writeBoard(BoardConfDTO dto) {
		
	
		sqlSession.insert("adminBoardConfCategory",dto);
		sqlSession.insert("adminBoardConfComment",dto);
		sqlSession.insert("adminBoardConfData",dto);
		
		return sqlSession.insert("adminBoardConfCount",dto);
	}

	@Override
	public List<BoardConfDTO> getConfBoardList() {
		
		return sqlSession.selectList("adminBoardConfList");
	}

	@Override
	public BoardConfDTO getCont(int board_no) {
		
		return sqlSession.selectOne("adminBoardConfCon",board_no);
		
	}

	@Override
	public int updateBoard(BoardConfDTO dto) {
		return sqlSession.update("adminBoardUpdate", dto);
	}





}