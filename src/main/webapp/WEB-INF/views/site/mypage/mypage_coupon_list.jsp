<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_mypage.css" />
<script language="javascript" src="${path}/resources/site/js/js_mypage.js"></script>


<c:set var="mypage_eng" value="coupon" />
<c:set var="mypage_kor" value="쿠폰 보관함" />


<%@ include file="../layout/layout_mymenu.jsp" %>



<div class="contents w1100 mypage-coupon">

<div class="row">
        <div class="col-lg">
            <div class="card border-0">

                <div class="card-body p-0">
                    <table class="table-list mb-2 board-list">
                        <thead>
                            <tr>
                                <th>쿠폰 이름</th>
                                <th style="width: 80px;" class="table-list-hide-mob">발급 일자</th>
                                <th style="width: 120px;">쿠폰 유효기간</th> 
                            </tr>
                        </thead>

                        <tbody>
                            <c:choose>
                                <c:when test="${!empty List}">
                                <c:forEach var="dto" items="${List}">
                                <tr>
                                	<c:forEach items="${dto.getCoupon_list() }" var="cdto">
                                		<c:if test="${dto.getMcoupon_no() eq cdto.getCoupon_no() }">
                                			<td class="text-center eng table-list-mob">${cdto.getCoupon_name()}</td>
                                		</c:if>
                                	</c:forEach>
                                    <td class="text-center eng table-list-mob">${dto.getMcoupon_date().substring(0,10)}</td>
                                    <td class="text-center eng table-list-mob">${dto.getMcoupon_end_date().substring(0,10)}</td>
                                </tr>
                                </c:forEach>
                                </c:when>

                                <c:otherwise>
                                <tr>
                                    <td colspan="3" class="nodata">쿠폰 내역이 없습니다.</td>
                                </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</div>



<%@ include file="../layout/layout_footer.jsp" %>