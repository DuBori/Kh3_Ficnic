package com.kh3.model.member;

import java.util.List;


public interface MemberDAO {
	
	// 회원 전체 리스트
	List<MemberDTO> getMemberList();
	
	// 회원 상세 내역
	MemberDTO getMemberView(int no);

	int writeOkMember(MemberDTO dto);

	
	
	
	
}
