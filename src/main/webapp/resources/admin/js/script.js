/////////////////////////////////////////////////////
// 페이지 로딩
/////////////////////////////////////////////////////
(function($){
    $(window).on("load", function(){
        $("#ajax-loader").fadeOut("slow");
    });
})(jQuery);




/////////////////////////////////////////////////////////////
// 토스트 메세지 띄우기 (m_type, m_name, m_id, m_cont, m_num)
/////////////////////////////////////////////////////////////
popToast = function(m_type, m_name, m_id, m_cont, m_num) {
    let show_icon = "";
    let show_title = "";
    let show_link = "";
    let show_size = 0;


    // 1:1 문의
    if(m_type == "qna"){
        show_icon = "icon-speech";
        show_title = "1:1 문의 게시물";
        show_link = "qnaView.do?no";
        show_size = 700;

    // 예약 접수
    }else if(m_type == "reserv"){
        show_icon = "icon-plane";
        show_title = "예약 접수";
        show_link = "reservView.do?sess";
        show_size = 700;

    // 후기 등록
    }else if(m_type == "review"){
        show_icon = "icon-note";
        show_title = "후기 등록";
        show_link = "reviewView.do?id";
        show_size = 700;

    // 신규 회원
    }else if(m_type == "join"){
        show_icon = "icon-people";
        show_title = "회원 가입";
        show_link = "memberView.do?id";
        show_size = 800;

    }

    if(m_num == null || m_num == "" || m_num == "undefined"){
        show_link = "#";
    }

    let m_today = new Date();
    let m_hou = ("0" + m_today.getHours()).slice(-2);
    let m_min = ("0" + m_today.getMinutes()).slice(-2);
    let m_sec = ("0" + m_today.getSeconds()).slice(-2);


    let toastHTML = "<div class=\"toast bg-white\" aria-atomic=\"true\" data-delay=\"30000\" data-autohide=\"true\">\n";
        toastHTML += "\t<div class=\"toast-header\">\n";
        toastHTML += "\t\t<i class=\""+show_icon+"\"></i><span class=\"mr-auto\">새로운 "+show_title+"</span>\n";
        toastHTML += "\t\t<button type=\"button\" class=\"ml-2 mb-1 close\" data-dismiss=\"toast\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n";
        toastHTML += "\t</div>\n";
        toastHTML += "\t<div class=\"toast-body\">\n";
        toastHTML += "\t\t<a href=\"javascript:popWindow('../admin/"+show_link+"="+m_num+"', "+show_size+", 900);\">";
        toastHTML += "\t\t\t" + m_cont + "\n";
        toastHTML += "\t\t\t<div class=\"clear\"><small class=\"text-muted float-left\"><i class=\"icon-user\"></i> "+m_name+" ("+m_id+")</small><small class=\"text-muted float-right\"><i class=\"icon-clock\"></i> "+m_hou+":"+m_min+":"+m_sec+"</small></div>\n";
        toastHTML += "\t\t</a>\n";
        toastHTML += "\t</div>\n";
        toastHTML += "</div>";

    $("#toast-wrap").append(toastHTML);
    $("#toast-wrap .toast:last-child").toast("show");
}






/////////////////////////////////////////////////////
// 팝업창 띄우기
/////////////////////////////////////////////////////
popWindow = function(ps_url, ps_width, ps_height){
    var setLeft = ($(window).width() - ps_width) / 2;
    var setTop = ($(window).height() - ps_height) / 2;
    window.open(ps_url, "", "location=no,directories=no,resizable=no,status=no,toolbar=no,scrollbars=no,width="+ps_width+",height="+ps_height+",top="+setTop+",left="+setLeft)
}




//////////////////////////////////////////////////////////////////////////
// 위로이동
//////////////////////////////////////////////////////////////////////////
function gotoTop(){
    $("html, body").stop().animate({ scrollTop : 0 }, 150, "swing", function(){});
}


//////////////////////////////////////////////////////////////////////////
// 아래로이동
//////////////////////////////////////////////////////////////////////////
function gotoDown(){
    $("html, body").stop().animate({ scrollTop : $(document).height() }, 150, "swing", function(){});
}



//////////////////////////////////////////////////////////////////////////
// 페이지 위치 이동
//////////////////////////////////////////////////////////////////////////
function gotoPos(kind){
    var gopos = $("#"+kind).offset().top - 65;
    $("html, body").stop().animate({ scrollTop : gopos }, 150, "swing", function(){});
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
// 다음 우편번호찾기
/////////////////////////////////////////////////////
// foldDaumPostcode('우편번호찾기 레이어 ID')
function foldDaumPostcode(el){
    var element_wrap = document.getElementById(el);

    // iframe을 넣은 element를 안보이게 한다.
    element_wrap.style.display = 'none';
}

// daum_find_zipcode('우편번호찾기 레이어 ID', '우편번호 인풋 ID', '상세주소1 인풋 ID', '상세주소2 인풋 ID')
function daum_find_zipcode(el, zip_input, addr1_input, addr2_input){
    var element_wrap = document.getElementById(el);

    // 현재 scroll 위치를 저장해놓는다.
    var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);

    new daum.Postcode({
        oncomplete: function(data){
            // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if(data.userSelectedType === 'R'){ // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            }else{ // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById(addr2_input).value = extraAddr;

            }else{
                document.getElementById(addr2_input).value = "";
            }


            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById(zip_input).value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById(addr1_input).value = addr;

            // 커서를 상세주소 필드로 이동한다.
            document.getElementById(addr2_input).focus();

            // iframe을 넣은 element를 안보이게 한다.
            // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
            element_wrap.style.display = 'none';

            // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
            document.body.scrollTop = currentScroll;
        },
        // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
        onresize : function(size){
            element_wrap.style.height = size.height+'px';
        },
        width : '100%',
        height : '100%'
    }).embed(element_wrap);

    // iframe을 넣은 element를 보이게 한다.
    element_wrap.style.display = 'block';
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
        yearRange: '2021:2040' //2021년부터 2040년까지,
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








