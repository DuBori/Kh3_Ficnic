<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_ficnic.css" />
<script language="javascript" src="${path}/resources/site/js/js_ficnic.js"></script>



<div class="page-info w1100">
    <h2>${category_name}</h2>
    <ol>
        <li><a href="${path}/"><i class="icon-home"></i> HOME</a></li>
        <li>피크닉</li>
        <li><b>${category_name}</b></li>
    </ol>
</div>



<div class="contents w1100 goods-list">
<form action="" method="post">
<input type="hidden" value="${fdto.getFicnic_no()}"  name="ficnic_no" />
<input type="hidden" value="${fdto.getFicnic_name()}"  name="reserv_ficnic_name" />
<div class="ficnic-pay-main d-flex flex-column ">
	
	<div class="ficnic-pay-sub">
		<div>
			<p>프립정보</p>
			<div class="ficnic_pay_ficnicInfo d-flex flex-row justify-content-between">
				<div>
					<div class="mt-2 mb-2">
						<img src="${path}${fdto.getFicnic_photo1()}" width="112" height="112">
					</div>
					<div class="mt-3 mb-3">
						<div class="ficnic_pay_ficnicTitle">
							${fdto.getFicnic_name()}	
						</div>
						
						<div class="ficnic_pay_ficnicStarReview mt-2 mb-2">
							<img src="data:image/svg+xml,%3Csvg width='16' height='14' viewBox='0 0 16 14' fill='none' xmlns='http://www.w3.org/2000/svg'%3E %3Cpath d='M12.293 8.6189L15.7442 6.00968C16.2325 5.63914 15.9799 4.9135 15.3402 4.88263L10.8957 4.6356C10.6263 4.62016 10.3906 4.46577 10.2896 4.23418L8.65658 0.405277C8.42088 -0.135092 7.59595 -0.135092 7.36026 0.405277L5.72724 4.21874C5.62623 4.45033 5.39053 4.60472 5.12117 4.62016L0.659819 4.86719C0.0200779 4.89806 -0.232451 5.6237 0.255772 5.99424L3.707 8.58802C3.90903 8.74241 4.01004 9.00487 3.9427 9.23646L2.81473 13.2043C2.66322 13.7601 3.31979 14.2079 3.85852 13.8991L7.61279 11.6913C7.84848 11.5523 8.13468 11.5523 8.35354 11.6913L12.1246 13.8991C12.6634 14.2079 13.3199 13.7601 13.1684 13.2043L12.0405 9.2519C11.99 9.02031 12.0741 8.77329 12.293 8.6189Z' fill='%237A29FA'/%3E %3C/svg%3E" alt="별점 아이콘">
							<span class="ficnic_pay_ficnicStar">${fdto.getFicnic_review_point() }</span>
							<span class="ficnic_pay_ficnicReview">${fdto.getFicnic_review_count() }</span>
						</div>
					</div>
				</div>
				<div>
					<div>
						<p >옵션정보</p>
						<div>
							<p>호스트와 연락을 통해 날짜를 지정</p>
							<p>여 / 1개</p>
							</div>
						</div>
				</div>
			</div>
		</div>
		<hr class="Hr-sc-1533uvg-0 cbobBO">
		<div class="mt-2 mb-2">
			<p class="PageTitle__PurchasePageTitle-ex62ss-0 jcPaBR">결제수단</p>
			<div class="form-check mt-2 mb-2">
			  <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1" checked>
			  <label class="form-check-label " for="flexRadioDefault1">
			    신용/체크 카드
			  </label>
			</div>
			<div class="form-check mt-2 mb-2">
			  <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" data-bs-toggle="modal" data-bs-target="#exampleModal" >
			  <label class="form-check-label" for="flexRadioDefault2">
			    다른 결제수단
			  </label>
			</div>
			<div class="ficnic_pay_ficnicOtherpay">
			
			</div>
		</div>
		<hr class="Hr-sc-1533uvg-0 cbobBO">
		<div class="mt-2 mb-2">
			<p class="PageTitle__PurchasePageTitle-ex62ss-0 jcPaBR mt-2 mb-2">쿠폰</p>
			<div>
				<div>
					<p class="SubTitle-eeu9i7-0 gVXCTF mt-2 mb-2">프립 할인 쿠폰</p>
					<div class="d-flex flex-row justify-content-between ">
						<div class="Coupon__CouponCount-p6h1sc-1 cRGbZm"><span>전체 ${couponCount}장</span><span>, 사용가능 0장</span></div>
						<button class="InnerActionButton-io567l-0 cVMMHP">쿠폰 선택</button>
					</div>
					<hr class="Hr-sc-4qqq6q-0 bqjyoQ">
					<p class="SubTitle-eeu9i7-0 gVXCTF mt-2 mb-2">중복 할인 쿠폰</p>
					<div class="d-flex flex-row justify-content-between">
						<div class="Coupon__CouponCount-p6h1sc-1 cRGbZm">
							<span>전체 ${couponCount}장</span><span>, 사용가능 0장</span>
						</div>
						<button class="InnerActionButton-io567l-0 cVMMHP">쿠폰 선택</button>
					</div>
				</div>
			</div>
		</div>
		<hr class="Hr-sc-1533uvg-0 cbobBO">
		<div class="TotalPrice__PriceSectionWrapper-sc-1e1zxsm-0 jmdpIX">
			<div class="d-flex flex-row justify-content-between">
				<p class="PageTitle__PurchasePageTitle-ex62ss-0 TotalPrice__PriceSectionTitle-sc-1e1zxsm-1 jjsTId">총 결제금액</p>
				<span class="TotalPrice__TotalPriceText-sc-1e1zxsm-3 dxsibZ">20,000원</span>
			</div><hr>
			<div class="d-flex flex-row justify-content-between">
				<p class="SubTitle-eeu9i7-0 TotalPrice__PriceSectionSubTitle-sc-1e1zxsm-2 eHKVGS">총 프립 금액</p>
				<span>${totalprice }</span>
			</div>
			
		</div>
		<div class="bg-light d-flex flex-column">
			<div class="d-flex flex-row justify-content-between m-2">
				<p>개인정보 제 3자 제공 동의</p> <button type="button">보기</button>
			</div>
			<div class="d-flex flex-row justify-content-between m-2"> 
				<p>결제 대행 서비스 이용약관</p> <button type="button">보기</button>
			</div>
			
		</div>
		
		<div class="d-flex flex-column ">
			<strong class="mt-3 mb-3">이번 프립은 누구와 하시나요?</strong>
			<span class="mt-2 mb-2">다음번 크루님이 좋아할만한 프립을 추천해드릴게요.</span>
			<div class="form-check form-check-inline">
			  <input class="form-check-input" type="radio" id="inlineCheckbox1" value="single" name="reserv_with">
			  <label class="form-check-label mr-2" for="inlineCheckbox1">혼자</label>

			  <input class="form-check-input" type="radio" id="inlineCheckbox2" value="couple" name="reserv_with">
			  <label class="form-check-label mr-2" for="inlineCheckbox2">연인</label>
						
			  <input class="form-check-input" type="radio" id="inlineCheckbox3" value="friend" name="reserv_with">
			  <label class="form-check-label mr-2" for="inlineCheckbox3">친구</label>
			
			  <input class="form-check-input" type="radio" id="inlineCheckbox4" value="family" name="reserv_with">
			  <label class="form-check-label mr-2" for="inlineCheckbox4">가족</label>
			
			  <input class="form-check-input" type="radio" id="inlineCheckbox5" value="parent" name="reserv_with">
			  <label class="form-check-label mr-2" for="inlineCheckbox5">배우자</label>
			</div>
		</div>
		
		<div class="d-flex flex-row  justify-content-center mt-2 mb-2 ">
			<p>위 내용을 모두 확인하였으며, 결제에 동의합니다.<p>
		</div>
		
		</div>
		<div class="d-flex flex-row  justify-content-center mt-2 mb-2 w100">
			<input class="btn w-100 " type="button" value="참여하기" style=" background-color : rgb(122, 41, 250);">
		</div>
	
	</div>

<!-- Modal -->
<div class="modal fade center" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
		 <div class="form-check">
		  <input class="form-check-input" type="radio" name="ficnic_pay_flexRadioDefault2" id="flexRadioDefault3" checked data-bs-dismiss="modal" value="네이버페이">
		  <label class="form-check-label" for="flexRadioDefault1">
		    네이버 페이
		  </label>
		</div>
		<div class="form-check">
		  <input class="form-check-input" type="radio" name="ficnic_pay_flexRadioDefault2" id="flexRadioDefault4" data-bs-dismiss="modal" value="카카오페이">
		  <label class="form-check-label" for="flexRadioDefault2" >
		    카카오페이
		  </label>
		</div>
		<div class="form-check">
		  <input class="form-check-input" type="radio" name="ficnic_pay_flexRadioDefault2" id="flexRadioDefault5" data-bs-dismiss="modal" value="토스">
		  <label class="form-check-label" for="flexRadioDefault2">
		    토스
		  </label>
		</div>
      </div>
      
    </div>
   
  </div>
  
</div>

</form>
</div>







<%@ include file="../layout/layout_footer.jsp" %>