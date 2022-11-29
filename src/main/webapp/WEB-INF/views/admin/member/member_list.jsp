<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous"></script>
</head>
<body>
    <div style="width: 600px; margin: 50px auto; text-align: center;">
        <div class="shadow p-3 mb-5 bg-body rounded ">
        	<h3>회원 목록 페이지</h3>
		</div>
        <br />

        <table class="table table-striped border-top align-middle">
            <colgroup>
                <col width="10%" />
                <col width="10%" />
                <col width="10%" />
                <col />
                <col width="10%" />
                <col width="10%" />
                <col width="10%" />
            </colgroup>

            <thead>
                <tr>
                    <th>No.</th>
                    <th>유형</th>
                    <th>이름/아이디</th>
                    <th>이메일</th>
                    <th>전화번호</th>
                    <th>적립금</th>
                    <th>등록일</th>
                    <th>기능</th>
                </tr>
            </thead>

            <tbody>
                <c:set var="list" value="${List}" />
                <c:if test="${!empty list}">
                <c:forEach items="${list}" var="dto">
                <tr>
                    <td>${dto.getMember_no()}</td>
                    <td>${dto.getMember_type()}</td>
                    <td>
                    	<a href="<%=request.getContextPath()%>/member_view.do?no=${dto.getMember_no()}">${dto.getMember_id()}<br>${dto.getMember_name()}</a>
                    </td>
                    <td>${dto.getMember_email()}</td>
                    <td>${dto.getMember_phone()}</td>
                    <td><fmt:formatNumber value="${dto.getMember_point()}" /></td>
                    <td>${dto.getMember_joindate().substring(0,10)}</td>
                	<td>
	                    <a href="<%=request.getContextPath()%>/member_modify.do?no=${dto.getMember_no()}" class="btn btn-sm btn-outline-primary m-1">수정</a>
	                    <a href="<%=request.getContextPath()%>/member_delete.do?no=${dto.getMember_no()}" class="btn btn-sm btn-outline-danger m-1" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                    </td>
                </tr>
                </c:forEach>
                </c:if>

                <c:if test="${empty list}">
                <tr>
                    <td colspan="7">
                        <h3 class="my-5">회원 목록이 없습니다.</h3>
                    </td>
                </tr>
                </c:if>
            </tbody>

            <tfoot>
                <tr>
                    <td colspan="8" class="border-0 px-0 pt-3">
                        <div class="row mx-0 justify-content-between">
                            <div class="col-8 px-0 d-flex justify-content-end">
                                <a href="<%=request.getContextPath()%>/member_write.do" class="btn btn-primary">회원등록</a>
                            </div>
                        </div>
                    </td>
                </tr>
            </tfoot>
            
        </table>

    </div>
</body>
</html>