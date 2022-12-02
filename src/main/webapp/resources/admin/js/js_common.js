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
    f.find("input[name='ps_mode']").val("");
    f.find("input[name='ps_ctid']").val("");
    f.find("input:radio[name='menu_show']:radio[value='Y']").prop("checked", true);
    f.find("input:radio[name='category_show']:radio[value='Y']").prop("checked", true);
    f.find("input#category_link").val("");
    f.find("input[name='category_name_kor']").val("");
    f.find("input[name='category_name_eng']").val("");
    f.find("select[name='category_goods_display']").val("register_date");
    f.find("select[name='category_skin_pc']").val("");
    f.find("input:radio[name='category_top_display_pc']:radio[value='none']").prop("checked", true);
    f.find("input[name='category_top_img_pc']").val("");
    f.find(".custom-file-label.pc").text("");
    f.find("input[name='category_top_link_pc']").val("");
    f.find("select[name='category_top_target_pc']").val("_self");
    f.find("textarea[name='category_top_html_pc']").val("");
    f.find("select[name='category_skin_mobile']").val("");
    f.find("input:radio[name='category_top_display_mobile']:radio[value='none']").prop("checked", true);
    f.find("input[name='category_top_img_mobile']").val("");
    f.find(".custom-file-label.mobile").text("");
    f.find("input[name='category_top_link_mobile']").val("");
    f.find("select[name='category_top_target_mobile']").val("_self");
    f.find("textarea[name='category_top_html_mobile']").val("");
    f.find(".display-img, .display-html").hide();
    f.find("#form-top-img-pc, #form-top-img-mobile").html("");

    $(".category-list .cl-form .clf-button").css("padding-left", "0");
    $(".category-list .cl-form .clf-button .btn-outline-danger").attr("href", "").hide();
    $("#form-btn").removeClass("btn-success").addClass("btn-primary").html("<i class=\"fa fa-pencil\"></i> 추가하기");
}




/////////////////////////////////////////////////////
// 카테고리 폼 추가
/////////////////////////////////////////////////////
cateFormAdd = function(){
    cateFormReset();

    $("#form-title").text("대분류 추가하기");
    $("form[name='form_write'] input[name='ps_ctid']").val("00000000");
    $(".category-list .cl-form .clf-mask").hide();
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
        }else{
            $("#form-title").html("<b>["+get_name+"]</b> 소분류 추가하기");
        }
        $("form[name='form_write'] input[name='ps_mode']").val("category_write");
        $("form[name='form_write'] input[name='ps_ctid']").val(get_ctid);
        $(".category-list .cl-form .clf-mask").hide();
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

        return false;

        var getID = $(this).parent().parent().attr("id");
        if(getID != "undefined"){
            // 입력폼 적용
            $.ajax({
                type: "post",
                url : "admin_goods_category_ajax.php",
                data : {
                        ps_ctid : $(this).find("input[name='category_id[]']").val()
                },

                //데이터 전송전
                beforeSend: function(xhr, settings){},

                //데이터 전송완료
                complete: function(xhr, textStatus){},


                //데이터 처리성공
                success: function(result){
                    data = jQuery.parseJSON(result);

                    var ps_mode                 = "modify";
                    var cate_id                 = data.category_id;
                    var menu_show               = data.menu_show;
                    var cate_show               = data.category_show;
                    var cate_url                = data.category_url;
                    var cate_name_kor           = data.category_name_kor;
                    var cate_name_eng           = data.category_name_eng;
                    var cate_goods_display      = data.category_goods_display;
                    var cate_skin_pc            = data.category_skin_pc;
                    var cate_top_display_pc     = data.category_top_display_pc;
                    var cate_top_img_pc         = data.category_top_img_pc;
                    var cate_top_link_pc        = data.category_top_link_pc;
                    var cate_top_target_pc      = data.category_top_target_pc;
                    var cate_top_html_pc        = data.category_top_html_pc;
                    var cate_skin_mobile        = data.category_skin_mobile;
                    var cate_top_display_mobile = data.category_top_display_mobile;
                    var cate_top_img_mobile     = data.category_top_img_mobile;
                    var cate_top_link_mobile    = data.category_top_link_mobile;
                    var cate_top_target_mobile  = data.category_top_target_mobile;
                    var cate_top_html_mobile    = data.category_top_html_mobile;


                    cateFormReset();


                    $("#form-title").html("<b>["+cate_name_kor+"]</b> 카테고리 수정/삭제");
                    $(".category-list .cl-form .clf-mask").hide();

                    var f = $("form[name='form_write']");
                    f.find("input[name='ps_mode']").val("category_modify");
                    f.find("input[name='ps_ctid']").val(cate_id);


                    f.find("input:radio[name='menu_show']:radio[value='"+menu_show+"']").prop("checked", true);
                    f.find("input:radio[name='category_show']:radio[value='"+cate_show+"']").prop("checked", true);
                    f.find("input#category_link").val(cate_url);
                    f.find("input[name='category_name_kor']").val(cate_name_kor);
                    f.find("input[name='category_name_eng']").val(cate_name_eng);
                    f.find("select[name='category_goods_display']").val(cate_goods_display);
                    f.find("select[name='category_skin_pc']").val(cate_skin_pc);
                    f.find("input:radio[name='category_top_display_pc']:radio[value='"+cate_top_display_pc+"']").prop("checked", true);
                    f.find("input[name='category_top_link_pc']").val(cate_top_link_pc);
                    f.find("select[name='category_top_target_pc']").val(cate_top_target_pc);
                    f.find("textarea[name='category_top_html_pc']").val(cate_top_html_pc);


                    $(".category-list .cl-form .clf-button").css("padding-left", "98px");
                    $(".category-list .cl-form .clf-button .btn-outline-danger").attr("href", "admin_goods_category_ok.php?ps_mode=category_delete&ps_ctid="+cate_id).show();
                    $("#form-btn").removeClass("btn-primary").addClass("btn-success").html("<i class=\"fa fa-save\"></i> 수정하기");
                },


                //데이터 처리에러
                error: function (xhr, textStatus, errorThrown){
                    alert("Error : "+errorThrown);
                }
            });
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




