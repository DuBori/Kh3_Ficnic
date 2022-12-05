package com.kh3.model.ficnic;

import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class FicnicDAOImpl implements FicnicDAO {

    @Inject
    private SqlSessionTemplate sqlSession;

	/* 피크닉 상품 리스트 출력 */
	@Override
	public List<FicnicDTO> getFicnicList() {
		return this.sqlSession.selectList("adminFicnicList");
	}





}