<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>

	<div align="center">
    <form name="find_form" method="post" action="<%=request.getContextPath()%>/member/member_find_id_result.do">
    
	<h2>아이디/ 비밀번호 찾기</h2>
            <a href="javascript:location.reload();" class="login-tab-list__item active" role="tab" aria-controls="tab-panel1">아이디 찾기</a>
            <a href="<%=request.getContextPath()%>/member/member_find_pw.do" class="login-tab-list__item" role="tab" aria-controls="tab-panel2">비밀번호 찾기</a>

            <p><input type="email" name="member_email" placeholder="가입한 이메일" required autofocus /></p>
            <p id="fid"><input type="text" name="member_name" placeholder="가입한 이름" required /></p>

            <p><button type="submit"> 아이디 찾기 </button></p>
            <p><a href="<%=request.getContextPath()%>/member/member_login.do">로그인</a></p>
        
            </form>
        </div>

</body>
</html>