package com.kh3.model.ficnic;

import java.util.List;

import com.kh3.model.coupon.CouponDTO;


public interface FicnicDAO {
	/* 피크닉 리스트 */
	List<FicnicDTO> getFicnicList();
	/* 피크닉 작성 */
	int writeFicnic(FicnicDTO dto,List<String> ficnic_imagesrc);
	/* 피크닉 정보 */
	FicnicDTO getFicnicCont(int no);
	/* 피크닉 수정 */
	int modifyFicnic(FicnicDTO dto,List<String> upload_list);
	/* 피크닉 삭제 */
	int deleteFicnic(int no);
	/* 피크닉 삭제 후 번호 정렬 */
	void updateSeq(int no);

}
