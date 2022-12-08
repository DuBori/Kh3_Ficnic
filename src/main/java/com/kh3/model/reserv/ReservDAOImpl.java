package com.kh3.model.reserv;

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
	public int getReservCount(Map<String, Object> map) {
		return 0;
	}

	@Override
	public List<ReservDTO> getReservList(int startNo, int endNo, Map<String, Object> map) {
		return null;
	}

	@Override
	public ReservDTO getReservView(int no) {
		return null;
	}





}