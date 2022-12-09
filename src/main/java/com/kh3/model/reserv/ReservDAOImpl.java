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
        map.put("search_type", searchMap.get("search_type"));
        map.put("startDate", searchMap.get("startDate"));
        map.put("endDate", searchMap.get("endDate"));
        map.put("search_no", searchMap.get("search_no"));
        map.put("search_id", searchMap.get("search_id"));
        map.put("search_name", searchMap.get("search_name"));

        return this.sqlSession.selectList("adminReservList", map);
	}
	
	// 예약 상세내역
	@Override
	public ReservDTO getReservView(int reserv_no) {
        return this.sqlSession.selectOne("adminReservView", reserv_no);
	}





}