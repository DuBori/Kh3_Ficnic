<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/swiper.min.css" />
<script language="javascript" src="${path}/resources/site/js/swiper.min.js"></script>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_ficnic.css" />
<script language="javascript" src="${path}/resources/site/js/js_ficnic.js"></script>




<div class="page-info w1100">
    <h2>${category_name}</h2>
    <ol>
        <li><a href="${path}/"><i class="icon-home"></i> HOME</a></li>
        <li>피크닉</li>
        <li><b>${category_name}</b></li>
    </ol>
</div>



<h3><a href="ficnic_review.do?ficnic_no=${param.ficnic_no}">피크닉 리뷰</a></h3>
<h3><a href="ficnic_qna.do?ficnic_no=${param.ficnic_no}">피크닉 1:1 문의 작성</a></h3>



<div class="contents w1100 ficnic-view">

	<!-- .fv-top //START -->
	<div class="fv-top">
		<div class="fvt-photo">
            <div class="swiper-pagination"></div>
            <div class="swiper-button">
            	<button class="swiper-button-prev"><i class="icon-arrow-left"></i></button>
            	<button class="swiper-button-next"><i class="icon-arrow-right"></i></button>
            </div>
            <ul class="swiper-wrapper">
                <c:if test="${!empty dto.getFicnic_photo1()}"><li class="swiper-slide"><img src="${path}${dto.getFicnic_photo1()}" alt="" /></li></c:if>
                <c:if test="${!empty dto.getFicnic_photo2()}"><li class="swiper-slide"><img src="${path}${dto.getFicnic_photo2()}" alt="" /></li></c:if>
                <c:if test="${!empty dto.getFicnic_photo3()}"><li class="swiper-slide"><img src="${path}${dto.getFicnic_photo3()}" alt="" /></li></c:if>
                <c:if test="${!empty dto.getFicnic_photo4()}"><li class="swiper-slide"><img src="${path}${dto.getFicnic_photo4()}" alt="" /></li></c:if>
                <c:if test="${!empty dto.getFicnic_photo5()}"><li class="swiper-slide"><img src="${path}${dto.getFicnic_photo5()}" alt="" /></li></c:if>
            </ul>
		</div>


		<div class="fvt-cont">
			<div class="fvtc-basic">
				<h2>${dto.getFicnic_name()}</h2>
				<c:if test="${dto.getFicnic_market_price() > 0}"><p class="prev">${dto.getFicnic_market_price()}원</p></c:if>
				<p class="sale">
					<c:if test="${dto.getFicnic_market_price() > 0}"><span><fmt:formatNumber value="${dto.getFicnic_sale_price() / dto.getFicnic_market_price() * 100}" type="percent" pattern="##" />%</span></c:if>
					<b><fmt:formatNumber value="${dto.getFicnic_sale_price()}" /></b>원
				</p>
			</div>


			<div class="fvtc-review">
				<div class="fvtcr-star">
					<c:choose>
						<c:when test="${dto.getFicnic_review_point() > 0 and dto.getFicnic_review_point() <= 2}"><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:when>
						<c:when test="${dto.getFicnic_review_point() > 2 and dto.getFicnic_review_point() <= 4}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:when>
						<c:when test="${dto.getFicnic_review_point() > 4 and dto.getFicnic_review_point() <= 6}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></c:when>
						<c:when test="${dto.getFicnic_review_point() > 6 and dto.getFicnic_review_point() <= 8}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i></c:when>
						<c:when test="${dto.getFicnic_review_point() > 8}"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i></c:when>
					</c:choose>
					<b>4.9</b>
					<span>${count}개 후기</span>
					<p class="avg">경험한 크루의 ${avg}%가 5점을 줬어요!</p>
				</div>


			    <ul class="fvtcr-list">
			    	<c:forEach var="dto" items="${rList}" end="2">
			    		<li>
			    			<p class="photo"><a href="ficnic_review.do?ficnic_no=${param.ficnic_no}"><img src="${path}${dto.getReview_photo1()}" alt="" width="100" /></a></p>
			    			<p class="writer">${dto.getReview_name()}</p>
			    			<p class="cont">${dto.getReview_cont()}</p>
			    		</li>
			    	</c:forEach>
			    </ul>
			</div>
		</div>
	</div>
	<!-- .fv-top //END -->





	<!-- .fv-info //START -->
	<div class="fv-info">
		${dto.getFicnic_info()}
	</div>
	<!-- .fv-info //END -->




	<!-- .fv-detail //START -->
	<div class="fv-detail">
		<div style="height: 300px; overflow-y: scroll;">${dto.getFicnic_detail()}</div>
	</div>
	<!-- .fv-detail //END -->




	<!-- .fv-curriculum //START -->
	<div class="fv-curriculum">
		${dto.getFicnic_curriculum()}
	</div>
	<!-- .fv-curriculum //END -->




	<!-- .fv-map //START -->
	<div class="fv-map">
        <div id="map1" style="width:500px;height:400px;"></div>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4747e8c028b191f245af1699f475ac6c&libraries=services,clusterer,drawing"></script>
    <script type="text/javascript">
        // var mapContainer = document.getElementById('map1'); // 지도를 표시할 div 
        // var mapOption = {
        //     center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        //     level: 3 // 지도의 확대 레벨
        // };  

        // // 지도를 생성합니다    
        // var map = new kakao.maps.Map(mapContainer, mapOption); 
        
        // // 주소-좌표 변환 객체를 생성합니다
        // var geocoder = new kakao.maps.services.Geocoder();
        // //
        // // 주소로 좌표를 검색합니다
        // geocoder.addressSearch('경기 동두천시 천보산로 567-12', function(result, status) {
        
        //     // 정상적으로 검색이 완료됐으면 
        //      if (status === kakao.maps.services.Status.OK) {
        
        //         var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
        //         // 결과값으로 받은 위치를 마커로 표시합니다
        //         var marker = new kakao.maps.Marker({
        //             map: map,
        //             position: coords
        //         });
        
        //         // 인포윈도우로 장소에 대한 설명을 표시합니다
        //         var infowindow = new kakao.maps.InfoWindow({
        //             content: '<div style="width:150px;text-align:center;padding:6px 0;">주소위치</div>'
        //         });
        //         infowindow.open(map, marker);
        //         // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        //         map.setCenter(coords);
        //     } 
        // });
    </script>
	</div>
	<!-- .fv-map //END -->




	<!-- .fv-required //START -->
	<div class="fv-required">
		<p>${dto.getFicnic_include()}</p>
		<p>${dto.getFicnic_notinclude()}</p>
		<p>${dto.getFicnic_prepare()}</p>
	</div>
	<!-- .fv-required //END -->




	<!-- .fv-tab //START -->
	<div class="fv-tab">
		${dto.getFicnic_caution()}
	</div>
	<!-- .fv-tab //END -->

</div>




<script type="text/javascript">
$(document).ready(function(){
    var photoSwiper = new Swiper(".ficnic-view .fv-top .fvt-photo", {
        effect: "fade",
        slidesPerView: 1,
        spaceBetween: 0,
        speed: 500,
        loop: true,
        touchEnabled: false,
        autoplay: {
            delay: 3000,
            disableOnInteraction: false,
        },
        pagination: {
            el: ".ficnic-view .fv-top .fvt-photo .swiper-pagination",
            type: "fraction"
        },
        navigation: {
            nextEl: '.ficnic-view .fv-top .fvt-photo .swiper-button-next',
            prevEl: '.ficnic-view .fv-top .fvt-photo .swiper-button-prev'
        }
    });
});
</script>


<%@ include file="../layout/layout_footer.jsp" %>