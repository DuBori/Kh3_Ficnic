<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%@ include file="../layout/layout_header.jsp" %> --%>



<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>${boardConfig.getBoard_name()}</h2>
        <ol class="m-0 p-2">
        	<li>게시판</li>
            <li><b>${boardConfig.getBoard_name()}</b></li>
        </ol>
    </div>
</div>

<!-- Content 시작부 -->

<div class="page-cont" align="center">
	
	<div>
		${boardConfig.getBoard_id()} &nbsp; >${boardConfig.getBoard_id()}<br>
	</div>

	<!-- 해당 게시글 리스트 출력부  -->
	<table class="table-list mb-2" border="1">
      <thead>
          <tr>
			<th>번호</th>
			<th>제목</th>
			<th>글쓴이</th>
			<th>작성일</th>
			<th>조회수</th>
         </tr>
   </thead>
   <tbody>
		<c:forEach items="${List}" var="dto">
		<c:if test="${!empty dto.getBdata_file1()}"><c:set var="file1" value="📷"/></c:if>
		<c:if test="${!empty dto.getBdata_file2()}"><c:set var="file2" value="📷"/></c:if>
		<c:if test="${!empty dto.getBdata_file3()}"><c:set var="file3" value="📷"/></c:if>
		<c:if test="${!empty dto.getBdata_file4()}"><c:set var="file4" value="📷"/></c:if>
		
			<tr>
				<td>${dto.getBdata_no() }</td>
				<c:if test="${dto.getBdata_use_secret() eq 'Y'}">
					<td>🔒비밀글 입니다.</td>
				</c:if>
				<c:if test="${dto.getBdata_use_secret() eq 'N'}">
					<td><a href="<%=request.getContextPath()%>/site/board/board_view.do?bbs_id=${dto.getBoard_id()}&bdata_no=${dto.getBdata_no() }&field=${field}&keyword=${keyword}&page=${paging.getPage()}">${dto.getBdata_title()}</a>${file1}${file2}${file3}${file4}(${dto.getBdata_comment()})</td>
				</c:if>
				
				<td>${dto.getBdata_writer_name() }</td>
				<td>${dto.getBdata_date().substring(0,10) }</td>
				<td>${dto.getBdata_hit() }</td>
			
			</tr>
		</c:forEach>
	</tbody>
	</table>
	<!-- 해당 게시글 리스트 출력부 end -->
	
	<!-- 페이징 처리  -->
	<c:if test="${!empty paging}">
            <div class="row list-bottom-util">
                <div class="col text-center">
                    ${pagingWrite}
                </div>
            </div>
    </c:if>
    <!-- 페이징 처리 end -->
    
    <!-- 검색 처리  -->
    <form name="search_form" method="get" action="<%=request.getContextPath()%>/site/board/board_list.do">
	    <div class="row mt-2 list-bottom-util">
	       <div class="col-6 mt-3">
	               <input type="hidden" value="${bbs_id}" name="bbs_id">
	               <div class="input-group w-80">
	                   <div class="col-sm-4">
	                       <select name="field" class="form-select">
	                           <option value="title"<c:if test="${field eq 'title'}"> selected="selected"</c:if>>제목</option>
	                           <option value="cont"<c:if test="${field eq 'cont'}"> selected="selected"</c:if>>내용</option>
	                           <option value="writer"<c:if test="${field eq 'writer'}"> selected="selected"</c:if>>작성자</option>
	                       </select>
	                   </div>
	                   <input type="text" name="keyword" value="${keyword}" class="form-control" />
	                   <button type="submit" class="btn btn-secondary ml-1"><i class="fa fa-search"></i> 검색</button>
	               </div>
	           
	       </div>
		</div>
		</form>
		<!-- 검색 처리 end -->
		
		<div class="col-6 text-right mt-3">
	             <c:choose>
		             <c:when test="${!empty field}">
		             	<a href="<%=request.getContextPath()%>/site/board/board_list.do?bbs_id=${boardConfig.getBoard_id()}" class="btn btn-outline-secondary"><i class="fa fa-list mr-1"></i> 게시물 전체목록</a>
		             </c:when>
		             <c:otherwise>
		             	<a href="<%=request.getContextPath()%>/site/board/board_write.do?bbs_id=${boardConfig.getBoard_id()}" class="btn btn-primary"  <c:if test="${empty session_id and conf.getBoard_level_write() ne 'null' }"> onclick="return alert('권한이 없습니다.');" </c:if> ><i class="fa fa-pencil mr-1"></i> 새로운 글쓰기</a>
		             </c:otherwise>
	             </c:choose>
		</div>	
	

</div>


<%-- <%@ include file="../layout/layout_footer.jsp" %> --%>