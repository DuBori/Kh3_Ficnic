<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../../layout/layout_header.jsp" %>


<div class="contents w1150">



<c:if test="${!empty boardConfig }">
	<c:set value="${boardConfig}" var="conf"/>
</c:if>

	<c:if test="${!empty m }">
		<c:set var="tag" value="/board/board_modify_ok.do"/>
		<c:set var="category" value="${Cont.getBdata_category() }"/>
		<c:set var="title" value="${Cont.getBdata_title() }"/>
		<c:set var="cont" value="${Cont.getBdata_cont() }"/>
		<c:set var="subcont" value="${Cont.getBdata_sub() }"/>
		<c:set var="link1" value="${Cont.getBdata_link1() }"/>
		<c:set var="link2" value="${Cont.getBdata_link2() }"/>
		<c:set var="file1" value="${Cont.getBdata_file1() }"/>
		<c:set var="file2" value="${Cont.getBdata_file2() }"/>
		<c:set var="file3" value="${Cont.getBdata_file3() }"/>
		<c:set var="file4" value="${Cont.getBdata_file4() }"/>
		<c:set var="ficnic" value="${Cont.getBdata_ficnic() }"/>
		<c:set var="notice" value="${Cont.getBdata_use_notice() }"/>
		<c:set var="secret" value="${Cont.getBdata_use_secret() }"/>
		<c:set var="id" value="${Cont.getBdata_writer_id() }"/>
		<c:set var="name" value="${Cont.getBdata_writer_name() }"/>
		<c:set var="bdata_no" value="${Cont.getBdata_no() }"/>
		<c:set var="bbs_id" value="${Cont.getBoard_id() }"/>
	</c:if>
	<c:if test="${empty m}">
		<c:set var="tag" value="/board/board_write_ok.do"/>
	</c:if>


	

	<div class="page-info row mb-3">
	    <div class="d-flex align-items-center justify-content-between">
	        <h2>${conf.getBoard_name()}</h2>
	        <ol class="m-0 p-2">
	            <li>게시판 관리</li>
	            <li>${conf.getBoard_name()}</li>
	            <li><b>게시물등록</b></li>
	        </ol>
	    </div>
	</div>
	<div class="page-cont">
		
		<h5>게시물 등록하기</h5>
		<form action="<%=request.getContextPath()%>${tag}" method="post" enctype="multipart/form-data" >
			<c:if test="${!empty m }">
				<input type="hidden" value="${bdata_no}" name="bdata_no">
				<input type="hidden" value="${bbs_id}" name="bbs_id">
			</c:if>
			<input type="hidden" value="${conf.getBoard_id() }" name="board_id">
			
			<c:if test="${!empty sess_id }"> <input type="hidden" name="bdata_writer_id" value="${sess_id}" ></c:if>
		<table border="1" cellspacing="0">
		
			<!-- 게시물 카테고리 설정  -->
			<c:if test="${conf.getBoard_use_category() eq 'Y' }">	
			<tr>
				<th>게시물 카테고리 번호</th>
				<td>
					<!-- 카테고리 작업 끝나면 수정 예정 (리스트) -->
					<select name="bdata_category">
						<option value="1" <c:if test="${!empty category and category eq '1'}">selected</c:if> >쓰레기값1</option>
						<option value="2" <c:if test="${!empty category and category eq '2'}">selected</c:if> >쓰레기값2</option>
						<option value="3" <c:if test="${!empty category and category eq '3'}">selected</c:if> >쓰레기값3</option>
					</select>
				</td>
			</tr>
			</c:if>

			<tr>
				<th>글작성 옵션</th>
				 <td>
				 <c:choose>
				 	<c:when test="${sess_id eq'admin'}">
				 		<input type="checkbox" value="Y" name="bdata_use_notice">공지사항
				 	</c:when>
				 	<c:when test="${empty conf.getBoard_level_notice() and sess_id ne 'admin' }">
				 		<input type="checkbox" value="Y" name="bdata_use_notice">공지사항
				 	</c:when>
				 	<c:when test="${conf.getBoard_level_notice() eq 'user' and !empty sess_id}">
				 		<input type="checkbox" value="Y" name="bdata_use_notice">공지사항
				 	</c:when>
				 	<c:otherwise>
				 	
				 	</c:otherwise>
				 </c:choose>
				 
				 	<c:if test="${!empty m and notice eq 'Y' }">
				 		<input type="checkbox" value="Y" name="bdata_use_notice" checked="checked">공지사항
				 	</c:if>
				 	
				 	<!-- 게시판 비밀글 설정 -->
				 	<c:if test="${conf.getBoard_use_only_secret() eq 'Y'}">
				 		<input type="checkbox" value="Y" disabled="disabled" checked="checked" name="bdata_use_secret">비밀글 사용
				 	</c:if>  
				 	
				 	<c:if test="${conf.getBoard_use_only_secret() ne 'Y'}">
					 	<c:if test="${conf.getBoard_use_secret() eq 'Y'}">
					 		<input type="checkbox" value="Y" name="bdata_use_secret" <c:if test="${secret eq 'Y'}">checked</c:if> >비밀글 사용
					 	</c:if>  
					 	<c:if test="${conf.getBoard_use_secret() ne 'Y'}">
					 		<input type="hidden" value="N" name="bdata_use_secret">
					 	</c:if>  
				 	</c:if>
				 	
				 </td>
			</tr>
			<tr>
			
				<th>작성자 이름</th>
				
				<!-- 게시글 작성 글 작성권한(모든사람) || 로그인 | 비로그인 || // 게시글 수정   -->	
				<c:choose>			
					<c:when test="${!empty sess_id and empty m}">
						<td><input name="bdata_writer_name" disabled="disabled" value="${sess_name}"></td>
						<input type="hidden"  name="bdata_writer_name" value="${sess_name}">
						<input type="hidden"  name="bdata_writer_pw" value="${sess_pw}">
					</c:when>
					<c:when test="${!empty m}">	
						<td><input name="bdata_writer_name" value="${name}" disabled="disabled"></td>
					</c:when>
					<c:otherwise>
						<td>작성자 이름<input name="bdata_writer_name" required="required"><br>
						작성자 비밀번호<input name="bdata_writer_pw" required="required">
						<input type="hidden" name="bdata_writer_id" value="trash">
						</td>
					</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<th>게시물 제목</th>
				<td><input name="bdata_title" required="required" value="${title}"></td>
			</tr>
			<tr>
				<th>게시물 내용</th>
				<td>
					<textarea rows="7" cols="25" name="bdata_cont">${cont}</textarea>
					
				</td>
			</tr>
			<tr>
				<th>게시물 추가내용</th>
				<td>
					<textarea rows="7" cols="25" name="bdata_sub">${sub}</textarea>
					
				</td>
			</tr>
			<c:if test="${conf.getBoard_use_link1() eq 'Y' }">
				<tr>
					<th>관련사이트 링크#1</th>
					<td><input name="bdata_link1" value="${link1}" > </td>
				</tr>
			</c:if>
			<c:if test="${conf.getBoard_use_link2() eq 'Y' }">
				<tr>
					<th>관련사이트 링크#2</th>
					<td><input name="bdata_link2" value="${link2}"></td>
				</tr>
			</c:if>
			
			<c:if test="${conf.getBoard_use_file1() eq 'Y' }">
				<tr>
					<th>첨부파일#1</th>
					<td>
						<input type="file" name="file1" >
					</td>
				</tr>
			</c:if>
			<c:if test="${conf.getBoard_use_file2() eq 'Y' }">
				<tr>
					<th>첨부파일#2</th>
					<td>
						<input type="file" name="file2">
					</td>
				</tr>
			</c:if>
			<c:if test="${conf.getBoard_use_file3() eq 'Y' }">
				<tr>
					<th>첨부파일#3</th>
					<td>
						<input type="file" name="file3" >
					</td>
				</tr>
			</c:if>
			<c:if test="${conf.getBoard_use_file4() eq 'Y' }">
				<tr>
					<th>첨부파일#4</th>
					<td>
						<input type="file" name="file4"  >
					</td>
				</tr>
			</c:if>
			<tr>
				<td colspan="2" align="center">
					<c:if test="${!empty m }">
						<input type="submit" value="수정하기">
					</c:if>
					<c:if test="${empty m }">
						<input type="submit" value="등록하기">
					</c:if>
					<input type="button" value="목록보기" onclick="location.href='${path}/board/board_list.do?bbs_id=${conf.getBoard_id()}'">
				</td>
			</tr>	
			
		</table>
		</form>

	</div>



</div>



<%@ include file="../../layout/layout_footer.jsp" %>