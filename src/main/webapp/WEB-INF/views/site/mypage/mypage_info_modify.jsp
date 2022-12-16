<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp"%>
<c:if test="${empty sess_id}">
	<script type="text/javascript">
		alert('회원 로그인이 필요합니다.');
		location.href = '${path}/member/member_login.do';
	</script>
</c:if>

<link type="text/css" rel="stylesheet"
	href="${path}/resources/site/css/css_mypage.css" />
<script language="javascript"
	src="${path}/resources/site/js/js_mypage.js"></script>


<c:set var="mypage_eng" value="info" />
<c:set var="mypage_kor" value="회원정보 수정" />
<c:set var="dto" value="${member}" />


<%@ include file="../layout/layout_mymenu.jsp"%>




<div class="contents w1100 mypage-info">

	<form name="form_input" method="post"
		action="${path}/mypage/mypage_info_modifyOk.do">

		<table>

			<input type="hidden" name="pw" value="${dto.getMember_pw()}">
		
			<!-- 아이디 -->
			<tr>
				<td><label for="member_id">아이디</label>
				<input class="join_id" id="member_id" name="member_id" value="${dto.getMember_id()}" readonly></td>
			</tr>
			
			<!-- 비밀번호 -->
			<tr>
				<td><label for="member_pw">변경할 비밀번호</label>
				<input type="password" class="join_pw placeholder_mod" id="member_pw" name="member_pw" placeholder="8자 이상의 영문, 숫자, 특수문자 조합" required></td>
					<div class="check_font join_check join_pw_check" id="pw_check"></div>
			</tr>
			
			<!-- 비밀번호 재확인 -->
			<tr>
				<td><label for="member_pw">비밀번호 재입력</label>
				<input type="password" class="join_pw_re placeholder_mod" id="member_pw_re" name="member_pw_re" placeholder="비밀번호를 다시 입력해주세요." required></td>
					<div class="check_font join_check join_pw_re_check" id="pw_re_check"></div>
			</tr>
			
			<!-- 이름 -->
			<tr>
				<td><label for="member_name">이름</label>
				<input id="member_name" name="member_name" value="${dto.getMember_name()}"></td>
			</tr>
			
			<!-- 이메일 -->
			<tr>
				<td><label for="member_email">이메일</label>
				<input type="email" class="join_email" id="member_email" name="member_email" value="${dto.getMember_email()}" 
				onkeydown="EmailInput(this);" required></td>
					<div id="mailchk-txt" class="check_font join_check join_mail_check"></div>
					<input type="hidden" name="mailchk_join" value="false" />
			</tr>
			
			<!-- 연락처 -->
			<tr>
				<td><label for="member_phone">연락처</label>
				<input class="join_check join_phone" id="member_phone" name="member_phone"
					value="${dto.getMember_phone()}" onkeydown="NumSpInput(this);" required></td>
					<div class="check_font join_check join_phone_check" id="phone_check"></div></td>
			</tr>
			
			<tr>
				<td><input type="submit" class="btnMod" value="수정하기"></td>
			</tr>
			
		</table>

	</form>



</div>



<%@ include file="../layout/layout_footer.jsp"%>