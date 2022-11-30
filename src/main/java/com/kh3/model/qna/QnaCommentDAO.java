package com.kh3.model.qna;

import java.util.List;

public interface QnaCommentDAO {


	QnaCommentDTO qnaCommentView(int no);

    int qnaCommentDelete(int no);

    void qnaCommentUpdateSeq(int no);

	List<QnaCommentDTO> getQnaCommentList(int no);

    
}
