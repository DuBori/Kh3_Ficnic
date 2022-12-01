<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layout/layout_header.jsp" %>
<script type="text/javascript">
$("#header .navbar .nav-item:nth-child(3)").addClass("active");


$(function(){
    $("input[name='member_id']").keyup(function(){
        let userId = $(this).val();

        if($.trim(userId).length < 4){
            $("#idchk-txt").html("<span class=\"text-danger\">* 아이디는 4글자 이상이어야 합니다.</span>");
            return false;
        }

        // 아이디 중복여부 확인
        $.ajax({
            type : "post",
            url : "<%=request.getContextPath()%>/memberIdCheck.do",
            data : { paramId : userId },
            datatype : "html",

            success : function(data){
                console.log(data);
                let ajaxTxt = "";
                if(data.trim() > 0){
                    ajaxTxt = "<span class=\"text-danger\">* 이미 사용중인 아이디입니다.</span>";
                    $("input[name='idchk']").val("N");
                }else{
                    ajaxTxt = "<span class=\"text-primary\">* 사용 할 수 있는 아이디입니다.</span>";
                    $("input[name='idchk']").val("Y");
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


join_check = function(){
    var form = document.write_form;

    if(form.idchk.value == "N"){
        alert("이미 사용중인 [아이디]입니다.\n다른 아이디를 입력해주세요.");
        form.member_id.focus();
        return false;
    }

    if(form.member_pw.value.length > 0 && form.member_pw_re.value.length > 0){
        if(form.member_pw.value != form.member_pw_re.value){
            alert("[비밀번호]가 일치하지 않습니다.");
            form.member_pw.focus();
            return false;
        }
    }

    if(form.member_email.value == ""){
        alert("[이메일]을 입력해 주세요.");
        form.member_email.focus();
        return false;
    }

    // 이메일 형식 체크
    var TEmailChk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    if(form.member_email.value.match(TEmailChk) != null){
    }else{
        alert("잘못된 이메일 형식입니다.\n[이메일]을 다시 입력해 주세요.");
        form.member_email.focus();
        return false;
    }

    form.submit();
};
</script>



<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>회원 등록</h2>
        <ol class="m-0 p-2">
            <li>회원 관리</li>
            <li><b>회원 등록</b></li>
        </ol>
    </div>
</div>





<form name="form_input" method="post" action="<%=request.getContextPath() %>/admin/member/memberWriteOk.do" onsubmit="return join_check();">
<div class="page-cont">
    <div class="row">
        <div class="col-lg mb-4">
            <div class="card input-form">
                <div class="card-body p-4">
                    <div class="row form my-4 view-limit">
                        <div class="form-group col mb-2">
                            <label>회원 유형</label>
                            <div class="btn-group mt-2" role="group" data-toggle="buttons">
                                <label class="btn btn-outline-secondary active">
                                    <input type="radio" name="member_type" value="user" checked="checked" /> 일반회원
                                </label>
                                <label class="btn btn-outline-secondary">
                                    <input type="radio" name="member_type" value="admin" /> 관리자
                                </label>
                                <label class="btn btn-outline-secondary">
                                    <input type="radio" name="member_type" value="exit" /> 탈퇴회원
                                </label>
                            </div>
                        </div>
                        <div class="w-100 border-bottom"></div>

                        <div class="form-group col">
                            <label for="member_id">아이디</label>
                            <input type="text" name="member_id" id="member_id" class="form-control d-inline w-30" required />
                            <div id="idchk-txt" class="d-inline ml-2"></div>
                            <input type="hidden" name="idchk" value="N" />
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col mb-2">
                            <label for="member_pw">비밀번호</label>
                            <input type="password" name="member_pw" id="member_pw" class="form-control w-50" required />
                        </div>
                        <div class="form-group col mb-2">
                            <label for="member_pw_re">비밀번호 확인</label>
                            <input type="password" name="member_pw_re" id="member_pw_re" class="form-control w-50" required />
                        </div>

                        <div class="w-100 border-bottom"></div>

                        <div class="form-group col">
                            <label for="member_name">이름</label>
                            <input type="text" name="member_name" id="member_name" class="form-control w-30" required />
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col">
                            <label for="member_email">이메일</label>
                            <input type="text" name="member_email" id="member_email" class="form-control" required />
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col">
                            <label for="member_phone">연락처</label>
                            <input type="text" name="member_phone" id="member_phone" maxlength="15" class="form-control w-30" required />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




<div class="d-flex mt-2 input-form-button">
    <div class="col-lg text-center">
        <a href="<%=request.getContextPath()%>/admin/member/member_list.do?search_type=${search_type}&search_name=${search_name}&search_id=${search_id}&search_email=${search_email}&search_phone=${search_phone}&page=${param.page}" class="btn btn-secondary btn-lg m-2"><i class="fa fa-bars"></i> 목록보기</a>
        <button type="submit" class="btn btn-primary btn-lg m-2"><i class="fa fa-pencil"></i> 등록하기</button>
    </div>
</div>
</form>




<%@ include file="../layout/layout_footer.jsp" %>