<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="dto" value="${dto}" />
<c:set var="cdto" value="${cdto}" />
<c:set var="pdto" value="${pdto}" />

<%@ include file="../layout/layout_header.jsp" %>


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

    <!-- 회원 정보 //START -->
        <table class="table table-bordered">
            <c:if test="${!empty dto}">
            <tr>
                <th>회원 유형</th>
                <td align="left">
                ${dto.getMember_type()}
                </td>
            </tr>
            <tr>
                <th>아이디</th>
                <td align="left">${dto.getMember_id()}</td>
            </tr>
            <tr>
                <th>이름</th>
                <td align="left">${dto.getMember_name()}</td>
            </tr>
            <tr>
                <th>이메일</th>
                <td align="left">${dto.getMember_email()}</td>
            </tr>
            <tr>
                <th>연락처</th>
                <td align="left">${dto.getMember_phone()}</td>
            </tr>
            <tr>
                <th>적립금</th>
                <td align="left"><fmt:formatNumber value="${dto.getMember_point()}" /></td>
            </tr>
            <tr>
                <th>가입일자</th>
                <td align="left">${dto.getMember_joindate().substring(0, 10)}</td>
            </tr>
		    
            </c:if>

            <c:if test="${empty dto}">
            <tr>
                <td colspan="2" align="center">
                    <h3>검색된 회원의 정보가 없습니다.</h3>
                </td>
            </tr>
            </c:if>
        </table>
	<!-- 회원 정보 //END -->   
 
 
    <!-- 쿠폰 정보 //START -->
         <table class="table table-striped border-top align-middle">
            <colgroup>
                <col width="10%" />
                <col width="10%" />
                <col width="17%" />
                <col />
                <col width="17%" />
                <col width="10%" />
                <col width="15%" />
            </colgroup>

            <thead>
                <tr>
                    <th>No.</th>
                    <th>쿠폰 이름</th>
                    <th>사용여부/사용날짜</th>
                    <th>사용 가능 기간</th>
                    <th>쿠폰 금액</th>
                    <th>링크</th>
                    <th>쿠폰 발급 일자</th>
                </tr>
            </thead>

            <tbody>
                <c:set var="cdto" value="${cdto}" />
                <c:if test="${!empty cdto}">
                <c:forEach items="${cdto}" var="cdto">
                <tr>
                    <td>${cdto.getCoupon_no()}</td>
                    <td>${cdto.getCoupon_name()}</td>
                    <td>
                    <c:choose>
	                    <c:when test="${cdto.getMcoupon_use_date() == null}"><span class="text-primary">미사용</span></c:when>
	                    <c:otherwise><span class="text-danger">사용</span><br>${cdto.getMcoupon_use_date().substring(0,10)}</c:otherwise>
                    </c:choose>
                    </td>
                    <td>${cdto.getMcoupon_start_date().substring(0,10)}~${cdto.getMcoupon_end_date().substring(0,10)}</td>
                    <td><fmt:formatNumber value="${cdto.getMcoupon_use_price()}" /></td>
                    <td>                    
	                    <a href="<%= request.getContextPath() %>/admin/reserv/reserv_list.do?search_ficnic=&search_review=&search_writer=${cdto.getReserv_sess()}">${cdto.getReserv_sess()}</a>
                    </td>
                    <td>${cdto.getMcoupon_date().substring(0,10)}</td>
                </tr>
                </c:forEach>
                </c:if>

                <c:if test="${empty cdto}">
                <tr>
                    <td colspan="6">
                        <h3 class="my-5">쿠폰 목록이 없습니다.</h3>
                    </td>
                </tr>
                            
                </c:if>
            </tbody>
        </table>
    <!-- 쿠폰 정보 //END -->


    <!-- 적립금 정보 //START -->
         <table class="table table-striped border-top align-middle">
            <colgroup>
                <col width="10%" />
                <col width="10%" />
                <col width="15%" />
                <col />
                <col width="15%" />
                <col width="20%" />
            </colgroup>

            <thead>
                <tr>
                    <th>No.</th>
                    <th>구분</th>
                    <th>적립금 금액</th>
                    <th>적립 이유</th>
                    <th>링크</th>
                    <th>적립 일자</th>
                </tr>
            </thead>

            <tbody>
                <c:set var="pdto" value="${pdto}" />
                <c:if test="${!empty pdto}">
                <c:forEach items="${pdto}" var="pdto">
                <tr>
                    <td>${pdto.getPoint_no()}</td>
                    <td>
                    <c:choose>
	                    <c:when test="${pdto.getPoint_kind() == 'join'}">회원가입</c:when>
	                    <c:when test="${pdto.getPoint_kind() == 'review'}">리뷰</c:when>
	                    <c:when test="${pdto.getPoint_kind() == 'admin'}">관리자</c:when>
	                    <c:when test="${pdto.getPoint_kind() == 'reserv'}">예약하기</c:when>
                    </c:choose>
                    </td>
                    <td>
                    <c:choose>
	                    <c:when test="${pdto.getPoint_type() == 'plus'}"><span class="text-primary">+ <fmt:formatNumber value="${pdto.getPoint_add()}" /></span></c:when>
	                    <c:when test="${pdto.getPoint_kind() == 'minus'}"><span class="text-danger">- <fmt:formatNumber value="${pdto.getPoint_add()}" /></span></c:when>
                    </c:choose>
                    </td>
                    <td>${pdto.getPoint_reason()}</td>
                    <td>
                    <c:choose>
	                    <c:when test="${pdto.getPoint_kind() == 'review'}"><a href="<%= request.getContextPath() %>/admin/review/review_list.do?search_ficnic=&search_review=&search_writer=${pdto.getMember_id()}">${pdto.getMember_id()}</a></c:when>
	                    <c:when test="${pdto.getPoint_kind() == 'reserv'}"><a href="<%= request.getContextPath() %>/admin/reserv/reserv_list.do?search_ficnic=&search_review=&search_writer=${pdto.getMember_id()}">${pdto.getMember_id()}</a></c:when>
                    	<c:otherwise></c:otherwise>
                    </c:choose>
                    </td>
                    <td>${pdto.getPoint_date().substring(0,10)}</td>
                </tr>
                </c:forEach>
                </c:if>

                <c:if test="${empty pdto}">
                <tr>
                    <td colspan="6">
                        <h3 class="my-5">포인트 목록이 없습니다.</h3>
                    </td>
                </tr>
            
	            <!-- 버튼 //START -->
			    <tr>
			    	<td colspan="2">
				        <button type="button" class="btn btn-outline-secondary"><i class="fa fa-print"></i> 인쇄하기</button>
				        <button type="button" class="btn btn-secondary ml-2"><i class="fa fa-times"></i> 창닫기</button>
			    	</td>
			    </tr>
			    <!-- 버튼 //END -->
                
                </c:if>
            </tbody>
        </table>
    <!-- 적립금 정보 //END -->
    
     
</div>


<%@ include file="../layout/layout_footer.jsp" %>