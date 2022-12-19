/////////////////////////////////////////////////////
// 상세정보 전체보기
/////////////////////////////////////////////////////
showFicnicCont = function() {
    $(".ficnic-view .fv-detail .fvd-cont").addClass("show");
    $(".ficnic-view .fv-detail .fvd-btn").hide();
}



/////////////////////////////////////////////////////
// 하단 유의사항 목록 클릭
/////////////////////////////////////////////////////
$(function(){
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
});





