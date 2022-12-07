package com.kh3.model.member;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;


import lombok.Data;

@Data
public class MemberDTO {

	private int member_no;
	private String member_type;
	private int member_point;
	private String member_joindate;
	
	// min = 6 미만일 시 message 뜸
	@Size(min=6, message = "id")
    private String member_id;
    
	// 정규표현식, 맞지 않으면 message 뜸
    @Pattern(regexp = "(02|010)-\\d{3,4}-\\d{4}", message = "phone")
    private String member_phone;
    
    // 정규표현식, 맞지 않으면 message 뜸
    @Pattern(regexp = "(?=.*[0-9])(?=.*[a-z])(?=.*\\W)(?=\\S+$).{6,12}", message = "pw")
    private String member_pw;
    
    // 2이상 8미만, 아닐 시 message 뜸 (에러메시지)
    @Size(min=2, max=8, message = "name")
    private String member_name;
    
    // 정규 표현식, 맞지 않은 message 뜸
    @Pattern(regexp = "^[A-Za-z0-9_\\.\\-]+@[A-Za-z0-9\\-]+\\.[A-Za-z0-9\\-]+$", message = "email")
    private String member_email;
    
    // 비밀번호 확인 체크 변수
    @Pattern(regexp = "(?=.*[0-9])(?=.*[a-z])(?=.*\\W)(?=\\S+$).{6,12}", message = "pw_re")    
    private String member_pw_re;
    
}