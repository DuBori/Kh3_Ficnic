<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:set var="dto" value="${fdto }" />
<c:set var="rdto" value="${rList }" />
<c:set var="totalCount" value="${count }" />
<c:set var="rcount" value="${rcount }" />

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_ficnic.css?${time}" />
<script language="javascript" src="${path}/resources/site/js/js_ficnic.js?${time}"></script>



<div class="page-info w1100">
    <h2>리뷰 보기</h2>
    <ol>
        <li><a href="${path}/"><i class="icon-home"></i> HOME</a></li>
        <li>피크닉</li>
        <li>${dto.ficnic_name }</li>
        <li><b>리뷰 보기</b></li>
        
    </ol>
</div>


<div class="contents w1100 ficnic-review" align="left">
    
    
    <div>
		<ul class="mypage-reserv d-flex flex-row justify-content-end">
			<li>
			<a class="mr-2 text-dark orderfc" href="ficnic_review.do?ficnic_no=${fdto.getFicnic_no()}&getType=pointH">평점 높은 순</a>|</li>
			
			<li>
			<a class="ml-2 mr-2 text-dark orderfc" href="ficnic_review.do?ficnic_no=${fdto.getFicnic_no()}&getType=pointL">평점 낮은 순</a>|</li>
			
			<li>
			<a  class="ml-2 mr-2 text-dark orderfc" href="ficnic_review.do?ficnic_no=${fdto.getFicnic_no()}&getType=pointD">최신 순</a></li>
		</ul>
	</div> 
    
    


	
		
	<p class="r_one"><b><fmt:formatNumber value="${totalCount}" /></b>명의 대원들이 리뷰를 남겼어요. 😀 </p>
	<p class="r_two"> 평균 별점은 <b><fmt:formatNumber value="${rcount / totalCount}" 
	pattern=".0"></fmt:formatNumber></b>점이에요! </p>


		
	<hr color="lightgray">
	
	<c:forEach items="${rdto}" var="rdto">
			<div class="fvtc-review">
				<div class="fvtcr-star">

	<c:if test="${rdto.review_point > 0 and rdto.review_point <= 2}"><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:if>
	<c:if test="${rdto.review_point > 2 and rdto.review_point <= 4}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:if>
	<c:if test="${rdto.review_point > 4 and rdto.review_point <= 6}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:if>
	<c:if test="${rdto.review_point > 6 and rdto.review_point <= 8}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i></c:if>
	<c:if test="${rdto.review_point > 8}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i></c:if>
		<b class="notstar">${rdto.review_point}</b>
				</div>
			</div>
		<b><p class="rname">${rdto.review_name }</p></b>
		<b><p class="rdate">${rdto.review_date.substring(0,16) } 작성</p></b>
		<b><p class="rcont">${rdto.review_cont }</p></b>
		<b><p class="rfname"> <a class="rficnic"href='ficnic_view.do?category=${dto.ficnic_category_no }&ficnic_no=${rdto.ficnic_no}'>${dto.ficnic_name }</a></p></b>
	  

      <c:if test="${!empty rdto.review_photo1 or !empty rdto.review_photo2}" />
                     <c:if test="${!empty rdto.review_photo1}">
						<a href="${path}${rdto.review_photo1}" target = "_blank">
						<img src="${path}${rdto.review_photo1}" style="max-width: 150px;" alt="" class="rimg1"/></a>
                     </c:if>

                     <c:if test="${!empty rdto.review_photo2}">
                	    <a href="${path}${rdto.review_photo2}" target = "_blank">
						<img src="${path}${rdto.review_photo2}" style="max-width: 150px;" alt="" class="rimg1"/></a>
                     </c:if>
     
	<hr class="rhr">

	</c:forEach>
	
	
	
    <div class="row mt-4 list-bottom-util">
        <div class="col mb-3 text-center">
            ${pagingWrite}
        </div>
    </div>
    

</div>



<%@ include file="../layout/layout_footer.jsp" %>