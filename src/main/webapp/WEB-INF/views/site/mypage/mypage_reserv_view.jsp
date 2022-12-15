<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_mypage.css" />
<script language="javascript" src="${path}/resources/site/js/js_mypage.js"></script>


<c:set var="mypage_eng" value="reserv" />
<c:set var="mypage_kor" value="피크닉 예약 정보" />


<%@ include file="../layout/layout_mymenu.jsp" %>


<c:set var="status" value="${reservDto.getReserv_status() }"/>
<c:set var="reserv_sess" value="${reservDto.getReserv_sess() }"/>
<c:set var="reserv_date" value="${reservDto.getReserv_date() }"/>
<c:set var="reserv_name" value="${reservDto.getReserv_name() }"/>
<c:set var="reserv_phone" value="${reservDto.getReserv_phone() }"/>
<c:set var="reserv_email" value="${reservDto.getReserv_email() }"/>
<c:set var="reserv_ficnic_name" value="${reservDto.getReserv_ficnic_name() }"/>

<div class="contents w1100 mypage-reserv">
	
	<div class="reserv-view">


    <!-- 내용 //START -->
    <div class="row rv-body">
        <div class="col-lg mb-5">
            <table class="table-form">
                <colgroup>
                    <col width="17%">
                    <col width="32%">
                    <col width="17%">
                    <col>
                </colgroup>

                <tbody>
                    <tr>
                        <th>상태</th>
                        <td colspan="3">
                            <span class="text-primary">
								<c:if test="${status eq 'reserv'}">신청대기</c:if>
								<c:if test="${status eq 'confirm'}">신청확인</c:if>
								<c:if test="${status eq 'done'}">체험완료</c:if>
								<c:if test="${status eq 'cancel'}">예약취소</c:if>
							</span>
                            
                        </td>
                    </tr>
                    <tr>
                        <th>예약번호</th>
                        <td class="eng">${reserv_sess}</td>
                        <th>예약일자</th>
                        <td class="eng">${reserv_date}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 내용 //END -->



    <!-- 예약자 정보 //START -->
    <div class="row rv-body">
        <div class="col-lg mb-5">
            <h4>예약자 정보</h4>

            <table class="table-form">
                <colgroup>
                    <col width="17%">
                    <col width="32%">
                    <col width="17%">
                    <col>
                </colgroup>

                <tbody>
                    <tr>
                        <th>이름</th>
                        <td colspan="3">${reserv_name }</td>
                    </tr>
                    <tr>
                        <th>전화번호</th>
                        <td class="eng">${reserv_phone }</td>
                        <th>이메일</th>
                        <td class="eng">${reserv_email}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 예약자 정보 //END -->



    <!-- 숙소 정보 //START -->
    <div class="row rv-body">
        <div class="col-lg mb-5">
            <h4>피크닉 정보</h4>

            <table class="table-form">
                <colgroup>
                    <col width="17%">
                    <col width="32%">
                    <col width="17%">
                    <col>
                </colgroup>

                <tbody>
                    <tr>
                        <th>피크닉 명</th>
                        <td colspan="3">${reserv_ficnic_name }</td>
                    </tr>
                    <tr>
                        <th>전화번호</th>
                        <td class="eng">0504-0904-2668</td>
                        <th>이메일</th>
                        <td class="eng">yowoo1003@naver.com</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 숙소 정보 //END -->

    <!-- 결제 정보 //START -->
    <div class="row rv-body">
        <div class="col-lg mb-5">
            <h4>결제 정보</h4>

            <table class="table-form">
                <colgroup>
                    <col width="17%">
                    <col>
                </colgroup>

                <tbody>
                    <tr>
                        <th>피크닉 금액</th>
                        <td colspan="3" class="d-flex">
                            <div class="text-black">피크닉 금액<br><b class="eng"><fmt:formatNumber value="${reservDto.getReserv_total_price()}"/></b>원</div>
                            <div class="pl-3 text-success">옵션 금액<br><b class="eng">+ 0</b>원</div>
                        </td>
                    </tr>
                    <tr>
                        <th>최종 결제 금액</th>
                        <td colspan="3" class="text-primary"><b class="eng" style="font-size: 16px;"><fmt:formatNumber value="${reservDto.getReserv_total_price()}"/></b>원</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 결제 정보 //END -->




    <!-- 버튼 //START -->
    <div class="rv-btn">
    	<button type="button" onclick="location.href='${path}/mypage/mypage_reserv_cancel.do?reserv_no=${reservDto.getReserv_no()}&reserv_sess=${reservDto.getReserv_sess() }'">예약취소</button>
    	<button type="button" onclick="location.href='${path}/mypage/mypage_reserv_list.do'">목록보기</button>
    </div>
    <!-- 버튼 //END -->
</div>
    

</div>



<%@ include file="../layout/layout_footer.jsp" %>