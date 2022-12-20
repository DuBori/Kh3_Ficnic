<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_mypage.css" />
<script language="javascript" src="${path}/resources/site/js/js_mypage.js"></script>


<c:set var="mypage_eng" value="wish" />
<c:set var="mypage_kor" value="위시 리스트" />


<%@ include file="../layout/layout_mymenu.jsp" %>



<div class="contents w1100 mypage-reserv">


    <div class="mypage-wish-mainDiv d-flex flex-column w1000 ">   	
    	<!-- 위시 리스트 출력  -->
    	<ul class="ficnic-list">
    	
    		<c:forEach items="${List}" var="dto">
    			<c:set var="fdto" value="${dto.getFicnic_cont() }"/>
    			<c:set var="move_ficnic_info" value="onclick=\"location.href='${path}/ficnic/ficnic_view.do?ficnic_no=${fdto.getFicnic_no()}'\""/>

    			<li>
    				 <button type="button" onclick="if(confirm('위시리스트에서 삭제하시겠습니까?')){ location.href='${path}/mypage/wish_cancel.do?ficnic_no=${fdto.getFicnic_no()}'; }else{ return false; }"><i class="fa fa-heart"></i></button>
					  <img ${move_ficnic_info } src="${path}/${fdto.getFicnic_photo1()}" class="fl-photo">
					  <div ${move_ficnic_info } class="fl-info">
						    <div class="fli-location">${fdto.getFicnic_location() }</div>
						    <div class="fli-name">${fdto.getFicnic_name() }</div>

						    <div ${move_ficnic_info }  class="fli-review">
								<span><i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i></span>
								후기(${fdto.getFicnic_review_count()})
							</div>
						 	<div class="fli-price">	
								<p class="sale">		
									<fmt:formatNumber value="${fdto.getFicnic_sale_price()}"/>원
								</p>
							</div>						
					  </div>
				</li>						
    		</c:forEach>
    	</ul>
    </div>

	<div class="col-md-4 text-center mt-3">
	      ${pagingWrite}
	</div>

</div>



<%@ include file="../layout/layout_footer.jsp" %>