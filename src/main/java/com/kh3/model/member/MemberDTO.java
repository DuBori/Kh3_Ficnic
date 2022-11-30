package com.kh3.model.member;

import lombok.Data;

@Data
public class MemberDTO {
	
	private int member_no;
	private String member_type;
	private String member_id;
	private String member_pw;
	private String member_name;
	private String member_email;
	private String member_phone;
	private int member_point;
	private String member_joindate;
	
	
}
