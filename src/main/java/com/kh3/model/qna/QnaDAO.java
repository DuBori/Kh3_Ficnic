package com.kh3.model.qna;

import java.util.List;


public interface QnaDAO {

	
	List<QnaDTO> getQnaList();

	QnaDTO qnaView(int no);

    int qnaModify(QnaDTO dto);

    int qnaDelete(int no);

    void qnaUpdateSeq(int no);

    
}