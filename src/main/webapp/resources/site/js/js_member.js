


<!-- 회원 가입 -->
<script type="text/javascript">

//모든 공백 체크 정규식
var empJ = /\s/g;
//아이디 정규식
var idJ = /^[a-z0-9]{6,12}$/;
//비밀번호 정규식
var pwJ = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
//이름 정규식
var nameJ = /^[가-힣]{2,8}$/;
//이메일 검사 정규식
var mailJ = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
//휴대폰 번호 정규식
var phoneJ = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;

let ajaxTxt = "";


$(function(){
    // 아이디 6글자 이상
 	$("#member_id").keyup(function(){
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



	// 비밀번호
	$('#member_pw').keyup(function(){
		if(pwJ.test($(this).val())){
	    	ajaxTxt = "<span style=\"color:blue\">Good.</span>";
		} else {
	    	ajaxTxt = "<span style=\"color:red\">비밀번호를 확인해주세요 :)</span>";
		}
	    $("#pw_check").html(ajaxTxt);
	});


	// 비밀번호 확인 ***********일치하나 확인**********
	$('#member_pw_re').keyup(function(){
		if($('#member_pw').val() == ($('#member_pw_re').val())) {
	    	ajaxTxt = "<span style=\"color:blue\">일치합니다.</span>";
		} else {
			ajaxTxt = "<span style=\"color:red\">일치하는 번호를 적어주세요 :)</span>";
		}
	    $("#pw_re_check").html(ajaxTxt);
	});



	//이름에 특수문자 들어가지 않도록 설정
	$("#member_name").keyup(function() {
		if (nameJ.test($(this).val())) {
	    	ajaxTxt = "<span style=\"color:blue\">Good.</span>";
		} else {
	    	ajaxTxt = "<span style=\"color:red\">이름을 확인해주세요 :)</span>";
		}
	    $("#name_check").html(ajaxTxt);
	});


	//휴대폰
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






