package com.kh3.model.qna;

import java.util.List;
import java.util.Map;


public interface QnaDAO {

    int getQnaCount(Map<String, Object> map);

    List<QnaDTO> getQnaList(int startNo, int endNo, Map<String, Object> map);

    QnaDTO qnaView(int no);

    int qnaDelete(int no);
    
    // 마이페이지 문의글 리스트
	List<QnaDTO> siteQnaList(String id);
	
	// 문의글 수정
	int qnaModify(QnaDTO dto);
	
	// 문의글 추가
	int qnaWriteOk(QnaDTO dto);

}