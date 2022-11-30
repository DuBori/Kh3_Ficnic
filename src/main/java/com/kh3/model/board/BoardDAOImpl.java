package com.kh3.model.board;

import java.util.List;

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





}