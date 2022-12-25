	
	$(function(){
		
		$(".btn-js").on("click",function(){  
			$("#review_con").html("");
			$("#ori_review_photo1").attr("src","");
			$("#ori_review_photo2").attr("src","");
			
			var name = $(this).data('name')+"후기 작성";
			var no = $(this).data('no');
			var path = "/ficnic";
			$("#exampleModalLabel").html(name);
			$("input[name=ficnic_no]").val(no);
			if($(this).data('modi') != null){
				$("#review_con").html($(this).data('cont'));
				$("#mypage-form-div").attr("action","mypage_review_modify.do");
				$("#ori_review_photo1").attr("src",path+$(this).data('photo1'));
				$("#ori_review_photo2").attr("src",path+$(this).data('photo2'));
				$("#mypage-reserv-rno").val($(this).data("rno"));
				$("#mypage-reserv-subtn").val("수정 하기");
			}else{
				$("#mypage-form-div").attr("action","mypage_review_write.do");
			}
		});
	});
	
	
	// 카카오 주소검색 api
	kakao.maps.load(function() {
		// v3가 모두 로드된 후, 이 콜백 함수가 실행됩니다.
		var ficnic_addr = document.getElementById('ficnic_addr').innerText;
		var mapContainer = document.getElementById('map');
		var mapOption = {
		    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		    level: 3 // 지도의 확대 레벨
		};  
		
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(ficnic_addr, function(result, status) {
		
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
	});
	
	

	
	





