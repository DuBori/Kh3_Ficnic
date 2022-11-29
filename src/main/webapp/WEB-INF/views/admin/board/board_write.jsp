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
	<c:set var="m" value="${modify}"/>
	<c:if test="${!empty m }">
		<c:set var="tag" value="/config_board_modify.do"/>
		<c:set var="conid" value="${Cont.getBoard_id() }"/>
		<c:set var="conname" value="${Cont.getBoard_name() }"/>
		<c:set var="conskin" value="${Cont.getBoard_skin() }"/>
	</c:if>
	
	<c:if test="${empty m }">
		<c:set var="tag" value="/config_board_write.do"></c:set>
	</c:if>
	
	<form action="<%=request.getContextPath() %>/${tag}" method="post">
	<div>
		<h3>게시판 설정</h3>
		<div>
			<h5>기본 설정</h5>
			<label for="id">게시판 아이디</label>
			<input name="board_id" id="id" value="${conid}"><br>
			
			<label for="name">게시판 이름</label>
			<input name="board_name" id="name" value="${conname }"><br>
		
			<label for="skin">게시판 스킨</label>
			<select name="board_skin" id="skin" >
				<option value="basic">1</option>
				<option value="basic">2</option>
				<option value="basic">3</option>
			</select><br>
				
			<label for="list_num">페이지 목록 갯수</label>
			<input  name="board_list_num" id="list_num" value=""><br>
			
			
			<label for="page_num">페이지 구분 갯수</label>
			<input  name="board_page_num" id="page_num"><br>
			
			<h5>기능 설정</h5>
			<label>글보기시 목록표시
				<input type="radio" value="Y" name="board_use_category" >O
				<input type="radio" value="N" name="board_use_category" checked="checked" >X
			</label><br>
			
			<label>댓글 기능
				<input type="radio" value="Y" name="board_use_comment" checked="checked">O
				<input type="radio" value="N" name="board_use_comment">X
			</label><br>
			
			<label >비밀글 기능
				<input type="radio" value="Y" name="board_use_secret" >O
				<input type="radio" value="N" name="board_use_secret" checked="checked">X
			</label><br>
			
			<label>비밀글 전용
				<input type="radio" value="Y" name="board_use_only_secret" >O
				<input type="radio" value="N" name="board_use_only_secret" checked="checked">X
			</label><br>
			
			<label>관련 사이트 링크#1
				<input type="radio" value="Y" name="board_use_link1" checked="checked">O
				<input type="radio" value="N" name="board_use_link1" >X
			</label><br>
			
			<label>관련 사이트 링크#2
				<input type="radio" value="Y" name="board_use_link2" checked="checked">O
				<input type="radio" value="N" name="board_use_link2">X
			</label><br>
			
			<label>첨부파일 #1
				<input type="radio" value="Y" name="board_use_file1" checked="checked">O
				<input type="radio" value="N" name="board_use_file1">X
			</label><br>
			<label>첨부파일 #2
				<input type="radio" value="Y" name="board_use_file2" checked="checked">O
				<input type="radio" value="N" name="board_use_file2">X
			</label><br>
			<label>첨부파일 #3
				<input type="radio" value="Y" name="board_use_file3" checked="checked">O
				<input type="radio" value="N" name="board_use_file3">X
			</label><br>
			<label>첨부파일 #4
				<input type="radio" value="Y" name="board_use_file4" checked="checked">O
				<input type="radio" value="N" name="board_use_file4">X
			</label><br>
			
			<h5>권한설정</h5>
			
			<label for="level_list">목록 보기 권한</label>
			<select id="level_list" name="board_level_list">
				<option value="">[0]모든사람</option>
				<option value="user">[1]회원</option>
				<option value="admin">[2]관리자</option>
			</select><br>
			
			<label for="level_view">게시물 보기 권한</label>
			<select id="level_view" name="board_level_view">
				<option value="">[0]모든사람</option>
				<option value="user">[1]회원</option>
				<option value="admin">[2]관리자</option>
			</select><br>
			
			<label for="level_write">목록 작성 권한</label>
			<select id="level_write" name="board_level_write">
				<option value="">[0]모든사람</option>
				<option value="user">[1]회원</option>
				<option value="admin">[2]관리자</option>
			</select><br>
			
			<label for="level_comment">댓글 작성 권한</label>
			<select id="level_comment" name="board_level_comment">
				<option value="">[0]모든사람</option>
				<option value="user">[1]회원</option>
				<option value="admin">[2]관리자</option>
			</select><br>
			
			<label for="level_notice">공지사항 작성 권한</label>
			<select id="level_notice" name="board_level_notice">
				<option value="">[0]모든사람</option>
				<option value="user">[1]회원</option>
				<option value="admin">[2]관리자</option>
			</select><br>
			
			<label for="level_modify">게시물 수정 권한</label>
			<select id="level_modify" name="board_level_modify">
				<option value="">[0]모든사람</option>
				<option value="user">[1]회원</option>
				<option value="admin">[2]관리자</option>
			</select><br>
			
			<label for="level_delete">게시물 삭제 권한</label>
			<select id="level_delete" name="board_level_delete">
				<option value="">[0]모든사람</option>
				<option value="user">[1]회원</option>
				<option value="admin">[2]관리자</option>
			</select><br>
		</div>
	</div>
	<div>
		<input type="submit" value="등록하기">
		<input type="button" value="목록보기" onclick="location.href='admin_board.do'">
	</div>
		
	</form>
</body>
</html>