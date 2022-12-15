<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_mypage.css" />
<script language="javascript" src="${path}/resources/site/js/js_mypage.js"></script>


<c:set var="mypage_eng" value="coupon" />
<c:set var="mypage_kor" value="쿠폰 보관함" />


<%@ include file="../layout/layout_mymenu.jsp" %>



<div class="contents w1100 mypage-reserv">


    <div class="Coupon__Wrapper-n6zr15-0 FFiuI">
    <div class="Coupon__ContentWrapper-n6zr15-1 iIvPMk">
    <div class="Coupon__Description-n6zr15-3 jrcnBs">
    <div class="Coupon__PriceWithExpireWrapper-n6zr15-4 bKHklM">
    <div class="Coupon__DiscountPrice-n6zr15-5 gBYRSu">10,000원</div>
    <div class="Coupon__ExpireDate-n6zr15-6 buKVoG">2022-12-22 만료</div>
    </div><div class="Coupon__TitleWrapper-n6zr15-7 cVVClH">
    <div class="Coupon__Title-n6zr15-8 eiBzGd">신규 가입 축하 | 상품 등록 대행 서비스 1만원 할인 쿠폰</div></div></div>
    <div class="Coupon__ConditionsContainer-n6zr15-9 hGeOCx"><div class="Coupon__Condition-n6zr15-10 iwqtMd"></div>
    <div class="Coupon__Condition-n6zr15-10 iwqtMd">0원 이상 프립에 사용 가능</div></div></div>
    <div class="Coupon__CutoutWrapper-n6zr15-2 epiIba"></div></div>


</div>



<%@ include file="../layout/layout_footer.jsp" %>