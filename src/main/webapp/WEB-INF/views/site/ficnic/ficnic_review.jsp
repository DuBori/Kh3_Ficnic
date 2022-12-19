<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:set var="dto" value="${fdto }" />
<c:set var="rdto" value="${rList }" />
<c:set var="totalCount" value="${count }" />
<c:set var="rcount" value="${rcount }" />

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_ficnic.css" />
<script language="javascript" src="${path}/resources/site/js/js_ficnic.js"></script>



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

	<p class="r_one"><b><fmt:formatNumber value="${totalCount}" /></b>명의 대원들이 리뷰를 남겼어요. 😀 </p>
	<p class="r_two"> 평균 별점은 <b><fmt:formatNumber value="${rcount / totalCount}" 
	pattern=".0"></fmt:formatNumber></b>점이에요! </p>

	<hr color="lightgray">
	
	<c:forEach items="${rdto}" var="rdto">
		<b><p class="rpoint">${rdto.review_point }점</p></b>
		<b><p class="rname">${rdto.review_name }</p></b>
		<b><p class="rdate">${rdto.review_date } 작성</p></b>
		<b><p class="rcont">${rdto.review_cont }</p></b>
		<b><p class="rfname"> <a href='ficnic_view.do?ficnic_no=${rdto.ficnic_no}'>${dto.ficnic_name }</a></p></b>
	  

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


</div>



<%@ include file="../layout/layout_footer.jsp" %>