package com.kh3.model.reserv;

import java.util.List;
import java.util.Map;



public interface ReservDAO {

    int getReservCount(Map<String, Object> map);	

    // 예약 전체 리스트
    List<ReservDTO> getReservList(int startNo, int endNo, Map<String, Object> map);


    // 예약 상세 내역
    ReservDTO getReservView(int reserv_no, String reserv_sess);


    // 예약 상태 변경
    int modifyReservStatus(int reserv_no, String reserv_sess, String reserv_status);


    // 예약 피크닉 날짜 변경
    int modifyReservFicnicDate(int reserv_no, String reserv_sess, String ficnic_date);

}
