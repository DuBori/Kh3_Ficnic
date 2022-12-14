<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="layout_none" value="Y" />
<%@ include file="../layout/layout_header.jsp" %>

<c:if test="${empty dto}"><script type="text/javascript">alert('존재하지 않는 데이터입니다.'); window.close();</script></c:if>


<h2>예약 상세 정보 보기</h2>


<div class="page-cont">
    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <div class="row form">
                        <div class="form-group col d-flex align-items-center mb-2">
                            <label>상태</label>
                            <div class="px-3">
                                <c:choose>
                                <c:when test="${dto.getReserv_status() eq 'reserv'}">신청</c:when>
                                <c:when test="${dto.getReserv_status() eq 'confirm'}">예약확정</c:when>
                                <c:when test="${dto.getReserv_status() eq 'done'}">체험완료</c:when>
                                <c:otherwise>예약취소</c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="w-100 border-bottom"></div>

                        <div class="form-group col d-flex align-items-center">
                            <label>예약번호</label>
                            <div class="px-3 engnum">${dto.getReserv_sess()}</div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group col d-flex align-items-center">
                            <label>예약일자</label>
                            <div class="px-3">${dto.getReserv_date()}</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



	<!-- 회원정보 시작  -->
    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>예약자 정보</h4>
                    <div class="row form">
                        <div class="form-group col d-flex align-items-center">
                            <label>이름</label>
                            <div class="px-3 engnum">${mdto.getMember_name()}</div>
                        </div>
                        <div class="form-group col d-flex align-items-center">
                            <label>전화번호</label>
                            <div class="px-3 engnum">${mdto.getMember_phone()}</div>
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col d-flex align-items-center">
                            <label>이메일</label>
                            <div class="px-3">${mdto.getMember_email()}</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!-- 회원정보 끝  -->



	<!-- 상품 정보 시작 -->
    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>상품 정보</h4>
                    <div class="row form">
                        <div class="form-group col d-flex align-items-center">
                            <label>상품</label>
                            <div class="px-3 engnum"><b>${dto.getReserv_ficnic_name() }</b><br />-${dto.getReserv_ficnic_option_title() }</div>
                        </div>
                        <c:if test="${dto.getReserv_ficnic_date() != null}">
                        <div class="w-100 border-bottom"></div>
                        <div class="form-group col d-flex align-items-center">
                            <label>상품기간</label>
                            <div class="px-3 engnum">${dto.getReserv_ficnic_date()}</div>
                        </div> 
                        <div class="w-100"></div>
                        </c:if>
                        <div class="form-group col d-flex align-items-center">
                            <label>태그</label>
                            <div class="px-3">
                                <c:choose>
                                <c:when test="${dto.getReserv_with() eq 'single'}">혼자</c:when>
                                <c:when test="${dto.getReserv_with() eq 'couple'}">연인</c:when>
                                <c:when test="${dto.getReserv_with() eq 'friend'}">친구</c:when>
                                <c:when test="${dto.getReserv_with() eq 'family'}">가족</c:when>
                                <c:otherwise>배우자</c:otherwise>
                                </c:choose>                             
                            </div>
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col d-flex align-items-center">
                            <label>결제수단</label>
                            <div class="px-3">
                                <c:choose>
                                <c:when test="${dto.getReserv_payment() eq 'naver'}">네이버페이</c:when>
                                <c:when test="${dto.getReserv_payment() eq 'kakao'}">카카오페이</c:when>
                                <c:when test="${dto.getReserv_payment() eq 'nobankbook'}">무통장 입금</c:when>
                                <c:when test="${dto.getReserv_payment() eq 'toss'}">실시간 계좌이체</c:when>
                                <c:otherwise>카드결제</c:otherwise>
                                </c:choose>                            
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!-- 상품 정보 끝 -->



	<!-- 결제 정보 시작 -->
    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>결제 정보</h4>
                    <div class="row form">
                        <div class="form-group col d-flex align-items-center">
                            <label>상품 금액</label>
                            <div class="px-3 engnum">
                            <div class="text-black">상품 금액<br /><b class="eng"><fmt:formatNumber value="${dto.getReserv_ficnic_sale_price()}" /></b>원</div>
                            <div class="pl-3 text-success">옵션 금액<br /><b class="eng">+ <fmt:formatNumber value="${dto.getReserv_ficnic_option_price()}" /></b>원</div>                            
                            </div>
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col d-flex align-items-center">
                            <label>최종 결제 금액</label>
                            <div class="px-3 text-primary"> <fmt:formatNumber value="${dto.getReserv_total_price() }"></fmt:formatNumber>원</div>
                        </div>                        
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!-- 결제 정보 끝 -->	
	
</div>



<div class="my-2 text-center">
    <button type="button" class="btn btn-outline-secondary" onclick="window.print();"><i class="fa fa-print"></i> 인쇄하기</button>
    <button type="button" class="btn btn-secondary ml-2" onclick="window.close();"><i class="fa fa-times"></i> 창닫기</button>
</div>



<%@ include file="../layout/layout_footer.jsp" %>