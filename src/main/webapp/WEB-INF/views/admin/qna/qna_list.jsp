<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layout/layout_header.jsp" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>게시판 목록</h2>
        <ol class="m-0 p-2">
            <li>게시판 관리</li>
            <li><b>게시판 목록</b></li>
        </ol>
    </div>
</div>


<div class="page-cont">



<div align="center">
		<div class="shadow p-3 mb-5 bg-body rounded ">
            <h3>QnA 관리 게시판</h3>
        </div>
		<br>
		

        <table border="1" cellspacing="0" cellpadding="4px" width="1150px">
            <colgroup>
                <col width="15%" />
                <col />
                <col width="15%" />
                <col width="15%" />
                <col width="15%" />
            </colgroup>
            
            <thead>
				<tr>
					<th> 문의글 번호 </th>
					<th> 제목 </th>
					<th> 작성자 <br> 아이디 </th>
					<th> 등록일 </th>
					<th> 기능 </th>
				</tr>
			</thead>
			
			<tbody>
			<c:set var="list" value="${List }" />
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="dto">
					<tr>
						<td><a href="<%=request.getContextPath()%>/admin/qna/qna_view.do?no=${dto.qna_no}">${dto.qna_no}</a></td>
						<td> ${dto.qna_title } </td>
						<td> <b> ${dto.qna_name } </b> <br> ${dto.member_id } </td>
						<td> ${dto.qna_date.substring(0,10) } </td>
						<td>
                    <a href="<%=request.getContextPath()%>/admin/qna/qna_delete.do?no=${dto.qna_no}" class="btn btn-sm btn-outline-danger m-1" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
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



</div>


<%@ include file="../layout/layout_footer.jsp" %>




</body>
</html>