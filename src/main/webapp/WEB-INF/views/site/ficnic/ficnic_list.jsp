<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>

<div class="contents w1100">







      	<!-- 페이징 처리  -->
		<c:if test="${!empty paging}">
	            <div class="row list-bottom-util">
	                <div class="col text-center">
	                    ${pagingWrite}
	                </div>
	            </div>
	    </c:if>
	    <!-- 페이징 처리 end -->

</div>



<%@ include file="../layout/layout_footer.jsp" %>