package com.kh3.model.member;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class WishDAOImpl implements WishDAO {

    @Inject
    private SqlSessionTemplate sqlSession;

	@Override
	public List<WishDTO> getMemberWishList(String attribute) {
		return this.sqlSession.selectList("siteWishList", attribute);
	}

	@Override
	public int wishCancel(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.sqlSession.delete("siteWishCancel", map);
	}





}
