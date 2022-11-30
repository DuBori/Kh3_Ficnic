<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/layout_header.jsp" %>

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

<div class="page-cont">




<div class="pb100">
    <form name="write_form" method="post" action="<%=request.getContextPath() %>/admin/member/member_modifyOk.do?no=${dto.getMember_no()}" onsubmit="return join_check();">
    <input type="hidden" name="member_pw" value="${dto.getMember_pw()}" />
    <input type="hidden" name="member_point" value="${dto.getMember_point()}" />
    <table class="table-form mt-3">
        <colgroup>
            <col width="16%" />
            <col width="34%" />
            <col width="16%" />
            <col />
        </colgroup>
        <tr>
            <th>회원 유형</th>
            <td colspan="3">
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="radio" name="member_type" value="user" class="form-check-input"<c:if test="${dto.getMember_type() == 'user'}"> checked="checked"</c:if> /> 일반회원</label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label"><input type="radio" name="member_type" value="admin" class="form-check-input"<c:if test="${dto.getMember_type() == 'admin'}"> checked="checked"</c:if> /> 관리자</label>
                </div>
            </td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>아이디</th>
            <td colspan="3">
                <input type="text" name="member_id" value="${dto.getMember_id()}" maxlength="30" class="form-control-plaintext d-inline w-30" readonly required />
            </td>
        </tr>
        <tr>
            <th>비밀번호 변경</th>
            <td><input type="password" name="pw" maxlength="50" class="form-control w-80" /></td>
            <th>비밀번호 변경 확인</th>
            <td><input type="password" name="member_pw_chg_re" maxlength="50" class="form-control w-80" /></td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>

        <tr>
            <th>이름</th>
            <td colspan="3"><input type="text" name="member_name" value="${dto.getMember_name()}" maxlength="50" class="form-control w-30" required /></td>
        </tr>
        <tr>
            <th>이메일</th>
            <td><input type="text" name="member_email" value="${dto.getMember_email()}" maxlength="100" class="form-control" required /></td>
            <th>연락처</th>
            <td><input type="text" name="member_phone" value="${dto.getMember_phone()}" maxlength="15" class="form-control" required /></td>
        </tr>

        <tr>
            <td colspan="4" class="space" nowrap="nowrap"></td>
        </tr>
        
        <tr>
            <th>적립금</th>
            <td colspan="3">
                <input type="number" name="point" value="${dto.getMember_point()}" maxlength="30" class="form-control-plaintext d-inline w-30" required />
            </td>
        </tr>

    </table>



    <div class="gw-button">
        <div class="gwb-wrap">
            <div class="gwb-left"></div>

            <div class="gwb-center">
                <button type="button" class="btn btn-lg btn-outline-secondary mx-1" onclick="history.back();"><i class="fa fa-bars"></i> 취소하기</button>
                <button type="submit" class="btn btn-lg btn-success mx-1"><i class="fa fa-save"></i> 수정하기</button>
            </div>

            <div class="gwb-right"></div>
        </div>
    </div>
    </form>
</div>



</div>


<%@ include file="../layout/layout_footer.jsp" %>