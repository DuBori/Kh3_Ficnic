<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:set var="dto" value="${fdto }" />
<c:set var="rdto" value="${rList }" />
<c:set var="totalCount" value="${count }" />
<c:set var="rcount" value="${rcount }" />

<% pageContext.setAttribute("newLine", "\n"); %>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_ficnic.css?${time}" />
<script language="javascript" src="${path}/resources/site/js/js_ficnic.js?${time}"></script>

<script>



     $(document).ready(function() {

                var xOffset = 10;
                var yOffset = 30;
               
                $(document).on("mouseover",".thumbnail",function(e){ //마우스 오버 시
					
					$("body").append("<p id='preview'><img src='"+ $(this).attr("src") +"' width='500px' /></p>"); //보여줄 이미지를 선언						 

					$("#preview")
						.css("top",(e.pageY - xOffset) + "px")
						.css("left",(e.pageX + yOffset) + "px")
						.fadeIn("fast"); //미리보기 화면 설정 셋팅
				});

				
				$(document).on("mousemove",".thumbnail",function(e){ //마우스 이동시

					$("#preview")
						.css("top",(e.pageY - xOffset) + "px")
						.css("left",(e.pageX + yOffset) + "px");
				});


				$(document).on("mouseout",".thumbnail",function(){ //마우스 아웃시
					$("#preview").remove();
				});

            });

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
			
		<%-- 	<a class="mr-2 text-dark orderfc" href="ficnic_review.do?ficnic_no=${fdto.getFicnic_no()}&getType=pointH">평점 높은 순</a>|
			
			<a class="ml-2 mr-2 text-dark orderfc" href="ficnic_review.do?ficnic_no=${fdto.getFicnic_no()}&getType=pointL">평점 낮은 순</a>|
			
			<a  class="ml-2 mr-2 text-dark orderfc" href="ficnic_review.do?ficnic_no=${fdto.getFicnic_no()}&getType=pointD">최신 순</a></p>
			  --%>
	 
				 	<select name="sort" class="mr-2 text-dark orderfc custom-select glt-sort" onchange="location.href=this.value;">
						<option value="ficnic_review.do?ficnic_no=${fdto.getFicnic_no()}&getType=pointD" <c:if test="${param.getType eq 'pointD'}"> selected="selected" </c:if>>최신 순</option>
						<option value="ficnic_review.do?ficnic_no=${fdto.getFicnic_no()}&getType=pointH" <c:if test="${param.getType eq 'pointH'}"> selected="selected" </c:if>>평점 높은 순</option>
						<option value="ficnic_review.do?ficnic_no=${fdto.getFicnic_no()}&getType=pointL" <c:if test="${param.getType eq 'pointL'}"> selected="selected" </c:if>>평점 낮은 순</option>
					</select> 
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
		<%-- <b><p class="rfname"> <a class="rficnic"href='ficnic_view.do?category=${dto.ficnic_category_no }&ficnic_no=${rdto.ficnic_no}'>${dto.ficnic_name }</a></p></b> --%>
	  
			
 <div id="slide" val="1" mx="3">
      <c:if test="${!empty rdto.review_photo1 or !empty rdto.review_photo2}" />
                     <c:if test="${!empty rdto.review_photo1}">
						 <a href="${path}${rdto.review_photo1}" target = "_blank">
						<img src="${path}${rdto.review_photo1}" style="max-width: 150px;" alt="" class="rimg1 thumbnail"/></a>
                     </c:if>

                     <c:if test="${!empty rdto.review_photo2}">
                	    <a href="${path}${rdto.review_photo2}" target = "_blank">
						<img src="${path}${rdto.review_photo2}" style="max-width: 150px;" alt="" class="rimg1 thumbnail"/></a>
                     </c:if>   
 
</div>

<b><p class="rcont">${rdto.review_cont.replace(newLine, "<br />") }</p></b>


	<hr class="rhr">

	</c:forEach>
	
	
	
    <div class="row mt-4 list-bottom-util">
        <div class="col mb-3 text-center">
            ${pagingWrite}
        </div>
    </div>
    

</div>



<%@ include file="../layout/layout_footer.jsp" %>