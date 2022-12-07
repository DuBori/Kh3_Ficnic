<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>

<script type="text/javascript">

//모든 공백 체크 정규식
var empJ = /\s/g;
//아이디 정규식
var idJ = /^[a-z0-9]{6,12}$/;
// 비밀번호 정규식
var pwJ = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
// 이름 정규식
var nameJ = /^[가-힣]{3,8}$/;
// 이메일 검사 정규식
var mailJ = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
// 휴대폰 번호 정규식
var phoneJ = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;



//아이디
	$(function() {
$('#member_id').blur(function(){
	if(idJ.test($(this).val())){
		console.log(idJ.test($(this).val()));
		$("#id_check").text('Good.');
		$('#id_check').css('color', 'blue');
	} else {
		$('#id_check').text('아이디를 확인해주세요 :)');
		$('#id_check').css('color', 'red');
	}
});
});



// 비밀번호
	$(function() {
$('#member_pw').blur(function(){
	if(pwJ.test($(this).val())){
		console.log(pwJ.test($(this).val()));
		$("#pw_check").text('Good.');
		$('#pw_check').css('color', 'blue');
	} else {
		$('#pw_check').text('비밀번호를 확인해주세요 :)');
		$('#pw_check').css('color', 'red');
	}
});
});



// 비밀번호 확인 ***********일치하나 확인**********
	$(function() {
$('#member_pw').blur(function(){
	if(idJ.test($(this).val())){
		console.log(idJ.test($(this).val()));
		$("#id_check").text('Good.');
		$('#id_check').css('color', 'blue');
	} else {
		$('#id_check').text('아이디를 확인해주세요 :)');
		$('#id_check').css('color', 'red');
	}
});
});


//이름에 특수문자 들어가지 않도록 설정
	$(function() {
$("#member_name").blur(function() {
	if (nameJ.test($(this).val())) {
			console.log(nameJ.test($(this).val()));
			$("#name_check").text('Good.');
			$('#name_check').css('color', 'blue');
	} else {
		$('#name_check').text('이름을 확인해주세요');
		$('#name_check').css('color', 'red');
	}
});
	});

// 이메일
	$(function() {
$('#member_email').blur(function(){
	if(mailJ.test($(this).val())){
		console.log(mailJ.test($(this).val()));
		$("#email_check").text('Good.');
		$('#email_check').css('color', 'blue');
	} else {
		$('#email_check').text('이메일을 확인해주세요 :)');
		$('#email_check').css('color', 'red');
	}
});
});

//휴대폰
$(function() {
$('#member_phone').blur(function(){
if(phoneJ.test($(this).val())){
	console.log(phoneJ.test($(this).val()));
	$("#phone_check").text('Good.');
	$('#phone_check').css('color', 'blue');
} else {
	$('#phone_check').text('번호를 다시 확인해주세요 :)');
	$('#phone_check').css('color', 'red');
}
});
});


</script>
<%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>	
<script type ="text/javascript">

	$('#member_id').keyup(function(){
		let member_id = $('#member_id').val();
			
		$.ajax({
			contentType : "application/x-www-form-urlencoded;charset=UTF-8",
            url : "<%=request.getContextPath()%>/member/.do",
			type : "post",
			data : {member_id: member_id},
			dataType : 'text',
			success : function(result){
				if(result == 1){
					$("#id_feedback").html('이미 사용중인 아이디입니다.');
					$("#id_feedback").attr('color','#dc3545');
				} else{
					$("#id_feedback").html('사용할 수 있는 아이디입니다.');
					$("#id_feedback").attr('color','#2fb380');
				} 
			},
			error : function(){
				alert("서버요청실패");
			}
		})
			 
	})
</script> --%>


<div class="page-info w1100">
    <h2>회원 가입</h2>
    <ol>
        <li><a href="/"><i class="icon-home"></i> HOME</a></li>
        <li><b>회원 가입</b></li>
    </ol>
</div>

<div class="contents w1100">


<form name="form_input" method="post" action="<%=request.getContextPath() %>/member/member_join_ok.do">
			
			<!-- 아이디 -->
						
			<div class="form-group">
				<label for="member_id">아이디</label>
				<input type="text" class="form-control" id="member_id" name="member_id" placeholder="6자 이상을 입력해주세요." required>
				<div class="check_font" id="id_check"></div>
			</div>
			<!-- 비밀번호 -->
			<div class="form-group">
				<label for="member_pw">비밀번호</label>
				<input type="text" class="form-control" id="member_pw" name="member_pw" placeholder="8자 이상의 영문, 숫자, 특수문자 조합" required>
				<div class="check_font" id="pw_check"></div>
			</div>
			<!-- 비밀번호 재확인 -->
			<div class="form-group">
				<label for="member_pw2">비밀번호 확인</label>
				<input type="text" class="form-control" id="member_pw2" name="member_pw2" placeholder="비밀번호를 다시 입력해주세요." required>
				<div class="check_font" id="pw2_check"></div>
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
				<div class="check_font" id="email_check"></div>
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