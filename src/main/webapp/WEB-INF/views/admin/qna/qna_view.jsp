<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layout/layout_header.jsp" %>

<c:set var="dto" value="${dto}" />
<c:set var="cdto" value="${cdto}" />

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
			
<%--             <c:if test="${!empty dto}">
			<h4>문의글 상세 정보</h4>
			 <tr>
                <th>작성일</th>
                <td align="left">${dto.qna_date}</td>
            </tr> 
            </c:if>  --%>

 			<c:forEach items="${cdto }" var="cdto">
			${cdto.comment_content }
			</c:forEach>
			</table></div></div> 
			
           <%--  <tr>
                <th>이름</th>
                <td align="left">${cdto.comment_writer_name}</td>
            </tr>
            
            
            
            <tr>
                <th>아이디</th>
                <td align="left">
                	${dto.review_photo1}
                </td>
            </tr>
            <tr>
                <th>문의 제목</th>
                <td align="left">
                	${dto.review_photo2}
                </td>
            </tr>
            <tr>
                <th>문의 내용</th>
                <td align="left">
                	${dto.review_photo2}
                </td>
            </tr>
         
           
            </c:if>

            <c:if test="${empty dto}">
            <tr>
                <td colspan="2" align="center">
                    <h3>존재하지 않는 리뷰입니다...</h3>
                </td>
            </tr>
            </c:if>
            
            
            <c:if test="${!empty cdto}">
              <tr>
                <th>작성자</th>
                <td align="left">${dto.review_name}</td>
            </tr>
              <tr>
                <th>내용</th>
                <td align="left">${dto.review_name}</td>
            </tr>
              <tr>
                <th>작성일</th>
                <td align="left">${dto.review_name}</td>
            </tr>
              <tr>
                <th>기능</th>
                <td align="left">${dto.review_name}</td>
            </tr>
            </c:if>
            
            <tr>
                <th>댓글 내용</th>
                <td align="left"><input type="text" name="comment_cont"></td>
            
            <td><input type="button" onclick="<%=request.getContextPath() %>/admin/qna/qna_reply_ok.do " />쓰기</td>
            
            </tr>
            
        </table>


<!-- 버튼 //START -->
    <div class="d-flex justify-content-center mb-4">
        <button type="button" class="btn btn-outline-secondary" onclick="window.print();"><i class="fa fa-print"></i> 인쇄하기</button>
        <button type="button" class="btn btn-secondary ml-2" onclick="window.close();"><i class="fa fa-times"></i> 창닫기</button>
    </div>
    <!-- 버튼 //END -->
    
    </div>

</div>


<%@ include file="../layout/layout_footer.jsp" %>

 --%>

</body>
</html>