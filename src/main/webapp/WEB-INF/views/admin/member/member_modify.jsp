<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/layout_header.jsp" %>
<script type="text/javascript">
$("#header .navbar .nav-item:nth-child(3)").addClass("active");

join_check = function(){
    var form = document.write_form;

    // 비밀번호 체크
    if(form.member_pw_chg.value.length > 0 && form.member_pw_chg_re.value.length > 0){
        let pwd_pattern = /^(?=.*[a-zA-Z])(?=.*[!@#$%^~*+=-])(?=.*[0-9]).{8,20}$/;
        if(form.member_pw_chg.value != form.member_pw_chg_re.value){
            alert("[비밀번호]가 일치하지 않습니다.");
            form.member_pw_chg.focus();
            return false;
        }
        if(pwd_pattern.test(form.member_pw_chg.value)) {
            if(pwd_pattern.test(form.member_pw_chg_re.value)) {
                return true;
            }else{
                alert("[비밀번호 확인]이 조건에 맞지 않습니다.");
                return false;
            }
        }else {
            alert("[비밀번호]가 조건에 맞지 않습니다.");
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


<c:set var="dto" value="${member}" />


<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>회원 수정</h2>
        <ol class="m-0 p-2">
            <li>회원 관리</li>
            <li><b>회원 수정</b></li>
        </ol>
    </div>
</div>




<form name="form_input" method="post" action="<%=request.getContextPath() %>/admin/member/member_modifyOk.do?no=${dto.getMember_no()}" onsubmit="return join_check();">
<input type="hidden" name="member_pw" value="${dto.getMember_pw()}" />
<input type="hidden" name="member_point" value="${dto.getMember_point()}" />
<div class="page-cont">
    <div class="row">
        <div class="col-lg mb-4">
            <div class="card input-form">
                <div class="card-body p-4">
                    <div class="row form my-4 view-limit">
                        <div class="form-group col mb-2">
                            <label>회원 유형</label>
                            <div class="btn-group mt-2" role="group" data-toggle="buttons">
                                <label class="btn btn-outline-secondary<c:if test="${dto.getMember_type() == 'user'}"> active</c:if>">
                                    <input type="radio" name="member_type" value="user"<c:if test="${dto.getMember_type() == 'user'}"> checked="checked"</c:if> /> 일반회원
                                </label>
                                <label class="btn btn-outline-secondary<c:if test="${dto.getMember_type() == 'admin'}"> active</c:if>">
                                    <input type="radio" name="member_type" value="admin"<c:if test="${dto.getMember_type() == 'admin'}"> checked="checked"</c:if> /> 관리자
                                </label>
                                <label class="btn btn-outline-secondary<c:if test="${dto.getMember_type() == 'exit'}"> active</c:if>">
                                    <input type="radio" name="member_type" value="exit"<c:if test="${dto.getMember_type() == 'exit'}"> checked="checked"</c:if> /> 탈퇴회원
                                </label>
                            </div>
                        </div>
                        <div class="w-100 border-bottom"></div>

                        <div class="form-group col">
                            <label for="member_id">아이디</label>
                            <input type="text" name="member_id" id="member_id" value="${dto.getMember_id()}" class="form-control-plaintext d-inline w-30" readonly="readonly" />
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col mb-2">
                            <label for="pw">비밀번호 변경</label>
                            <input type="password" name="pw" id="pw" class="form-control w-50" />
                        </div>
                        <div class="form-group col mb-2">
                            <label for="member_pw_chg_re">비밀번호 변경 확인</label>
                            <input type="password" name="member_pw_chg_re" id="member_pw_chg_re" class="form-control w-50" />
                        </div>

                        <div class="w-100 border-bottom"></div>

                        <div class="form-group col">
                            <label for="member_name">이름</label>
                            <input type="text" name="member_name" id="member_name" value="${dto.getMember_name()}" class="form-control w-30" required />
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col">
                            <label for="member_email">이메일</label>
                            <input type="text" name="member_email" id="member_email" value="${dto.getMember_email()}" class="form-control" onkeydown="EmailInput(this);" required />
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col mb-2">
                            <label for="member_phone">연락처</label>
                            <input type="text" name="member_phone" id="member_phone" value="${dto.getMember_phone()}" maxlength="15" class="form-control w-30" onkeydown="NumSpInput(this);" required />
                        </div>

                        <div class="w-100 border-bottom"></div>

                        <div class="form-group col">
                            <label for="point">적립금</label>
                            <input type="text" name="point" id="point" value="${dto.getMember_point()}" class="form-control w-30" onkeydown="NumberInput(this);" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




<div class="d-flex mt-2 input-form-button">
    <div class="col-lg text-center">
        <a href="<%=request.getContextPath()%>/admin/member/member_delete.do?no=${dto.getMember_no()}" class="btn btn-danger btn-lg m-2" onclick="return confirm('정말 삭제하시겠습니까?\n되돌릴 수 없습니다.');"><i class="fa fa-trash-o"></i> 삭제하기</a>
        <a href="<%=request.getContextPath()%>/admin/member/member_list.do?search_type=${search_type}&search_name=${search_name}&search_id=${search_id}&search_email=${search_email}&search_phone=${search_phone}&page=${param.page}" class="btn btn-secondary btn-lg m-2"><i class="fa fa-bars"></i> 목록보기</a>
        <button type="submit" class="btn btn-primary btn-lg m-2"><i class="fa fa-save"></i> 수정하기</button>
    </div>
</div>
</form>




<%@ include file="../layout/layout_footer.jsp" %>