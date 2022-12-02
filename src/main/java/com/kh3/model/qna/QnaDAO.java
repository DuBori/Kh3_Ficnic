package com.kh3.model.qna;

import java.util.List;
import java.util.Map;


public interface QnaDAO {

    int getQnaCount(Map<String, Object> map);

    List<QnaDTO> getQnaList(int startNo, int endNo, Map<String, Object> map);

    QnaDTO qnaView(int no);

    int qnaDelete(int no);

}