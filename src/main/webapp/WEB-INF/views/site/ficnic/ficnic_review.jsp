<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:set var="dto" value="${fdto }" />
<c:set var="rdto" value="${rList }" />
<c:set var="totalCount" value="${count }" />
<c:set var="rcount" value="${rcount }" />

<% pageContext.setAttribute("newLine", "\n"); %>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_ficnic.css?${time}" />
<script language="javascript" src="${path}/resources/site/js/js_ficnic.js?${time}"></script>


<script type="text/javascript"> 

 function imgslide(){

  $val = $("#slide").attr("val"); //현재 이미지 번호를 가져옵니다

  $mx = $("#slide").attr("mx"); //총 이미지 개수를 가져옵니다

	$("#rimg1"+$val).hide(); //현재 이미지를 사라지게 합니다.

	if( $val == $mx ){ $val = 1; } //현재이미지가 마지막 번호라면 1번으로 되돌립니다.

	else{ $val++; } //마지막 번호가 아니라면 카운트를 증가시켜줍니다

	$("#rimg1"+$val).fadeIn(500); //변경된 번호의 이미지영역을 나타나게 합니다.괄호 안에 숫자는 페이드인 되는 시간을 나타냅니다.

	$("#slide").attr('val',$val); //변경된 이미지영역의 번호를 부여합니다.

	setTimeout('imgslide()',1000); //1초 뒤에 다시 함수를 호출합니다.(숫자값 1000당 1초)

} 

</script>


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
           
    <div class="d-flex">
	
	<div>
	<p class="r_one"><b><fmt:formatNumber value="${totalCount}" /></b>명의 대원들이 리뷰를 남겼어요. 😀
	<br>평균 별점은 <b><fmt:formatNumber value="${rcount / totalCount}" 
	pattern=".0"></fmt:formatNumber></b>점이에요! </p>
	</div>
	
	<div class="ml-auto">
			<p class="mypage-reserv ml-auto">
			<a class="mr-2 text-dark orderfc" href="ficnic_review.do?ficnic_no=${fdto.getFicnic_no()}&getType=pointH">평점 높은 순</a>|
			
			<a class="ml-2 mr-2 text-dark orderfc" href="ficnic_review.do?ficnic_no=${fdto.getFicnic_no()}&getType=pointL">평점 낮은 순</a>|
			
			<a  class="ml-2 mr-2 text-dark orderfc" href="ficnic_review.do?ficnic_no=${fdto.getFicnic_no()}&getType=pointD">최신 순</a></p>
		</div>
	</div> 

		
	<hr color="lightgray">
	
	<c:forEach items="${rdto}" var="rdto">
		<div class="fvtc-review">
			<div class="fvtcr-star">
				<b><p class="rname">${rdto.review_name }</p></b>
					
	<c:if test="${rdto.review_point > 0 and rdto.review_point <= 2}"><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:if>
	<c:if test="${rdto.review_point > 2 and rdto.review_point <= 4}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:if>
	<c:if test="${rdto.review_point > 4 and rdto.review_point <= 6}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:if>
	<c:if test="${rdto.review_point > 6 and rdto.review_point <= 8}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i></c:if>
	<c:if test="${rdto.review_point > 8}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i></c:if>
		<b class="notstar">${rdto.review_point}</b>
			
				</div>
			</div>

		<b><p class="rdate">${rdto.review_date.substring(0,16) } 작성</p></b>
		<b><p class="rcont">${rdto.review_cont.replace(newLine, "<br />") }</p></b>
		<b><p class="rfname"> <a class="rficnic"href='ficnic_view.do?category=${dto.ficnic_category_no }&ficnic_no=${rdto.ficnic_no}'>${dto.ficnic_name }</a></p></b>
	  
			
 <div id="slide" val="1" mx="3">
      <c:if test="${!empty rdto.review_photo1 or !empty rdto.review_photo2}" />
                     <c:if test="${!empty rdto.review_photo1}">
						 <a href="${path}${rdto.review_photo1}" target = "_blank">
						<img src="${path}${rdto.review_photo1}" style="max-width: 150px;" alt="" class="rimg1" onclick="imgslide();"/></a>
                     </c:if>

                     <c:if test="${!empty rdto.review_photo2}">
                	    <a href="${path}${rdto.review_photo2}" target = "_blank">
						<img src="${path}${rdto.review_photo2}" style="max-width: 150px;" alt="" class="rimg2"/></a>
                     </c:if>
</div>
	<hr class="rhr">

	</c:forEach>
	
	
	
    <div class="row mt-4 list-bottom-util">
        <div class="col mb-3 text-center">
            ${pagingWrite}
        </div>
    </div>
    

</div>



<%@ include file="../layout/layout_footer.jsp" %>