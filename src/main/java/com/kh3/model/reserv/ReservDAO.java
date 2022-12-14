package com.kh3.model.reserv;

import java.util.List;
import java.util.Map;



public interface ReservDAO {

    int getReservCount(Map<String, Object> map);	

    // 예약 전체 리스트
    List<ReservDTO> getReservList(int startNo, int endNo, Map<String, Object> map);


    // 예약 상세 내역
    ReservDTO getReservView(int reserv_no, String reserv_sess);

}
