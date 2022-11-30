package com.kh3.model.board;

import java.util.List;


public interface BoardConfDAO {

	int writeBoard(BoardConfDTO dto);
	
	List<BoardConfDTO> getConfBoardList(int startNo, int endNo, String keyword);
	
	BoardConfDTO getCont(int board_no);

	int updateBoard(BoardConfDTO dto);
	
	int deleteBoard(int board_no);
	
	//페이징 처리
	int getListCount(String keyword);

}
