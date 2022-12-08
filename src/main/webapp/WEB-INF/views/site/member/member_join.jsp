<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>

<script type="text/javascript">



//모든 공백 체크 정규식
var empJ = /\s/g;
//아이디 정규식
var idJ = /^[a-z0-9]{6,12}$/;
//비밀번호 정규식
var pwJ = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
//이름 정규식
var nameJ = /^[가-힣]{3,8}$/;
//이메일 검사 정규식
var mailJ = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
//휴대폰 번호 정규식
var phoneJ = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;

let ajaxTxt = "";



$(function(){
    // 아이디 6글자 이상
 	$("input[name='member_id']").keyup(function(){
        let userId = $(this).val();
        
         if($.trim(userId).length < 6){
             $("#idchk-txt").html("<span style=\"color:red\">아이디는 6글자 이상이어야 합니다.</span>");
            return false;
         } 
         
        // 아이디 중복
        $.ajax({
            type : "post",
            contentType : "application/x-www-form-urlencoded;charset=UTF-8",
            datatype : "html",
            url : "${path}/member/memberIdCheck.do",
            data : { paramId : userId },

            success : function(data){
                if(data > 0){
                	ajaxTxt = "<span style=\"color:red\">이미 사용중인 아이디입니다.</span>";
                    $("input[name='idchk']").val("false");
                }else{
                	 ajaxTxt = "<span style=\"color:blue\">Good.</span>";
                     $("input[name='idchk']").val("true");
                }
                $("#idchk-txt").html(ajaxTxt);
            },

            error : function(e){
                alert("Error : " + e.status);
                $("input[name='idchk']").val("N");
            }
        });
	});	
});



$(function(){
	// 이메일 정규표현식
	$("input[name='member_email']").keyup(function(){
        let userEmail = $(this).val();
        
        if(!mailJ.test($(this).val())) {
             $("#mailchk-txt").html("<span style=\"color:red\">이메일을 확인해주세요. :)</span>");
             return false;
            }

       
 		// 이메일 중복
        $.ajax({
            type : "post",
            contentType : "application/x-www-form-urlencoded;charset=UTF-8",
            datatype : "html",
            url : "${path}/member/memberMailCheck.do",
            data : { paramEmail : userEmail },

            success : function(data){
                if(data > 0){
                	ajaxTxt = "<span style=\"color:red\">이미 존재하는 이메일 주소입니다.</span>";
                    $("input[name='mailchk']").val("false");
                }else{
                	 ajaxTxt = "<span style=\"color:blue\">Good.</span>";
                     $("input[name='mailchk']").val("true");
                }
                $("#mailchk-txt").html(ajaxTxt);
            },

            error : function(e){
                alert("Error : " + e.status);
                $("input[name='mailchk']").val("N");
            }
        });
});
});

// 비밀번호
	$(function() {
$('#member_pw').keyup(function(){
	if(pwJ.test($(this).val())){
    	ajaxTxt = "<span style=\"color:blue\">Good.</span>";
	} else {
    	ajaxTxt = "<span style=\"color:red\">비밀번호를 확인해주세요 :)</span>";
	}
    $("#pw_check").html(ajaxTxt);
});
});




// 비밀번호 확인 ***********일치하나 확인**********
	$(function() {
$('#member_pw_re').keyup(function(){
	if($('#member_pw').val() == ($('#member_pw_re').val())) {
    	ajaxTxt = "<span style=\"color:blue\">일치합니다.</span>";
	} else {
		ajaxTxt = "<span style=\"color:red\">일치하는 번호를 적어주세요 :)</span>";
	}
    $("#pw_re_check").html(ajaxTxt);
});
}); 



//이름에 특수문자 들어가지 않도록 설정
	$(function() {
$("#member_name").keyup(function() {
	if (nameJ.test($(this).val())) {
    	ajaxTxt = "<span style=\"color:blue\">Good.</span>";
	} else {
    	ajaxTxt = "<span style=\"color:red\">이름을 확인해주세요 :)</span>";
	}
    $("#name_check").html(ajaxTxt);
});
	});

