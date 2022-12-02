/////////////////////////////////////////////////////
// 페이지 로딩
/////////////////////////////////////////////////////
(function($){
    $(window).on("load", function(){
        $("#preloader").fadeOut("slow");
    });

    var angle = 0;
    setInterval(function(){
        $("#preloader img")
            .css('-webkit-transform', 'rotate(' + angle + 'deg)')
            .css('-moz-transform', 'rotate(' + angle + 'deg)')
            .css('-ms-transform', 'rotate(' + angle + 'deg)');
        angle++;
        angle++;
        angle++;
    }, 10);
})(jQuery);



/////////////////////////////////////////////////////
// 신규알림 클릭
/////////////////////////////////////////////////////
$(document).ready(function(){
    $("#header button.h-ico").on("click", function(e){
        if($(this).parent().hasClass("open")){
            $(this).parent().removeClass("open");
        }else{
            $("#header ul.d-flex li.open").removeClass("open");
            $(this).parent().addClass("open");
        }
        e.preventDefault();
    });

    $("#header .new-pop .np-title button").on("click", function(e){
        $("#header ul.d-flex li.open").removeClass("open");
        e.preventDefault();
    });
});








/////////////////////////////////////////////////////
// 카테고리 폼 리셋
/////////////////////////////////////////////////////
cateFormReset = function(){
    var f = $("form[name='form_write']");
    f.find("input[name='ps_ctid']").val("");
    f.find("input:radio[name='category_show']:radio[value='Y']").prop("checked", true);
    f.find("input[name='category_name']").val("").focus();
    f.find("input[name='category_link']").val("");

    $(".category-form .card-body .btn-outline-danger").attr("href", "").hide();
    $("#form-btn").removeClass("btn-success").addClass("btn-primary").html("<i class=\"fa fa-pencil\"></i> 추가하기");
}




/////////////////////////////////////////////////////
// 카테고리 폼 추가
/////////////////////////////////////////////////////
cateFormAdd = function(){
    cateFormReset();

    $("#form-title").text("대분류 추가하기");
    $("form[name='form_write']").attr("action", "category_write_ok.do");
    $("form[name='form_write'] input[name='ps_ctid']").val("00000000");
    $(".category-form .card-body .category-mask").hide();
}




/////////////////////////////////////////////////////
// 서브 카테고리 폼 추가
/////////////////////////////////////////////////////
$(document).ready(function(){
    $("ul.folder-tree li .ft-add").click(function(){
        var get_ctid = $(this).parent().find(".ft-title input[name='category_id[]']").val();
        var get_depth = $(this).parent().find(".ft-title input[name='category_depth[]']").val();
        var get_name = $(this).parent().find(".ft-title input[name='category_name[]']").val();

        cateFormReset();

        if(get_depth == 1){
            $("#form-title").html("<b>["+get_name+"]</b> 중분류 추가하기");
        }
        $("form[name='form_write']").attr("action", "category_write_ok.do");
        $("form[name='form_write'] input[name='ps_ctid']").val(get_ctid);
        $(".category-form .card-body .category-mask").hide();
    });
});




/////////////////////////////////////////////////////
// 폴더 트리 클릭 (카테고리 수정)
/////////////////////////////////////////////////////
$(document).ready(function(){
    $("ul.folder-tree li.line-plus .ft-title").click(function(){

        // 폴더 토글
        $("ul.folder-tree li .ft-title.now").removeClass("now");
        $(this).addClass("now");
        $(this).parent().children("ul").toggle();

        // 아이콘 변경
        if($(this).parent().hasClass("depth01-plus") == true){
            $(this).parent().removeClass("depth01-plus").addClass("depth01-minus");
        }else if($(this).parent().hasClass("depth01-minus") == true){
            $(this).parent().removeClass("depth01-minus").addClass("depth01-plus");
        }else if($(this).parent().hasClass("line-plus") == true){
            $(this).parent().removeClass("line-plus").addClass("line-minus");
        }else if($(this).parent().hasClass("line-minus") == true){
            $(this).parent().removeClass("line-minus").addClass("line-plus");
        }


        var getID = $(this).parent().parent().attr("id");
        if(getID != "undefined"){
            cateFormReset();


            var get_category_no = $(this).parent().find(".ft-title input[name='category_no[]']").val();
            var get_ctid = $(this).parent().find(".ft-title input[name='category_id[]']").val();
            var get_show = $(this).parent().find(".ft-title input[name='category_show[]']").val();
            var get_depth = $(this).parent().find(".ft-title input[name='category_depth[]']").val();
            var get_name = $(this).parent().find(".ft-title input[name='category_name[]']").val();

            $("#form-title").html("<b>["+get_name+"]</b> 카테고리 수정/삭제");
            $(".category-list .cl-form .clf-mask").hide();

            var f = $("form[name='form_write']");
            f.attr("action", "category_modify_ok.do");
            f.find("input[name='ps_ctid']").val(get_ctid);
            f.find("input:radio[name='category_show']:radio[value='"+get_show+"']").prop("checked", true);
            f.find("input[name='category_name']").val(get_name).focus();
            f.find("input[name='category_link']").val(get_ctid);

            $(".category-form .card-body .btn-outline-danger").attr("href", "category_delete.do?category_no="+get_category_no+"&ps_ctid="+get_ctid).show();
            $("#form-btn").removeClass("btn-primary").addClass("btn-success").html("<i class=\"fa fa-save\"></i> 수정하기");
            $(".category-form .card-body .category-mask").hide();
        }

        return false;
    });
});





