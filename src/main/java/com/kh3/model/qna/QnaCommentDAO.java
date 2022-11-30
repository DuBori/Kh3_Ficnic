package com.kh3.model.qna;


public interface QnaCommentDAO {


	QnaCommentDTO qnaCommentView(int no);

    int qnaCommentDelete(int no);

    void qnaCommentUpdateSeq(int no);
    
}
