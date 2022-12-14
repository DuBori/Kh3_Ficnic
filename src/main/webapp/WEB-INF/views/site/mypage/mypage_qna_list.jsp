<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_mypage.css" />
<script language="javascript" src="${path}/resources/site/js/js_mypage.js"></script>




<div class="page-info w1100">
    <h2>내 1:1 문의 내역</h2>
    <ol>
        <li><a href="/"><i class="icon-home"></i> HOME</a></li>
        <li>마이페이지</li>
        <li><b>내 1:1 문의 내역</b></li>
    </ol>
</div>



<div class="contents w1100 mypage-qna">


    내용


</div>



<%@ include file="../layout/layout_footer.jsp" %>