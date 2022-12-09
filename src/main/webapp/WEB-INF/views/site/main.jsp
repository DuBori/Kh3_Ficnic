<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="layout/layout_header.jsp" %>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_main.css" />



<div class="contents w1100 main-page">


    <h2>메인페이지</h2>
    <br /><br />
    ${sess_id}
    <br /><br />
    <a href="<%=request.getContextPath()%>/admin/">관리자 모드</a>


</div>



<%@ include file="layout/layout_footer.jsp" %>