<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_mypage.css" />
<script language="javascript" src="${path}/resources/site/js/js_mypage.js"></script>


<c:set var="mypage_eng" value="reserv" />
<c:set var="mypage_kor" value="피크닉 예약 목록" />


<%@ include file="../layout/layout_mymenu.jsp" %>



<div class="contents w1100 mypage-reserv">

	<div class="row">
	        <div class="col-lg">
	            <div class="card border-0">
	                <div class="card-header bg-white border-0 pt-0 pl-0">총 <b class="text-primary"><fmt:formatNumber value="${totalCount}" /></b> 개의 예약</div>
	
	                <div class="card-body p-0">
	                    <table class="table-list mb-2 board-list">
	                        <thead>
	                            <tr>
	                                <th style="width: 80px;" class="table-list-hide">No.</th>
	                                <th style="width: 80px;" class="table-list-hide-mob">예약 번호</th>
	                                <th>피크닉 예약 내용</th>
	                                <th style="width: 120px;">최종 결제금액</th>
	                                <th style="width: 120px;">예약 일자</th>
	                                <th style="width: 80px;" class="table-list-hide-mob">예약 상태</th>
	                            </tr>
	                        </thead>
	
	                        <tbody>
	                            <c:choose>
	                                <c:when test="${!empty List}">
	                                <c:forEach var="dto" items="${List}">
	                                <tr onclick="location.href='#';">
	                                    <td class="text-center eng table-list-hide">
	                                        <c:choose>
	                                            <c:when test="${dto.getBdata_use_notice() eq 'Y'}">🔔공지</c:when>
	                                            <c:otherwise>${dto.getBdata_no()}</c:otherwise>
	                                        </c:choose>
	                                    </td>
	                                    <td class="text-left pl-3 subject">
	                                    </td>
	                                    <td class="text-center table-list-hide-mob">${dto.getBdata_writer_name()}</td>
	                                    <td class="text-center eng">${dto.getBdata_date().substring(0,10)}</td>
	                                    <td class="text-center eng table-list-hide-mob"><fmt:formatNumber value="${dto.getBdata_hit()}" /></td>
	                                </tr>
	                                </c:forEach>
	                                </c:when>
	
	                                <c:otherwise>
	                                <tr>
	                                    <td colspan="5" class="nodata">No Data</td>
	                                </tr>
	                                </c:otherwise>
	                            </c:choose>
	                        </tbody>
	                    </table>
	                </div>
	            </div>
	        </div>
	    </div>
	
	
	
	    <div class="row mt-2 list-bottom-util">
	        <div class="col-md-4 mt-3">
	            <form name="search_form" method="get" action="${path}">
	            <input type="hidden" name="b_id" value="<?=$b_id?>" />
	            <input type="hidden" name="ps_page" value="1" />
	            <div class="input-group list-search-form w-80">
	                <select name="ps_search" class="custom-select col-sm-4">
	                    <option value="subject">제목</option>
	                    <option value="body">내용</option>
	                    <option value="writer">작성자</option>
	                </select>
	                <input type="text" name="ps_keyword" value="" class="form-control rounded-right" />
	                <button type="submit" class="btn btn-secondary ml-1"><i class="icon-magnifier"></i> 검색</button>
	            </div>
	            </form>
	        </div>
	
	        <div class="col-md-4 text-center mt-3">
	            ${pagingWrite}
	        </div>
	
	        <div class="col-md-4 text-right mt-3">
	                         <c:choose>
	                             <c:when test="${!empty field}">
	                                <a href="<%=request.getContextPath()%>/board/board_list.do?bbs_id=${boardConfig.getBoard_id()}" class="btn btn-outline-secondary"><i class="fa fa-list mr-1"></i> 게시물 전체목록</a>
	                             </c:when>
	                             <c:otherwise>
	                                <a href="<%=request.getContextPath()%>/board/board_write.do?bbs_id=${boardConfig.getBoard_id()}" class="btn btn-primary"  
	                                
	                                <c:if test="${boardConfig.getBoard_level_write() ne 'null' and empty sess_id}"> 
	                                onclick="alert('권한이 없습니다.'); return false;" </c:if>
	                                <c:if test="${boardConfig.getBoard_level_write() eq 'admin' and sess_id ne 'admin' }">
	                                onclick="alert('권한이 없습니다.'); return false;" </c:if>
	                                >
	                                <i class="fa fa-pencil mr-1"></i> 새로운 글쓰기</a>
	                             </c:otherwise>
	                         </c:choose>
	
	            <a href="board_write.php?b_id=<?=$b_id?>" class="btn btn-primary"><i class="icon-pencil mr-1"></i> 새로운 글쓰기</a>
	        </div>
	    </div>
   


</div>



<%@ include file="../layout/layout_footer.jsp" %>