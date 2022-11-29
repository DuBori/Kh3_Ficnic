<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="dto" value="${dto}" />
<c:set var="deptList" value="${deptList}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 상세 내역</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous"></script>
</head>
<body>
    <div style="width: 600px; margin: 50px auto; text-align: center;">
        <hr color="green" />
        <h3>회원 상세 내역 정보 보기</h3>
        <hr color="green" />

        <br />

        <table class="table table-bordered">
            <c:if test="${!empty dto}">
            <tr>
                <th>회원 유형</th>
                <td align="left">
                ${dto.getMember_type()}
                </td>
            </tr>
            <tr>
                <th>아이디</th>
                <td align="left">${dto.getMember_id()}</td>
            </tr>
            <tr>
                <th>이름</th>
                <td align="left">${dto.getMember_name()}</td>
            </tr>
            <tr>
                <th>이메일</th>
                <td align="left">${dto.getMember_email()}</td>
            </tr>
            <tr>
                <th>연락처</th>
                <td align="left">${dto.getMember_phone()}</td>
            </tr>
            <tr>
                <th>적립금</th>
                <td align="left"><fmt:formatNumber value="${dto.getMember_point()}" /></td>
            </tr>
            <tr>
                <th>가입일자</th>
                <td align="left">${dto.getMember_joindate().substring(0, 10)}</td>
            </tr>
            
            <!-- 버튼 //START -->
		    <tr>
		    	<td colspan="2">
			        <button type="button" class="btn btn-outline-secondary"><i class="fa fa-print"></i> 인쇄하기</button>
			        <button type="button" class="btn btn-secondary ml-2"><i class="fa fa-times"></i> 창닫기</button>
		    	</td>
		    </tr>
		    <!-- 버튼 //END -->
		    
            </c:if>

            <c:if test="${empty dto}">
            <tr>
                <td colspan="2" align="center">
                    <h3>검색된 회원의 정보가 없습니다.</h3>
                </td>
            </tr>
            </c:if>
        </table>

    </div>

     
    
</body>
</html>