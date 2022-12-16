<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_mypage.css" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=05baaf0de0478dc909d89f4fbc30dcd1&libraries=services,clusterer,drawing&autoload=false" defer="defer" ></script>
<script language="javascript" src="${path}/resources/site/js/js_mypage.js" defer="defer"></script>


<c:set var="mypage_eng" value="reserv" />
<c:set var="mypage_kor" value="피크닉 예약 정보" />


<jsp:useBean id="currentDay" class="java.util.Date" />
<fmt:formatDate value="${currentDay}" pattern="yyyy-MM-dd HH:mm:ss" var="today" />

<%@ include file="../layout/layout_mymenu.jsp" %>


<c:set var="status" value="${reservDto.getReserv_status() }"/>
<c:set var="reserv_sess" value="${reservDto.getReserv_sess() }"/>
<c:set var="reserv_date" value="${reservDto.getReserv_date() }"/>
<c:set var="reserv_name" value="${reservDto.getReserv_name() }"/>
<c:set var="reserv_phone" value="${reservDto.getReserv_phone() }"/>
<c:set var="reserv_email" value="${reservDto.getReserv_email() }"/>
<c:set var="reserv_ficnic_name" value="${reservDto.getReserv_ficnic_name() }"/>
<c:set var="reserv_ficnic_img" value="${reservDto.getReserv_ficnic_photo() }"/>

<div class="contents w1100 mypage-reserv">
	
	<div class="mypage-reserv-view d-flex flex-column  border">


    <!-- 내용 //START -->
    <div>
    	<h4 class="mypage-reserv-h">피크닉 신청 내용</h4>
        <div>
            <table class="table">
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
                        <td>${reserv_sess}</td>
                        <th>예약일자</th>
                        <td>${reserv_date}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 내용 //END -->



    <!-- 예약자 정보 //START -->
    <div>
        <div >
            <h4 class="mypage-reserv-h">예약자 정보</h4>

            <table class="table">
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
                        <td>${reserv_phone }</td>
                        <th>이메일</th>
                        <td>${reserv_email}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 예약자 정보 //END -->



    <!-- 숙소 정보 //START -->
    <div>
    	<h4 class="mypage-reserv-h">피크닉 정보</h4>
        <div class="d-flex flex-row m-3 p-2 justify-content-center">
            <div>
            	<img alt="" src="${path}/${reserv_ficnic_img}" class="img-fluid">
            </div>
            <table class="table">
                <colgroup>
                    <col width="17%">
                    <col width="32%">
                    <col width="17%">
                    <col>
                </colgroup>

                <tbody>
                    <tr>
                        <th>피크닉 명</th>
                        <td colspan="3">${ficnicDto.getFicnic_name() }</td>
                    </tr>
                    <tr>
                        <th>진행 장소</th>
                        <td colspan="3" id="ficnic_addr">${ficnicDto.getFicnic_address()}</td>
                    </tr>
                    <tr>
                    <tr>
                    	<td colspan="4">
                    		<div id="map" style="height:320px;">
	                        </div>
                    	</td>
                    </tr>                   
                </tbody>
            </table>
        </div>
    </div>
    <!-- 숙소 정보 //END -->

    <!-- 결제 정보 //START -->
    <div>
        <div>
            <h4 class="mypage-reserv-h">결제 정보</h4>
            <table class="table">
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
    <div class="d-flex p-1  m-3 justify-content-center">
    	<c:if test="${today < reserv_date}">
    		<button type="button" class="btn btn-outline-primary" onclick="if(confirm('정말로 취소하시겠습니까?\n돌이키실 수 없습니다.')){ location.href='${path}/mypage/mypage_reserv_cancel.do?reserv_no=${reservDto.getReserv_no()}&reserv_sess=${reservDto.getReserv_sess()}'; }else{ return false; }">예약취소</button>
    	</c:if>
    	
    	<button type="button" class="btn btn-outline-primary" onclick="location.href='${path}/mypage/mypage_reserv_list.do'">목록보기</button>
    </div>
    <!-- 버튼 //END -->
</div>
    

</div>



<%@ include file="../layout/layout_footer.jsp" %>