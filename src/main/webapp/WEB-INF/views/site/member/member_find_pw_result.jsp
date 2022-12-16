<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${!empty sess_id}"><script type="text/javascript">alert('이미 로그인 되어 있습니다.'); history.back();</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_member.css" />
<script language="javascript" src="${path}/resources/site/js/js_member.js"></script>




<div class="page-info w1100">
    <h2>FIND RESULT</h2>
    <ol>
        <li><a href="/"><i class="icon-home"></i> HOME</a></li>
        <li>비밀번호 찾기</li>
        <li><b>비밀번호 찾기 결과</b></li>
    </ol>
</div>
    
    
    
<div class="contents w1100 member-find-result" align="center">
				
            	<p> 회원님의 임시 비밀번호는 </p>
            	<p> <strong>${pw }</strong> 입니다.</p>
            	<p class="pBtn"> <a href="${path}/member/member_login.do">로그인</p>
    </div>



<%@ include file="../layout/layout_footer.jsp" %>