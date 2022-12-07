<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../layout/layout_header.jsp" %>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_board.css" />



<%@ include file="../../layout/layout_csmenu.jsp" %>



<div class="contents w1100 board-list">



<!-- 게시판 보기 권한  -->
<c:set var="level_list" value="${boardConfig.getBoard_level_list()}"/>

<!-- 게시물 보기 권한 -->
<c:set var="level_view" value="${boardConfig.getBoard_level_view()}"/>
<c:choose>
	<c:when test="${level_view eq 'null'}">
		<c:set var="level" value="모든"/>
	</c:when>
	<c:when test="${level_view eq 'user'}">
		<c:set var="level" value="사이트"/>
	</c:when>
	<c:when test="${level_view eq 'admin' }">
		<c:set var="level" value="관리자"/>
	</c:when>
</c:choose>


<!-- Content 시작부 -->
<c:choose>
	<c:when test="${level_list ne 'null' and empty session_id  }">
		게시판 권한이 부족합니다.
	</c:when>
	<c:when test="${level_list eq 'admin' and session_id ne 'admin' }">
		게시판 권한이 부족합니다.
	</c:when>
	<c:otherwise>
		<div class="page-cont" align="center">

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
						<td><c:if test="${dto.getBdata_use_notice() eq 'Y' }">공지🔔</c:if><c:if test="${dto.getBdata_use_notice() ne 'Y' }">${dto.getBdata_no()}</c:if></td>
						<c:if test="${dto.getBdata_use_secret() eq 'Y' }">
							<td>🔒비밀글 입니다.</td>
						</c:if>
						<c:if test="${dto.getBdata_use_secret() eq 'N' or session_id eq 'admin'}">
							<td><a href="<%=request.getContextPath()%>/board/board_view.do?bbs_id=${dto.getBoard_id()}&bdata_no=${dto.getBdata_no()}&field=${field}&keyword=${keyword}&page=${paging.getPage()}">[${level}]회원 ${dto.getBdata_title()}</a>${file1}${file2}${file3}${file4}(${dto.getBdata_comment()})</td>
						</c:if>
						
						<td>${dto.getBdata_writer_name()}</td>
						<td>${dto.getBdata_date().substring(0,10)}</td>
						<td>${dto.getBdata_hit()}</td>
					
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
		    <form name="search_form" method="get" action="<%=request.getContextPath()%>/board/board_list.do">
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
				             	<a href="<%=request.getContextPath()%>/board/board_list.do?bbs_id=${boardConfig.getBoard_id()}" class="btn btn-outline-secondary"><i class="fa fa-list mr-1"></i> 게시물 전체목록</a>
				             </c:when>
				             <c:otherwise>
				             	<a href="<%=request.getContextPath()%>/board/board_write.do?bbs_id=${boardConfig.getBoard_id()}" class="btn btn-primary"  
				             	
				             	<c:if test="${boardConfig.getBoard_level_write() ne 'null' and empty session_id}"> 
				             	onclick="alert('권한이 없습니다.'); return false;" </c:if>
				             	<c:if test="${boardConfig.getBoard_level_write() eq 'admin' and session_id ne 'admin' }">
				             	onclick="alert('권한이 없습니다.'); return false;" </c:if>
				             	>
				             	<i class="fa fa-pencil mr-1"></i> 새로운 글쓰기</a>
				             </c:otherwise>
			             </c:choose>
				</div>	
		</div>	
	</c:otherwise>
</c:choose>



</div>


<%@ include file="../../layout/layout_footer.jsp" %>