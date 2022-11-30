package com.kh3.model.member;

public interface PointDAO {
	
	// 회원 가입 포인트 적립
	void joinPoint(PointDTO pdto);
	
	// 관리자 적립금 수정
	void modifyPoint(PointDTO pdto);
	

}
