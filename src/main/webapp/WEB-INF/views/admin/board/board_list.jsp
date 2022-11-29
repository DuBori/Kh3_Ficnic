<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div align="center">
		<h5>총 ${List.size() }개의 게시판</h5>
		<table border="1" cellspacing="0">
			<tr>
				<th>노출 순위</th>
				<th>게시판 아이디</th>
				<th>게시판 이름</th>
				<th>게시판 권한</th>
				<th>확인</th>
				<th>기능</th>
			</tr>
			<c:choose>
				
				<c:when test="${!empty List}">
					<c:forEach items="${List }" var="dto">
						<tr>
							<td>${dto.getBoard_no()}</td>
							<td><a href="<%=request.getContextPath()%>/board_modify.do?board_no=${dto.getBoard_no()}">${dto.getBoard_name()}</a></td>
							<td>${dto.getBoard_id()}</td>
							<td>${dto.getBoard_level_list()} ${dto.getBoard_level_view()} ${dto.getBoard_level_write()}</td>
							<td><input type="button" value="게시판 보기"></td>
							<td>
								<input type="button" value="수정" onclick="location.href='board_modify.do?board_no=${dto.getBoard_no()}'">
								<input type="button" value="삭제">
							
							</td>
						</tr>
					</c:forEach>
				
				</c:when>
				
				<c:otherwise>
						<tr>
							<td colspan="6">게시판 없음</td>
						</tr>
				
				</c:otherwise>
			</c:choose>
		</table>
		<form action="<%=request.getContextPath()%>/hi.do" method="post">
			<div>
				<div>
					<label for="searchbtn">게시판 이름</label>	
					<input name="searchbtn" placeholder="게시판 이름">
					<input type="submit" value="검색">
				</div>
		</form>
				<div>
					<input type="button" value="게시판 추가" onclick="location.href='board_write.do'" >
				</div>
				
			</div>
	
		
		
	</div>
</body>
</html>