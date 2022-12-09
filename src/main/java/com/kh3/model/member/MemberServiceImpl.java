package com.kh3.model.member;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	
	MemberDAO memberDao;
	
	@Override
	public String loginSession(MemberDTO dto, HttpSession session) {
	String name = memberDao.loginSession(dto);
	 if (name != null) { // 세션 변수 저장
	  session.setAttribute("member_id", dto.getMember_id());
	  session.setAttribute("member_name", name);
	}
	 return name; 
	}

	@Override
	public void logout(HttpSession session) {
	 session.invalidate(); // 세션 초기화
	 }
	}

