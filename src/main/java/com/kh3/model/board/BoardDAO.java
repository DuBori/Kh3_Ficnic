package com.kh3.model.board;

import java.util.List;

public interface BoardDAO {

	List<BoardDTO> getBoardList(String bbs_id);
	
}
