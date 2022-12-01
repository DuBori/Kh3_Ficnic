<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layout/layout_header.jsp" %>

<c:set var="dto" value="${dto}" />
<c:set var="cdto" value="${cdto}" />
		
		
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
   <script>
   $(function() {
   
	   $("#replyBtn").on("click", function() {
	    	$.ajax({
	            type : "post",
	            contentType : "application/x-www-form-urlencoded;charset=UTF-8",
	            url : "/admin/qna/test.do",
	            data : { param : $("#qna_no").val() },
	            datatype : "text",
	            success : function(data) {
				
	            },
	            error : function(data) {
	                alert("에러발생");
	            }
	        });

	    }
	   
	);
   });
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
                <td align="left">${dto.member_id}  </td>
            </tr>
            <tr>
                <th>문의 제목</th>
                <td align="left">
                	${dto.qna_title}
                </td>
            </tr>
            <tr>
                <th>문의 내용</th>
                <td align="left">
                	${dto.qna_cont}
                </td>
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
					<th> 작성자 </th>
					<th> 내용 </th>
					<th> 작성일 </th>
					<th> 기능 </th>
				</tr>
			</thead>
			
			 <tbody>
			 
    
			
			<c:if test="${!empty cdto }">
				<c:forEach items="${cdto }" var="cdto">
					<tr>
 					<td> ${cdto.comment_writer_name } </td>
					<td class="msg"> ${cdto.comment_content } </td>
					<td> ${cdto.comment_date } </td>
						<td>
						<!--주소지 삭제 버튼-->
	<button class="btn btn-danger btn-xs delete-address-item" data-index="<?=$row['address_srl']?>">
		<span class="glyphicon glyphicon-trash" style=" vertical-align: middle;">
		</span>
	</button>
                  <%--   <a href="<%=request.getContextPath()%>/admin/qna/qnaComment_delete.do?no=${cdto.comment_no}" class="btn btn-sm btn-outline-danger m-1" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
 --%>              			</td> 
					</tr>
				</c:forEach>
			</c:if>
			
			<c:if test="${empty cdto }">
				<tr>
					<td colspan="4" align="center">
						<h3> 댓글이 없습니다. </h3>
					</td>

				</tr>
			</c:if>
			</tbody>

			       	
			        
			       <%--  <form method="post" action="<%=request.getContextPath() %>/admin/qna/qna_reply_ok.do">
			       	<!-- 나중에 세션 생기면 입력하기 --> --%>
			        <input type="hidden" id="qna_no" name="qna_no" value="${param.no}" />
			        <input type="hidden" id="member_id" name="member_id" value="test1" />
			        <input type="hidden" id="comment_writer_name" name="comment_writer_name" value="테스트회원1" />
			        <input type="hidden" id="comment_writer_pw" name="comment_writer_pw" value="1234" />
			        <input type="hidden" id="comment_content" name="comment_content" value="1234" />
    		  <tr> 
		        <th>댓글 내용</th>										
				<td> 
					<textarea name="comment_content" cols="20" rows="3" class="form-control" required></textarea></td>
	                        <td class="text-center">
	                        <button type="submit" class="btn btn-lg btn-primary w-100 h-100"  id="replyBtn" onclick="process()">
	                        <i class="fa fa-pencil"></i> 쓰기</button>
	                
	             </td>
		    	</tr>
		    	<!-- </form> -->
            
        </table>
        
 

        
        
        <script>
        
        <%-- 	// 댓글 작성 버튼을 클릭했을 때 DB에 추가로 저장.
			$(function() {
		$("#replyBtn").on("click", function() {
			let No = $(this).val().trim();
               
			$.ajax({
	            type : "post",
	            url : "<%=request.getContextPath()%>/admin/qna/qna_reply_ok.do",
	            data : { param : "hi" },
	            datatype : "text",
	            success : function(data) {
	                $(".msg").append(data);
	            },
	            error : function(data) {
	                alert("에러 발생");
	            }
	        });

	    } --%>
	 

		</script>


<!-- 버튼 //START -->
    <div class="d-flex justify-content-center mb-4">
        <button type="button" class="btn btn-outline-secondary" onclick="window.print();"><i class="fa fa-print"></i> 인쇄하기</button>
        <button type="button" class="btn btn-secondary ml-2" onclick="window.close();"><i class="fa fa-times"></i> 창닫기</button>
    </div>
    <!-- 버튼 //END -->
    
    </div>

</div>


<%@ include file="../layout/layout_footer.jsp" %>

 
</body>
</html>