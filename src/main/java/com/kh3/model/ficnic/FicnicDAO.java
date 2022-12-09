package com.kh3.model.ficnic;

import java.util.List;
import java.util.Map;


public interface FicnicDAO {
    /* 피크닉 리스트 */
    List<FicnicDTO> getFicnicList();

    /* 피크닉 검색 리스트 */
    List<FicnicDTO> getFicnicList(int startNo, int endNo, Map<String, Object> map);

    /* 피크닉 작성 */
    int writeFicnic(FicnicDTO dto, List<String> ficnic_imagesrc);

    /* 피크닉 정보 */
    FicnicDTO getFicnicCont(int no);

    /* 피크닉 수정 */
    int modifyFicnic(FicnicDTO dto, List<String> upload_list);

    /* 피크닉 삭제 */
    int deleteFicnic(int no);

    /* 피크닉 삭제 후 번호 정렬 */
    void updateSeq(int no);

    /* 피크닉 사진 삭제 */
    void deleteFicnicImage(int no, int img_no);

    /* 피크닉 검색 상품 개수 */
    int getListCount(Map<String, Object> map);

    /* 피크닉 데이터 존재 위치 리스트 */
    List<String> getFicnicLocationList();

    /* 쿠폰 상세 내역에서 상품 정보 찾기 */
    String checkFicnic(String string);

    /* 리뷰 수정시 총점 수정 */
    void updateReviewPoint(int ficnic_no);

}
