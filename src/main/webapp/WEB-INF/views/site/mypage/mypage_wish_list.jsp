<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_mypage.css" />
<script language="javascript" src="${path}/resources/site/js/js_mypage.js"></script>


<c:set var="mypage_eng" value="wish" />
<c:set var="mypage_kor" value="위시 리스트" />


<%@ include file="../layout/layout_mymenu.jsp" %>



<div class="contents w1100 mypage-reserv">


    <div class="mypage-wish-mainDiv d-flex flex-column w1000 border">   	
    	<!-- 위시 리스트 출력  -->
    	<div class="mypage-wish-subDiv d-flex flex-row flex-wrap justify-content-center border">
    	
    		<c:forEach begin="1" end="5">
    			<div class="mypage-wish card w-20 m-1 p-1 d-flex flex-column border justify-content-center align-items-center ">
					  <img src="${path }/resources/data/ficnic/ficnic_1_1670922773527.jpg" class="card-img-top" style="width:200px" alt="...">
					  <div class="mypage-wish card-body">
					    <p class="card-location">지역</p>
					    <h5 class="card-title">피크닉 제목</h5>
					  </div>
					  <ul class="mypage-wish list-group list-group-flush">
					    <li class="list-group-item">별점 ★★★★★ (후기 개수자리)</li>
					    <li class="list-group-item">가격 자리</li>
					  </ul>
					  <div class="mypage-wish card-body">
					    <a href="#" class="card-link">찜 취소하기</a>
					  </div>
				</div>
    						
    		</c:forEach>
    		
    	</div>
    	
    </div>

	<div class="col-md-4 text-center mt-3">
	      ${pagingWrite}
	</div>

</div>



<%@ include file="../layout/layout_footer.jsp" %>