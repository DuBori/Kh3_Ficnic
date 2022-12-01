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
	<div class="page-info row mb-3">
	    <div class="d-flex align-items-center justify-content-between">
	        <h2>${board.getBoard_name()}</h2>
	        <ol class="m-0 p-2">
	            <li>게시판 관리</li>
	            <li>${board.getBoard_name()}</li>
	            <li><b>게시물등록</b></li>
	        </ol>
	    </div>
	</div>
	<div class="page-cont">
		
		<h5>게시물 등록하기</h5>
		<form action="<%=request.getContextPath()%>/site/board/board_write_ok.do" method="post" enctype="multipart/form-data" >
			<input type="hidden" value="${bbs_id }" name="board_id">
			<input type="hidden" value="${bbs_id }" name="board_id">
		<table border="1" cellspacing="0">
		
			<tr>
				<th>열람구분</th>
				<td>
					<select name="board_level_view">
						<option value="null">전체회원</option>
						<option value="user">회원</option>
						<option value="admin">관리자</option>
					</select>
				</td>
			</tr>
			<!-- 관리자일때 지정하는 옵션  -->
			<tr>
				<th>글작성 옵션</th>
				 <td>
				 	<input type="radio" value="Y" name="bdata_use_notice">공지사항
				 </td>
			</tr>
			<tr>
				<th>작성자 이름</th>
				<td><input name="bdata_writer_name" required="required"></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input name="bdata_title" required="required"></td>
			</tr>
			<tr>
				<th>글내용</th>
				<td>
					<textarea rows="7" cols="25" name="bdata_cont">
						
					</textarea>
					
				</td>
			</tr>
			<tr>
				<th>관련사이트 링크#1</th>
				<td><input name="bdata_link1"> </td>
			</tr>
			<tr>
				<th>관련사이트 링크#2</th>
				<td><input name="bdata_link2"></td>
			</tr>
			<tr>
				<th>첨부파일#1</th>
				<td>
					<input type="file" name="file1" >
					 <input type="radio" name="bdata_file1_use" value="Y" >o
					 <input type="radio" name="bdata_file1_use" value="N">x
				</td>
			</tr>
			<tr>
				<th>첨부파일#2</th>
				<td>
					<input type="file" name="file2" >
					<input type="radio" name="bdata_file2_use" value="Y">o
					<input type="radio" name="bdata_file2_use" value="N">x
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="등록하기">
					<input type="button" value="목록보기" onclick="location.href='<%=request.getContextPath()%>/site/board/board_list.do?bbs_id=${board.getBoard_id()}'">
				</td>
			</tr>	
			
		</table>
		</form>

	</div>
</body>
</html>