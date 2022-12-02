<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../layout/layout_header.jsp"%>

<c:set var="dto" value="${dto}" />
<c:set var="cdto" value="${cdto}" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script>

   
   // 댓글 추가 에이젝스
   $(function() {
	    $("#replyBtn").on("click", function() {
	         $.ajax({
		             type : "post",
		             contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		             url : "<%=request.getContextPath()%>/admin/qna/qna_reply_ok.do",
		             data : {
		             qna_no :$("#qna_no").val(),
	            	 comment_content : $("#comment_content").val(),
	            	 comment_date : $("#comment_date").val(),
	            	 comment_no : $("#comment_no").val(),
	            	 comment_writer_name : $("#comment_writer_name").val(),
	            	 comment_writer_pw : $("#comment_writer_pw").val(),
	            	 member_id : $("#member_id").val()
	            	 },
	             datatype : "text",
	             success : function(data) {
	            	 if(data>0){
	            		 location.href="<%=request.getContextPath()%>/admin/qna/qna_view.do?no="+$("#qna_no").val();
	            	 }else{
	            		 alert("실패");
	            	 }
	             },
	             error : function(data) {
	                 alert("에러발생");
	             }
	         });
	     });
	})
   
   
	
	// 댓글 삭제 에이젝스****************************
	//***********************************
	
	<%-- $(function() {
		$("#deleteBtn").on("click", function() {
	  let categoryNo = $(this).attr("value")
	  let imgObj = $(this);

	  $.ajax({
	    url: "<%=request.getContextPath()%>/admin/qna/qnaComment_delete.do" + categoryNo,
	    type: "POST",
	    data: {},
	    dataType: "text",
	    success: function( result ){
	      if( result ){
	        // 삭제 버튼을 누른 row 제거
	        $(imgObj).parent().parent().remove();
	      }
	    },
	    error: function( err ){
	    	alert("에러발생");
	    }
	  })
	})
		}) --%>




   
	</script>
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


		<div style="width: 600px; margin: 50px auto; text-align: center;">
			<hr color="green" />
			<h3>QnA 상세 정보</h3>
			<hr color="green" />

			<br />

			<!-- 나중에 세션 생기면 입력하기 -->
			<input type="hidden" id="qna_no" name="qna_no" value="${param.no}" />
			<input type="hidden" id="member_id" name="member_id" value="test1" />
			<input type="hidden" id="comment_writer_name" name="comment_writer_name" value="테스트회원1" /> 
			<input type="hidden" id="comment_writer_pw" name="comment_writer_pw" value="1234" />
			<input type="hidden" id="comment_no" name="comment_no" value="${param.comment_no}"/>


			<table class="table table-bordered">

				<c:if test="${!empty dto}">
					<h3>문의글 상세 정보</h3>
					<tr>
						<th>작성일</th>
						<td align="left">${dto.qna_date}</td>
					</tr>

					<tr>
						<th>이름</th>
						<td align="left">${dto.qna_name}</td>
					</tr>

					<tr>
						<th>아이디</th>
						<td align="left">${dto.member_id}</td>
					</tr>
					<tr>
						<th>문의 제목</th>
						<td align="left">${dto.qna_title}</td>
					</tr>
					<tr>
						<th>문의 내용</th>
						<td align="left">${dto.qna_cont}</td>
					</tr>

				</c:if>


				<c:if test="${empty dto}">
					<tr>
						<td colspan="2" align="center">
							<h3>존재하지 않는 문의글입니다...</h3>
						</td>
					</tr>
				</c:if>
			</table>


			<table border="1" cellspacing="0" cellpadding="4px" width="600px">


				<colgroup>
					<col width="20%" />
					<col />
					<col width="20%" />
					<col width="20%" />
				</colgroup>
				<thead>
					<tr>
						<th>작성자</th>
						<th>내용</th>
						<th>작성일</th>
						<th>기능</th>
					</tr>
				</thead>

				<tbody>



					<c:if test="${!empty cdto }">
						<c:forEach items="${cdto }" var="cdto">
							<tr>
								<td>${cdto.comment_writer_name }</td>
								<td class="msg">${cdto.comment_content }</td>
								<td>${cdto.comment_date }</td>
								<td>
								<button type="button" class="btn btn-sm btn-outline-danger m-1" id="deleteBtn">삭제</button>
								</td>
							</tr>
						</c:forEach>
					</c:if>

					<c:if test="${empty cdto }">
						<tr>
							<td colspan="4" align="center">
								<h3>댓글이 없습니다.</h3>
							</td>

						</tr>
					</c:if>
				</tbody>


				<tr>
					<th>댓글 내용</th>
					<td><textarea name="comment_content" id="comment_content"
							cols="20" rows="3" class="form-control" required></textarea></td>
					<td class="text-center">
						<button type="button" class="btn btn-lg btn-primary w-100 h-100"
							id="replyBtn">
							<i class="fa fa-pencil"></i> 쓰기
						</button>

					</td>
				</tr>

			</table>



			<!-- 버튼 //START -->
			<div class="d-flex justify-content-center mb-4">
				<button type="button" class="btn btn-outline-secondary"
					onclick="window.print();">
					<i class="fa fa-print"></i> 인쇄하기
				</button>
				<button type="button" class="btn btn-secondary ml-2"
					onclick="window.close();">
					<i class="fa fa-times"></i> 창닫기
				</button>
			</div>
			<!-- 버튼 //END -->

		</div>

	</div>


	<%@ include file="../layout/layout_footer.jsp"%>


</body>
</html>