/* // 이메일
	$(function() {
$("#member_email").keyup(function() {
	if (mailJ.test($(this).val())) {
    	ajaxTxt = "<span style=\"color:blue\">Good.</span>";
	} else {
    	ajaxTxt = "<span style=\"color:red\">이메일을 확인해주세요 :)</span>";
	}
    $("#email_check").html(ajaxTxt);
});
}); */

//휴대폰
$(function() {
	$("#member_phone").keyup(function() {
		if (phoneJ.test($(this).val())) {
	    	ajaxTxt = "<span style=\"color:blue\">Good.</span>";
		} else {
	    	ajaxTxt = "<span style=\"color:red\">번호를 다시 확인해주세요 :)</span>";
		}
	    $("#phone_check").html(ajaxTxt);
});
});


</script>



<div class="page-info w1100">
    <h2>회원 가입</h2>
    <ol>
        <li><a href="/"><i class="icon-home"></i> HOME</a></li>
        <li><b>회원 가입</b></li>
    </ol>
</div>

<div class="contents w1100">


<form name="form_input" method="post" action="${path}/member/member_join_ok.do"> 
			
			<!-- 아이디 -->
						
			<div class="form-group">
				<label for="member_id">아이디</label>
				<input type="text" class="form-control" id="member_id" name="member_id" placeholder="6자 이상을 입력해주세요." onkeydown="EngNumInput(this);" required>
<!-- 				<div class="check_font" id="id_check"></div> -->
				<div id="idchk-txt" class="d-inline ml-2 check_font"></div>
				<input type="hidden" name="idchk" value="false" />
			</div>
			<!-- 비밀번호 -->
			<div class="form-group">
				<label for="member_pw">비밀번호</label>
				<input type="password" class="form-control" id="member_pw" name="member_pw" placeholder="8자 이상의 영문, 숫자, 특수문자 조합" required>
				<div class="check_font" id="pw_check"></div>
			</div>
			<!-- 비밀번호 재확인 -->
			<div class="form-group">
				<label for="member_pw2">비밀번호 확인</label>
				<input type=""password"" class="form-control" id="member_pw_re" name="member_pw_re" placeholder="비밀번호를 다시 입력해주세요." required>
				<div class="check_font" id="pw_re_check"></div>
			</div>
			<!-- 이름 -->
			<div class="form-group">
				<label for="member_name">이름</label>
				<input type="text" class="form-control" id="member_name" name="member_name" placeholder="이름을 입력해주세요." required>
				<div class="check_font" id="name_check"></div>
			</div>
			<!-- 이메일 -->
			<div class="form-group">
				<label for="member_email">이메일</label>
				<input type="email" class="form-control" id="member_email" name="member_email" placeholder="이메일을 입력해주세요." required>
				<div id="mailchk-txt" class="d-inline ml-2 check_font"></div>
				<input type="hidden" name="mailchk" value="false" />
			</div>
			<!-- 휴대전화 -->
			<div class="form-group">
				<label for="member_phone">연락처</label>
				<input type="text" class="form-control" id="member_phone" name="member_phone" placeholder="-을 포함한 전화번호를 입력해주세요." required>
				<div class="check_font" id="phone_check"></div>
			</div>
			
			<div class="reg_button">
				<a class="btn btn-danger px-3" href="${pageContext.request.contextPath}">
					<i class="fa fa-rotate-right pr-2" aria-hidden="true"></i>취소하기
				</a>&emsp;&emsp;
				<button class="btn btn-primary px-3" id="reg_submit">
					<i class="fa fa-heart pr-2" aria-hidden="true"></i>가입하기
				</button>
			</div>
		</form>


</form>

</div>

<%@ include file="../layout/layout_footer.jsp" %>