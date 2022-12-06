<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="id" value="${id }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<div class="container page-title">
    <h2>FIND RESULT</h2>
</div>

<div class="container member-form result">
    <div class="mf-wrap">
        <legend>🎆아이디 찾기 결과🎆</legend>
        <br />

        <div class="mf-result">회원님의 아이디는 <br /> <strong>${id }</strong> 입니다.</div>

        <div class="mf-btn">
            <p><a href="<%=request.getContextPath()%>/member/member_login.do">로그인</a></p>
        </div>
    </div>
</div>


</body>
</html>