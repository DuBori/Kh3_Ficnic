package com.kh3.model.reserv;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ReservDAOImpl implements ReservDAO {

    @Inject
    private SqlSessionTemplate sqlSession;


    @Override
	public int getReservCount(Map<String, Object> searchMap) {
        return this.sqlSession.selectOne("adminReservCount", searchMap);
	}



    @Override
	public List<ReservDTO> getReservList(int startNo, int endNo, Map<String, Object> searchMap) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("startNo", startNo);
        map.put("endNo", endNo);
        map.put("search_status", searchMap.get("search_status"));
        map.put("search_date_start", searchMap.get("search_date_start"));
        map.put("search_date_end", searchMap.get("search_date_end"));
        map.put("search_sess", searchMap.get("search_sess"));
        map.put("search_ficnic", searchMap.get("search_ficnic"));
        map.put("search_name", searchMap.get("search_name"));

        return this.sqlSession.selectList("adminReservList", map);
	}
	


	// 예약 상세내역
	@Override
	public ReservDTO getReservView(int reserv_no, String reserv_sess) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("reserv_no", reserv_no);
        map.put("reserv_sess", reserv_sess);

        return this.sqlSession.selectOne("adminReservView", map);
	}





}