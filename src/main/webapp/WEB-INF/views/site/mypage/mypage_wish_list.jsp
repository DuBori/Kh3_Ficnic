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
    	
    		<c:forEach items="${List}" var="dto">
    			<c:set var="fdto" value="${dto.getFicnic_cont() }"/>
    			<c:set var="move_ficnic_info" value="onclick=\"location.href='${path}/ficnic/ficnic_view.do?ficnic_no=${fdto.getFicnic_no()}'\""/>
    			
    			<div class="mypage-wish card w-20 m-1 p-1 d-flex flex-column border justify-content-center align-items-center " >
					  <img ${move_ficnic_info } src="${path}/${fdto.getFicnic_photo1()}" class="card-img-top" style="width:200px" alt="...">
					  <div ${move_ficnic_info } class="mypage-wish card-body">
					    <p class="card-location">${fdto.getFicnic_location() }</p>
					    <h5 class="card-title">${fdto.getFicnic_name() }</h5>
					  </div>
					  <ul ${move_ficnic_info } class="mypage-wish">
					    <li class="card-text">별점 ★★★★★ (${fdto.getFicnic_review_count() })</li>
					    <li class="card-text"><fmt:formatNumber value="${fdto.getFicnic_sale_price()}"/>원</li>
					  </ul>
					  <div class="mypage-wish card-body">
					    <a href="${path}/mypage/wish_cancel.do?ficnic_no=${fdto.getFicnic_no()}" class="card-link card-text">찜 취소하기</a>
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