<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_mypage.css" />
<script language="javascript" src="${path}/resources/site/js/js_mypage.js"></script>


<c:set var="mypage_eng" value="info" />
<c:set var="mypage_kor" value="회원정보 수정" />


<%@ include file="../layout/layout_mymenu.jsp" %>



<div class="contents w1100 mypage-info">


    내용


</div>



<%@ include file="../layout/layout_footer.jsp" %>