/////////////////////////////////////////////////////
// 팝업창 띄우기
/////////////////////////////////////////////////////
popWindow = function(ps_url, ps_width, ps_height){
    var setLeft = ($(window).width() - ps_width) / 2;
    var setTop = ($(window).height() - ps_height) / 2;
    window.open(ps_url, "", "location=no,directories=no,resizable=no,status=no,toolbar=no,scrollbars=no,width="+ps_width+",height="+ps_height+",top="+setTop+",left="+setLeft)
}




/////////////////////////////////////////////////////
// 숫자만 입력
/////////////////////////////////////////////////////
function NumberInput(el){
    $(el).keyup(function(){
        $(this).val($(this).val().replace(/[^0-9]/g,""));
    });
}


/////////////////////////////////////////////////////
// 영문+숫자만 입력
/////////////////////////////////////////////////////
function EngNumInput(el){
    $(el).keyup(function(){
        $(this).val($(this).val().replace(/[ㄱ-힣~!@#$%^&*()_+|<>?:{}= ]/g,''));
    });
}


/////////////////////////////////////////////////////
// 숫자, - 만 입력
/////////////////////////////////////////////////////
function NumSpInput(el){
    $(el).keyup(function(){
        $(this).val($(this).val().replace(/[a-zA-Zㄱ-힣~!@#$%^&*()_+|<>?:{}= ]/g,''));
    });
}


/////////////////////////////////////////////////////
// 이메일 입력
/////////////////////////////////////////////////////
function EmailInput(el){
    $(el).keyup(function(){
        $(this).val($(this).val().replace(/[ㄱ-힣~!#$%^&*()+|<>?:;{}= ]/g,''));
    });
}




/////////////////////////////////////////////////////
// 천단위 콤마 추가
/////////////////////////////////////////////////////
function setComma(str){
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}


/////////////////////////////////////////////////////
// 천단위 콤마 제거
/////////////////////////////////////////////////////
function RemoveComma(str){
    str = String(str);
    return Number(str.replace(/[^\d]+/g, ''));
}




/////////////////////////////////////////////////////
// jQuery UI 달력
/////////////////////////////////////////////////////
$(document).ready(function(){
    var clareCalendar = {
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        dayNamesMin: ['일','월','화','수','목','금','토'],
        weekHeader: 'Wk',
        dateFormat: 'yy-mm-dd', //형식
        autoSize: false, //오토리사이즈(body등 상위태그의 설정에 따른다)
        changeMonth: true, //월변경가능
        changeYear: true, //년변경가능
        showMonthAfterYear: true, //년 뒤에 월 표시
        buttonImageOnly: false, //이미지표시
        yearRange: '2022:2040' //2022년부터 2040년까지,
    };
    $("#startDt").datepicker(clareCalendar);
    $("#endDt").datepicker(clareCalendar);
    $("#datePick1").datepicker(clareCalendar);
    $("#datePick2").datepicker(clareCalendar);
    $("#datePick3").datepicker(clareCalendar);
    $("#datePick4").datepicker(clareCalendar);
    $("#datePick5").datepicker(clareCalendar);
    $("#datePick6").datepicker(clareCalendar);
    $("#datePick7").datepicker(clareCalendar);
    $("#datePick8").datepicker(clareCalendar);
    $("#datePick9").datepicker(clareCalendar);

    $("img.ui-datepicker-trigger").attr("style","margin-left:5px; vertical-align:middle; cursor:pointer;"); //이미지버튼 style적용
    $("#ui-datepicker-div").hide(); //자동으로 생성되는 div객체 숨김  
});




