package com.kh3.model.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAOImpl implements MemberDAO {

    @Inject
    private SqlSessionTemplate sqlSession;


    @Override
    public int getMemberCount(Map<String, Object> searchMap) {
        return this.sqlSession.selectOne("adminMemberCount", searchMap);
    }


    // 회원 전체 리스트 가져오기
    @Override
    public List<MemberDTO> getMemberList(int startNo, int endNo, Map<String, Object> searchMap) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("startNo", startNo);
        map.put("endNo", endNo);
        map.put("search_type", searchMap.get("search_type"));
        map.put("search_name", searchMap.get("search_name"));
        map.put("search_id", searchMap.get("search_id"));
        map.put("search_email", searchMap.get("search_email"));
        map.put("search_phone", searchMap.get("search_phone"));

        return this.sqlSession.selectList("adminMemberList", map);
    }



    // 회원 상세내역 리스트 가져오기
    @Override
    public MemberDTO getMemberView(int no) {
        return this.sqlSession.selectOne("adminMemberView", no);
    }



    // 회원 아이디 중복 체크
    @Override
    public int checkId(String userId) {
        return this.sqlSession.selectOne("checkId", userId);
    }



    // 회원 등록하기
    @Override
    public int writeOkMember(MemberDTO dto) {
        return this.sqlSession.insert("adminMemberwriteOk", dto);
    }



    // 회원 삭제
    @Override
    public int deleteMember(int no) {
        return this.sqlSession.delete("adminMemberdelete", no);
    }



    // 회원 삭제 후 글번호 재작업
    @Override
    public void updateSequence(int no) {
        this.sqlSession.update("adminMemberSequence", no);
    }



    // 회원 정보 수정
    @Override
    public int modifyOk(MemberDTO dto) {
        return this.sqlSession.update("adminMemberModifyOk", dto);
    }


    // 로그인 체크
	@Override
	public int loginCheck(MemberDTO dto) {
		return this.sqlSession.selectOne("siteMemberLogin", dto);
	}
	
	// 비밀번호 체크 체크
	@Override
	public int pwCheck(MemberDTO dto) {
		return this.sqlSession.selectOne("siteMemberLoginPw", dto);
	}


	@Override
	public int findIdAll(MemberDTO dto) {
		return this.sqlSession.selectOne("siteMemberfindId", dto);
	}

	
	@Override
	public int findIdEmail(MemberDTO dto) { 
		return this.sqlSession.selectOne("siteMemberFindIdEmail", dto);
	}

	@Override
	public int findPw(MemberDTO dto) {
		return this.sqlSession.selectOne("siteMemberfindPw", dto);
	}


}