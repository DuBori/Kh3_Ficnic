package com.kh3.model.review;

import java.util.List;
import java.util.Map;

public interface ReviewDAO {

    int getReviewCount(Map<String, Object> map);

    List<ReviewDTO> getReviewList(int startNo, int endNo, Map<String, Object> map);

    ReviewDTO reviewView(int no);

    int reviewModify(ReviewDTO dto);

    int reviewDelete(int no);

    void updateSeq(int no);
    
    List<ReviewDTO> getList();

	List<ReviewDTO> getNumList(int ficnic_no);

	int writeOkReview(ReviewDTO dto);
	


	

	List<ReviewDTO> getListSession(String member_id);

}
