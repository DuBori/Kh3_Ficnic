/////////////////////////////////////////////////////
// 상세 페이지
/////////////////////////////////////////////////////
$(function(){

    // 이미지 슬라이드
    if($(".ficnic-view .fv-top .fvt-photo .swiper-wrapper").length > 0){
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
    }


    // 옵션 선택 타이틀 클릭
    $(".ficnic-view .fv-join .fvj-sel .fvjs-option .fvjso-btn").on("click", function(){
        if($(this).parent().hasClass("open")){
            $(this).parent().removeClass("open");
            $(this).find("i").removeClass("fa-angle-up").addClass("fa-angle-down");
        }else{
            $(".ficnic-view .fv-join .fvj-sel .fvjs-option.open").removeClass("open");
            $(this).parent().addClass("open");
            $(this).find("i").removeClass("fa-angle-down").addClass("fa-angle-up");
        }
    });


    // 옵션 선택 목록 클릭
    $(".ficnic-view .fv-join .fvj-sel .fvjs-option .fvjso-list li").on("click", function(){
        let select_type = $(this).attr("type");
        let select_title = $(this).find("strong").text();
        let select_price = RemoveComma($(this).find("span b").text());

        $(this).parent().parent().find(".fvjso-btn").html("<strong>" + select_title + "</strong><span><b>" + setComma(select_price) + "</b>원</span>");
        $(this).parent().parent().removeClass("open");

        if(select_title == "선택안함"){
            select_title = "";
        }
        $("input[name='reserv_ficnic_" + select_type + "_title']").val(select_title);
        $("input[name='reserv_ficnic_" + select_type + "_price']").val(select_price);


        // 총 합계가격
        let get_sale_price = Number($("input[name='reserv_ficnic_sale_price']").val());
        let get_option_price = Number($("input[name='reserv_ficnic_option_price']").val());
        let get_select_price = Number($("input[name='reserv_ficnic_select_price']").val());

        let setTotalPrice = 0;
        if(get_option_price > 0){
            setTotalPrice = get_option_price + get_select_price;
        }else{
            setTotalPrice = get_sale_price + get_select_price;
        }

        $(".ficnic-view .fv-join .fvj-sel .fvjs-done .fvjsd-price span b").text(setComma(setTotalPrice));
    });





    // 하단 유의사항 목록 클릭
    $(".ficnic-view .fv-tab ul li .fvt-tit").on("click", function(){
        if($(this).parent().hasClass("open")){
            $(this).parent().removeClass("open");
            $(this).find("i").removeClass("icon-arrow-up").addClass("icon-arrow-down");
        }else{
            $(".ficnic-view .fv-tab ul li.open").removeClass("open");
            $(this).parent().addClass("open");
            $(this).find("i").removeClass("icon-arrow-down").addClass("icon-arrow-up");
        }
    });



    // 상단으로 버튼 클릭
    if($(".ficnic-view .fv-top").length > 0){
        var chkOffsetPos = $(".ficnic-view .fv-top").height() / 2;

        $(window).scroll(function(){
            var winNowScroll = $(window).scrollTop();

            if(winNowScroll > chkOffsetPos){
                $("button.goto-top").addClass("show");
            }else{
                $("button.goto-top").removeClass("show");
            }
        });
    }
});




/////////////////////////////////////////////////////
// 상세정보 전체보기
/////////////////////////////////////////////////////
showFicnicCont = function() {
    $(".ficnic-view .fv-detail .fvd-cont").addClass("show");
    $(".ficnic-view .fv-detail .fvd-btn").hide();
}




/////////////////////////////////////////////////////
// 참여하기 버튼
/////////////////////////////////////////////////////
showFicnicJoin = function() {
    $(".ficnic-view .fv-join .fvj-btn").toggle();
    $(".ficnic-view .fv-join .fvj-sel").toggle();
}




/////////////////////////////////////////////////////
// 피크닉 참여하기 폼 전송 체크
/////////////////////////////////////////////////////
chkReservJoin = function() {
    let form = $("form[name='reserv_form']");

    if($(".ficnic-view .fv-join .fvj-sel .fvjs-option").length > 0){
        let option_title = $(form).find("input[name='reserv_ficnic_option_title']");
        if(option_title.val() == ""){
            alert("[선택 옵션]을 선택해 주세요.");
            option_title.focus();
            return false;
        }
    }

    form.submit();
}



/////////////////////////////////////////////////////
// 피크닉 날짜 선택 달력
/////////////////////////////////////////////////////
$(document).ready(function(){
    $("#reserv_ficnic_date").datepicker({
        format: "yyyy-mm-dd",
        showRightIcon: false,
        iconsLibrary: "fontawesome"
    });
});





/////////////////////////////////////////////////////
// 결제 선택 폼 창 start
/////////////////////////////////////////////////////
$(function(){
	$(".ficnic_pay_modal").on("click",function(){
		var ficnic_pay_val = $(this).val();
		$(".ficnic_pay_ficnicOtherpay").html("<input disabled class =\"mr-2\" value=\""+ficnic_pay_val+"\"/> <input type=\"hidden\" class=\"Form__Input-sc-1quypp7-1 dYnqqW\" value=\""+ficnic_pay_val+"\"> <input type=\"button\" class=\"btn btn-outline-dark\" value=\"변경\" data-bs-toggle=\"modal\" data-bs-target=\"#exampleModal\"/>  ");

	});
	
	
	$("#sitePriceView").val();
	

	$("#ficnicCouponSelect").on("change",function(){
			// 쿠폰 조회
                $.ajax({
                    type : "post",
                    contentType : "application/x-www-form-urlencoded;charset=UTF-8",
                    url : "ficnicCouponSelect.do",
                    data : { coupon_no : $("#ficnicCouponSelect").val() },
        
                    success : function(data){
						//변수 설정
						var price_type = data.price_type;
						var price_over = data.price_over;
						var price_max = data.price_max;
						
						var date_type = data.date_type;
						var date_value = data.date_value;
						var start_date = data.start_date;
						var end_date = data.end_date;
						var coupon_price = data.coupon_price;
						var coupon_date = data.coupon_date;
						
						//가격 설정
						$("input[name='price_type']").val(price_type);
						$("input[name='price_over']").val(price_over);
						$("input[name='price_max']").val(price_max);
						$("input[name='coupon_price']").val(coupon_price);
						
						//기간 설정
						$("input[name='date_type']").val(date_type);
						$("input[name='date_value']").val(date_value);
						$("input[name='start_date']").val(start_date);
						$("input[name='end_date']").val(end_date);
						
						
						//if(date_type == free  || date_type == 'after 
						
						if(price_type == "price" ){
							var priceview= $("#sitePriceView").html();
							var saleMax = coupon_price;
							if(saleMax > price_max){
								saleMax = price_max;
							}
							var couponAfterPrice = priceview - saleMax ;
							
							if(couponAfterPrice > price_over){
								alert(couponAfterPrice);
							}else{
								alert('사용 불가능');
							}
							
						}else{
							var priceview= $("#sitePriceView").html();
							var saleMax = priceview*(coupon_price/100);
							if(saleMax > price_max){
								saleMax = price_max;
							}
							var couponAfterPrice = priceview - saleMax;
							
							if(couponAfterPrice > price_over){
								alert(couponAfterPrice);
							}else{
								alert('사용 불가능');
							}
						}
                    },
        
                    error : function(e){
                        alert("Error : " + e.status);
                       
                    }
                });
      });	


});



