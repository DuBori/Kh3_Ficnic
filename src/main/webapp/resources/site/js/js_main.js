/////////////////////////////////////////////////////
// 
/////////////////////////////////////////////////////
$(document).ready(function(){

    // 메인 비주얼
    var visualSwiper = new Swiper("#main-slide", {
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
            el: "#main-slide .swiper-pagination"
        },
        navigation: {
            nextEl: '#main-slide .swiper-button .swiper-button-next',
            prevEl: '#main-slide .swiper-button .swiper-button-prev',
        }
    });

});


