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
            
            <!-- 버튼 //START -->
		    <tr>
		    	<td colspan="2">
			        <button type="button" class="btn btn-outline-secondary"><i class="fa fa-print"></i> 인쇄하기</button>
			        <button type="button" class="btn btn-secondary ml-2"><i class="fa fa-times"></i> 창닫기</button>
		    	</td>
		    </tr>
		    <!-- 버튼 //END -->
		    
            </c:if>

            <c:if test="${empty dto}">
            <tr>
                <td colspan="2" align="center">
                    <h3>검색된 회원의 정보가 없습니다.</h3>
                </td>
            </tr>
            </c:if>
        </table>
        
    <!-- 쿠폰 정보 //START -->
    <div class="row vf-body">
        <div class="col-lg mb-4">
            <h4>쿠폰 정보</h4>

            <table class="table-form w-100">
            <c:if test="${!empty cdto}">
            <c:forEach items="${cdto}" var="cdto">
                <colgroup>
                    <col width="17%" />
                    <col width="32%" />
                    <col width="17%" />
                    <col />
                </colgroup>

                <tbody>
                    <tr>
                        <th>쿠폰번호</th>
                        <td class="eng">${cdto.coupon_no}</td>
                    </tr>
                    <tr>
                        <th>예약번호</th>
                        <td class="eng">${cdto.reserv_sess}</td>
                    </tr>
                    <tr>
                    	<th>쿠폰 사용 금액</th>
                    	<td colspan="3">${cdto.mcoupon_use_price }</td>
                    </tr>
                    
                    <tr>
                    	<th>사용 시작 기간</th>
                    	<td colspan="3">${cdto.mcoupon_start_date.substring(0,10) }</td>
                    </tr>
                    
                    <tr>
                    	<th>사용 종료 기간</th>
                    	<td colspan="3">${cdto.mcoupon_end_date.substring(0,10) }</td>
                    </tr>
                    
                    <tr>
                    	<th>쿠폰 사용 일자</th>
                    	<td colspan="3">${cdto.mcoupon_use_date.substring(0,10) }</td>
                    </tr>
                    
                    <tr>
                    	<th>쿠폰 발급 일자</th>
                    	<td colspan="3">${cdto.mcoupon_date.substring(0,10) }</td>
                    </tr>
                    
                </tbody>
                </c:forEach>
               </c:if> 
            </table>
        </div>
    </div>
    <!-- 쿠폰 정보 //END -->
 
    <!-- 적립금 정보 //START -->
    <div class="row vf-body">
        <div class="col-lg mb-4">
            <h4>적립금 정보</h4>

            <table class="table-form w-100">
            <c:if test="${!empty pdto}">
            <c:forEach items="${pdto}" var="pdto">
                <colgroup>
                    <col width="17%" />
                    <col width="32%" />
                    <col width="17%" />
                    <col />
                </colgroup>

                <tbody>
                    <tr>
                        <th>예약 번호</th>
                        <td class="eng">${pdto.reserv_sess}</td>
                    </tr>
                    <tr>
                        <th>리뷰 번호</th>
                        <td class="eng">${pdto.review_no}</td>
                    </tr>
                    <tr>
                    	<th>적립금 구분</th>
                    	<td colspan="3">${pdto.point_type }</td>
                    </tr>
                    
                    <tr>
                    	<th>적립금 금액</th>
                    	<td colspan="3">${pdto.point_add}</td>
                    </tr>
                    
                    <tr>
                    	<th>적립 이유</th>
                    	<td colspan="3">${pdto.point_reason}</td>
                    </tr>
                    
                    <tr>
                    	<th>적립 일자</th>
                    	<td colspan="3">${pdto.point_date.substring(0,10) }</td>
                    </tr>
                    
                </tbody>
                </c:forEach>
               </c:if> 
            </table>
        </div>
    </div>
    <!-- 쿠폰 정보 //END -->
    
     
</div>


<%@ include file="../layout/layout_footer.jsp" %>