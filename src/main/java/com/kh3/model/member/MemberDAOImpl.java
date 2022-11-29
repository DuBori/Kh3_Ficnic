package com.kh3.model.member;

import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAOImpl implements MemberDAO {

    @Inject
    private SqlSessionTemplate sqlSession;
    
    // 회원 전체 리스트 가져오기
	@Override
	public List<MemberDTO> getMemberList() {

		return this.sqlSession.selectList("adminMemberList"); 
	}
	

	// 회원 상세내역 리스트 가져오기
	@Override
	public MemberDTO getMemberView(int no) {
	
		return this.sqlSession.selectOne("adminMemberView", no);
	}


	// 회원 등록하기
	@Override
	public int writeOkMember(MemberDTO dto) {
		
		return this.sqlSession.insert("writeOk", dto);
	}
    
   






}