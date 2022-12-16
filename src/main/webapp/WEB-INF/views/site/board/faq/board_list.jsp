<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../layout/layout_header.jsp" %>
<c:if test="${level.list ne 'Y'}"><script>alert('게시물 목록 접근 권한이 없습니다.'); history.back();</script></c:if>


<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_board.css" />
<script language="javascript" src="${path}/resources/site/js/js_board.js"></script>


<%@ include file="../../layout/layout_csmenu.jsp" %>



<div class="contents w1100 board-list board-faq">

    <div class="row">
        <div class="col-lg">
            <div class="card border-0">
                <div class="card-header bg-white border-0 p-0">


                    <c:if test="${conf.getBoard_use_category() eq 'Y' and !empty BoardCate}">
                    <ul class="bf-category">
                        <li<c:if test="${empty category}"> class="now"</c:if>><a href="board_list.do?bbs_id=${param.bbs_id}">전체보기</a></li>
                        <c:forEach var="cateList" items="${BoardCate}">
                        <li<c:if test="${category eq cateList.getBcate_no()}"> class="now"</c:if>><a href="board_list.do?bbs_id=${param.bbs_id}&category=${cateList.getBcate_no()}">${cateList.getBcate_name()}</a></li>
                        </c:forEach>
                    </ul>
                    </c:if>
                </div>

                <div class="card-body p-0">
                    <ul class="bf-list">
                        <c:choose>
                            <c:when test="${!empty List}">
                                <c:forEach var="dto" items="${List}">
                                <c:set var="result_title" value="<span class=\"search\">${keyword}</span>"></c:set>
                                <li>
                                    <c:choose><c:when test="${field eq 'title' and keyword != ''}">${dto.getBdata_title().replace(keyword, result_title)}</c:when><c:otherwise>${dto.getBdata_title()}</c:otherwise></c:choose>
                                </li>
                                </c:forEach>
                            </c:when>

                            <c:otherwise>
                                <li class="nodata">No Data</li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </div>
    </div>



    <div class="row mt-4 list-bottom-util">
        <div class="col-md-4 text-left">
            <form name="search_form" method="get" action="${path}/board/board_list.do">
            <input type="hidden" name="bbs_id" value="${param.bbs_id}" />
            <input type="hidden" name="category" value="${param.category}" />
            <div class="input-group list-search-form w-80">
                <select name="field" class="custom-select col-sm-4">
                   <option value="title"<c:if test="${field eq 'title'}"> selected="selected"</c:if>>제목</option>
                   <option value="cont"<c:if test="${field eq 'cont'}"> selected="selected"</c:if>>내용</option>
                   <option value="writer"<c:if test="${field eq 'writer'}"> selected="selected"</c:if>>작성자</option>
                </select>
                <input type="text" name="keyword" value="${keyword}" class="form-control rounded-right" />
                <button type="submit" class="btn btn-secondary ml-1"><i class="icon-magnifier"></i> 검색</button>
            </div>
            </form>
        </div>

        <div class="col-md-4 text-center">
            ${pagingWrite}
        </div>

        <div class="col-md-4 text-right">
            <c:if test="${level.write eq 'Y'}"><a href="${path}/board/board_write.do?bbs_id=${conf.getBoard_id()}" class="btn btn-primary"><i class="fa fa-pencil mr-1"></i> 글쓰기</a></c:if>
        </div>
    </div>

</div>


<%@ include file="../../layout/layout_footer.jsp" %>