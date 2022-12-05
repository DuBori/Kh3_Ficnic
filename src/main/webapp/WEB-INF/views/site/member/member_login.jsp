<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<c:set var="dto" value="${dto}" />

<!-- <script type="text/javascript">

		$(function(){
		$("#btnLogin").click(function(){
		let	member_id = $("#member_id").val();
		 let member_pw = $("#member_pw").val(); 
		 
		 if(member_id == ""){
		  alert("아이디를 입력하세요");
		  $("#member_id").focus(); //입력포커스 이동
		
		  return; //함수 종료
		}
		 
		if(member_pw==""){
		 alert("비밀번호를 입력하세요"); 
		 $("#member_pw").focus();
		  return;
		}
		//폼 내부의 데이터를 전송할 주소
/* 		 document.form1.action= "${path}/member/member_login_check.do";
		 document.form1.submit(); //제출 */
		 });
		});
		</script> -->

<body>
	<h2>로그인</h2>
	<form name="form1" method="post" action="<%=request.getContextPath() %>/site/member/member_login_check.do">
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
					

				</td>
			</tr>
		</table>
	</form>
</body>
</html>