<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous"></script>
    </head>
<body>

<div align="center">
		<div class="shadow p-3 mb-5 bg-body rounded ">
            <h3>리뷰 관리 게시판</h3>
        </div>
		<br>
		

        <table border="1" cellspacing="0" cellpadding="4px" width="1300px">
            <colgroup>
                <col width="10%" />
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
					<th> 리뷰 번호 </th>
					<th> 피크닉 번호 </th>
					<th> 리뷰 사진 </th>
					<th> 평점 </th>
					<th> 리뷰 내용 </th>
					<th> 작성자<br>아이디 </th>
					<th> 작성일 </th>
					<th> 기능 </th>
				</tr>
			</thead>
			
			<tbody>
			<c:set var="list" value="${List }" />
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="dto">
					<tr>
						<td><a href="<%=request.getContextPath()%>/admin/review_view.do?no=${dto.review_no}">${dto.review_no}</a></td>
						<td> ${dto.ficnic_no } </td>
						<td> ${dto.review_photo1 } </td>
						<td> ${dto.review_point } </td>
						<td> ${dto.review_cont } </td>
						<td> ${dto.review_name } </td>
						<td> ${dto.review_date.substring(0,10) } </td>
						<td>
                    <a href="<%=request.getContextPath()%>/admin/review_modify.do?no=${dto.review_no}" class="btn btn-sm btn-outline-primary m-1">수정</a>
                    <a href="<%=request.getContextPath()%>/admin/review_delete.do?no=${dto.review_no}" class="btn btn-sm btn-outline-danger m-1" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
              			</td> 
					</tr>
				</c:forEach>
			</c:if>
			
			<c:if test="${empty list }">
				<tr>
					<td colspan="4" align="center">
						<h3> 리스트가 없습니다. </h3>
					</td>

				</tr>
			</c:if>
			</tbody>
			
			
            
		</table>	
	
	</div>


</body>
</html>