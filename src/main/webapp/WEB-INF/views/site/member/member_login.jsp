<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>

<c:set var="dto" value="${dto}" />


<div class="page-info w1100" align="center">
    <h2>로그인</h2>
    <ol>
        <li><a href="/"><i class="icon-home"></i> HOME</a></li>
        <li><b>로그인</b></li>
    </ol>
</div>



<div class="contents w1100" align="center">


	<form name="form1" method="post" action="<%=request.getContextPath() %>/member/member_login_check.do">
		<table border="1" width="400px">
			<tr>
				<td>아이디</td>
				<td><input id="member_id" name="member_id" required="required" placeholder="회원 아이디"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" id="member_pw" name="member_pw" required="required" placeholder="비밀번호"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" id="btnLogin" value="로그인"> 


		<div class="mf-find"><a href="<%=request.getContextPath()%>/member/member_find.do">
		<i class="fa fa-question-circle"></i> 아이디/비밀번호 찾기</a></div>

				</td>
			</tr>
		</table>
	</form>


</div>



<%@ include file="../layout/layout_footer.jsp" %>