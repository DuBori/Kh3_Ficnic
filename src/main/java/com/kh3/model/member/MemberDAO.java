package com.kh3.model.member;

import java.util.List;
import java.util.Map;

public interface MemberDAO {

    int getMemberCount(Map<String, Object> map);

    // 회원 전체 리스트
    List<MemberDTO> getMemberList(int startNo, int endNo, Map<String, Object> map);

    // 회원 상세 내역
    MemberDTO getMemberView(int no);

    // 회원 아이디 중복 체크
    int checkId(String userId);

    // 회원 추가
    int writeOkMember(MemberDTO dto);

    // 회원 삭제
    int deleteMember(int no);

    // 회원 삭제 후 글번호 재작업
    void updateSequence(int no);

    // 회원 정보 수정
    int modifyOk(MemberDTO dto);
    
    // 로그인 아이디체크
    int loginCheck(MemberDTO dto);
    
    // 비밀번호 체크
    int pwCheck(MemberDTO dto);
    
    // 아이디 찾기 - 모두
    int findIdAll(MemberDTO dto);
    
    // 아이디 찾기 - 이메일만
    int findIdEmail(MemberDTO dto);
    
    // 결과 출력창에 아이디 보내기
    String findId(MemberDTO dto);
    
    // 비밀번호 찾기 - 모두
    int findPwAll(MemberDTO dto);
    
    // 결과 출력창에 비밀번호 보내기
    String findPw(MemberDTO dto);
    
    int idCheck(MemberDTO dto);
    
    int joinMember(MemberDTO dto);
    
}
