<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>



<div class="page-info w1100">
    <h2>회원 가입</h2>
    <ol>
        <li><a href="/"><i class="icon-home"></i> HOME</a></li>
        <li><b>회원 가입</b></li>
    </ol>
</div>

<div class="contents w1100">


<form name="form_input" method="post" action="<%=request.getContextPath() %>/member/member_join_ok.do">
			
			<!-- 아이디 -->
						
			<div class="form-group">
				<label for="user_id">아이디</label>
					<input type="text" class="form-control" id="member_id" name="member_id" placeholder="6자 이상" required>
			</div>
			<!-- 비밀번호 -->
			<div class="form-group">
				<label for="user_pw">비밀번호</label>
					<input type="password" class="form-control" id="member_pw" name="member_pw" placeholder="8자 이상의 영문, 숫자, 특수문자 조합" required>
				<div class="check_font" id="pw_check"></div>
			</div>
			<!-- 비밀번호 재확인 -->
			<div class="form-group">
				<label for="user_pw2">비밀번호 확인</label>
					<input type="password" class="form-control" id="member_pw_re" name="member_pw_re" placeholder="동일한 비밀번호를 입력해주세요" required>
				<div class="check_font" id="pw2_check"></div>
			</div>
			<!-- 이름 -->
			<div class="form-group">
				<label for="user_name">이름</label>
					<input type="text" class="form-control" id="member_name" name="member_name" required>
				<div class="check_font" id="name_check"></div>
			</div>
			<!-- 본인확인 이메일 -->
			<div class="form-group">
				<label for="user_email">이메일</label>
					<input type="text" class="form-control" name="member_email" id="member_email" required>
					<div class="check_font" id="email_check"></div>
			</div>
			<!-- 휴대전화 -->
			<div class="form-group">
				<label for="user_phone">휴대전화</label>
				<input type="text" class="form-control" id="member_phone" name="member_phone" placeholder="ex) 000-0000-0000" required>
				<div class="check_font" id="phone_check"></div>
			</div>
			
			<div class="reg_button">
				<a class="btn btn-danger px-3" href="${pageContext.request.contextPath}">
					<i class="fa fa-rotate-right pr-2" aria-hidden="true"></i>취소하기
				</a>&emsp;&emsp;
				<button class="btn btn-primary px-3" id="reg_submit">
					<i class="fa fa-heart pr-2" aria-hidden="true"></i>가입하기
				</button>
			</div>
		</form>


</form>

</div>

<%@ include file="../layout/layout_footer.jsp" %>