<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${!empty sess_id}"><script type="text/javascript">alert('이미 로그인 되어 있습니다.'); history.back();</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_member.css" />
<script language="javascript" src="${path}/resources/site/js/js_member.js"></script>



<div class="page-info w1100">
    <h2>아이디 찾기</h2>
    <ol>
        <li><a href="/"><i class="icon-home"></i> HOME</a></li>
        <li><b>아이디 찾기</b></li>
    </ol>
</div>




<div class="contents w1100 member-find">



	<div align="center">
    <form name="find_form" method="post" action="<%=request.getContextPath()%>/member/member_find_id_result.do">
    
            <a href="javascript:location.reload();" class="login-tab-list__item active" role="tab" aria-controls="tab-panel1">아이디 찾기</a>
            <a href="<%=request.getContextPath()%>/member/member_find_pw.do" class="login-tab-list__item" role="tab" aria-controls="tab-panel2">비밀번호 찾기</a>

            <p><input type="email" name="member_email" placeholder="가입한 이메일" required autofocus /></p>
            <p id="fid"><input type="text" name="member_name" placeholder="가입한 이름" required /></p>

            <p><button type="submit"> 아이디 찾기 </button></p>
            <p><a href="${path}/member/member_login.do">로그인</a></p>
        
            </form>
        </div>


</div>



<%@ include file="../layout/layout_footer.jsp" %>