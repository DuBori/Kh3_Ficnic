<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인 후 참여 할 수 있습니다.'); history.back();</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_reserv.css" />
<script language="javascript" src="${path}/resources/site/js/js_reserv.js"></script>




<div class="page-info w1100">
    <h2>참여하기</h2>
    <ol>
        <li><a href="${path}/"><i class="icon-home"></i> HOME</a></li>
        <li>피크닉</li>
        <li><b>참여하기</b></li>
    </ol>
</div>



<div class="contents w1100 reserv-form">


    내용


</div>



<%@ include file="../layout/layout_footer.jsp" %>