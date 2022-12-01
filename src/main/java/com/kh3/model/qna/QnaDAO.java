package com.kh3.model.qna;

import java.util.List;

import com.kh3.model.review.ReviewDTO;


public interface QnaDAO {

	
	List<QnaDTO> getQnaList();

	QnaDTO qnaView(int no);

    int qnaDelete(int no);

    int qnaModify(QnaDTO dto);

    
}