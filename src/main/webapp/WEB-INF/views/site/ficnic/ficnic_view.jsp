<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_ficnic.css" />
<script language="javascript" src="${path}/resources/site/js/js_ficnic.js"></script>



<div class="page-info w1100">
    <h2>${fdto.getFicnic_name()}</h2>
    <ol>
        <li><a href="/"><i class="icon-home"></i> HOME</a></li>
        <li>피크닉</li>
        <li><b>${fdto.getFicnic_category_name()}</b></li>
    </ol>
</div>



<div class="contents w1100 ficnic-view">



	<!-- 이미지 -->
	<div class="border">
		<h3>이미지 구간</h3>
		<c:if test="${!empty fdto.getFicnic_photo1() }">
			<img alt="이미지 없음" src="${fdto.getFicnic_photo1()}">
		</c:if>
		<c:if test="${!empty fdto.getFicnic_photo2() }">
			<img alt="이미지 없음" src="${fdto.getFicnic_photo2()}">
		</c:if>
		<c:if test="${!empty fdto.getFicnic_photo3() }">
			<img alt="이미지 없음" src="${fdto.getFicnic_photo3()}">
		</c:if>
		<c:if test="${!empty fdto.getFicnic_photo4() }">
			<img alt="이미지 없음" src="${fdto.getFicnic_photo4()}">
		</c:if>
		<c:if test="${!empty fdto.getFicnic_photo5() }">
			<img alt="이미지 없음" src="${fdto.getFicnic_photo5()}">
		</c:if>
	</div>
	
	<div class="border">
		<h3>피크닉 이름 : ${fdto.getFicnic_name()}</h3>
		<c:choose>
		   				<c:when test="${!empty fdto.getFicnic_sale_price() }">
			   				<p>${fdto.getFicnic_sale_price()/fdto.getFicnic_market_price() *100 }% <fmt:formatNumber value="${fdto.getFicnic_sale_price() }"></fmt:formatNumber>원</p>
		   				</c:when>
		   				<c:otherwise>
		   					<p>Only  ${fdto.getFicnic_market_price()}원</p>
		   				</c:otherwise>
		</c:choose>		
	</div>
	
	
	<p>★★★★★ ${count}개의 후기
	</p>
	<p>경험한 크루의 ${avg}%가 5점을 줬어요!</p>
	
	
	<div class="d-flex flex-row flex-nowrap">
		
		<c:forEach items="${rList}" var="dto">
			<div class="border">
			<c:if test="${!empty dto.getReview_photo1() }">
				<img alt="이미지 없음" src="${dto.getReview_photo1()}" >
			</c:if>
				<div>
					<img alt="멤버 이미지" src="#">
					<span>${dto.getReview_name() }</span>
				</div>
				<div>
					<span>${dto.getReview_cont() }</span>
				</div>
			</div>
		</c:forEach>
	
	</div>
	
	<div>
		<h3>프립 정보</h3>
		<div>
			${fdto.getFicnic_info() }
		</div>
	</div>
	
	<div>
		<h3>프립 소개</h3>
		<div class="mw-50">
			${fdto.getFicnic_detail() }
		</div>
	</div>
	
	<div>
		<h3>커리큘럼</h3>
		<div>
			${fdto.getFicnic_curriculum() }
		</div>
	</div>
	<div>
		<h3>모이는 장소</h3>
		<div id="map1" style="width:500px;height:400px;"></div>
	</div>
	<div>
		<h3>진행하는 장소</h3>
		<div id="map2" style="width:500px;height:400px;"></div>
	</div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=05baaf0de0478dc909d89f4fbc30dcd1&libraries=services,clusterer,drawing"></script>
	<script type="text/javascript">
		var mapContainer = document.getElementById('map1'); // 지도를 표시할 div 
		var mapContainer2 = document.getElementById('map2');
		var mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		var map2 = new kakao.maps.Map(mapContainer2, mapOption); 
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		//
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch('${fdto.getFicnic_location()}', function(result, status) {
		
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
		
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
		
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">주소위치</div>'
		        });
		        infowindow.open(map, marker);
		
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});
		geocoder.addressSearch('${fdto.getFicnic_address()}', function(result, status) {
			
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
		
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
		
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">주소위치</div>'
		        });
		        infowindow.open(map2, marker);
		
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map2.setCenter(coords);
		    } 
		});  
	</script>
	<div>
		<h3>포함사항</h3>
		<div>
			${fdto.getFicnic_include() }
		</div>
	</div>
	<div>
		<h3>불포함사항</h3>
		<div>
			${fdto.getFicnic_notinclude() }
		</div>
	</div>
	<div>
		<h3>준비물</h3>
		<div>
			${fdto.getFicnic_prepare() }
		</div>
	</div>
	<div>
		<h3>1:1문의</h3>
	</div>
	<div>
		<h3>유의사항</h3>
		<div>
			${fdto.getFicnic_caution() }
		</div>
	</div>
	<div>
		<h3>환불정책</h3>
		<div>
			환불정책?
		</div>
	</div>




</div>



<%@ include file="../layout/layout_footer.jsp" %>