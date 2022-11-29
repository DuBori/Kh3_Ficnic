package com.kh3.model.review;

import java.util.List;

public interface ReviewDAO {

	List<ReviewDTO> getReviewList();

	ReviewDTO reviewView(int no);

    int reviewModify(ReviewDTO dto);

    int reviewDelete(int no);

    void updateSeq(int no);

 
}
