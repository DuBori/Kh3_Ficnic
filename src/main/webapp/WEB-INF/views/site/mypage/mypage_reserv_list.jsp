<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_mypage.css" />
<script language="javascript" src="${path}/resources/site/js/js_mypage.js"></script>




<c:set var="mypage_eng" value="reserv" />
<c:set var="mypage_kor" value="피크닉 예약 목록" />
<jsp:useBean id="currentDay" class="java.util.Date" />
<fmt:formatDate value="${currentDay}" pattern="yyyy-MM-dd HH:mm:ss" var="today" />

<%@ include file="../layout/layout_mymenu.jsp" %>



<div class="contents w1100 mypage-reserv">

	<div>
		<ul class="mypage-reserv d-flex flex-row">
			<li class="btn btn-outline-light m-2 <c:if test="${getType == 'reserv'}">now</c:if>"><a href="<%=request.getContextPath()%>/mypage/mypage_reserv_list.do?getType=reserv">체험 신청</a></li>
			<li class="btn btn-outline-light m-2 <c:if test="${getType == 'confirm'}">now</c:if>"><a href="<%=request.getContextPath()%>/mypage/mypage_reserv_list.do?getType=confirm">예약 확정</a></li>
			<li class="btn btn-outline-light m-2 <c:if test="${getType == 'done'}">now</c:if>"><a href="<%=request.getContextPath()%>/mypage/mypage_reserv_list.do?getType=done">체험 완료</a></li>
			<li class="btn btn-outline-light m-2 <c:if test="${getType == 'cancel'}">now</c:if>"><a href="<%=request.getContextPath()%>/mypage/mypage_reserv_list.do?getType=cancel">예약 취소</a></li>
		</ul>
	</div>
	
	<div class="mypage-reserv-mainDiv d-flex flex-column w1000 border">
		<!-- 예약 리스트 출력  -->
		<div class="mypage-reserv-subDiv d-flex flex-row flex-wrap justify-content-center border">
			<c:choose>
				<c:when test="${!empty List }">
				<c:forEach items="${List}" var="dto">
					<c:if test="${getType eq dto.getReserv_status() or empty getType }">
		    			<c:set var="move_ficnic_info" value="onclick=\"location.href='${path}/ficnic/ficnic_view.do?ficnic_no=${dto.getFicnic_no()}'\""/>
		    			<div class="mypage-wish card w-20 m-1 p-1 d-flex flex-column border justify-content-center align-items-center ">
							  <img ${move_ficnic_info } src="${path }${dto.getReserv_ficnic_photo()}" class="card-img-top" style="width:200px" alt="...">
							  <div ${move_ficnic_info } class="mypage-wish card-body">
							    <p class="card-location">지역</p>
							    <h5 class="card-text card-title">${dto.getReserv_ficnic_name() }</h5>
							  </div>
							  <ul ${move_ficnic_info } class="mypage-wish">
							    <li class="card-text"> 예약 날짜 :${dto.getReserv_date().substring(0,10)}</li>
							    <li class="card-text"><fmt:formatNumber value="${dto.getReserv_total_price()}"/>원</li>
							  </ul>
							  <div class="mypage-wish card-body">
							    <c:if test="${dto.getReserv_status() ne 'cancel'}"> <a href="${path}/mypage/mypage_reserv_view.do?reserv_no=${dto.getReserv_no()}" class="card-link card-text">상세내역 보기</a></c:if>
							    <c:if test="${dto.getReserv_date() < today and dto.getReserv_status() eq 'done'}"> <a class="btn-open-popup card-link card-text" data-bs-toggle="modal" data-bs-target="#exampleModal" data-name="${dto.getReserv_ficnic_name()}">리뷰 작성하기</a></c:if>
							    <c:if test="${dto.getReserv_status() eq 'cancel'}"> <a href="#" class="card-link card-text">예약취소</a></c:if>
							  </div>
						</div>	
					</c:if>
					</c:forEach>
				</c:when>
				<c:otherwise>
						<div class="w-20 m-1 p-1 d-flex flex-column align-items-center">
							<img src="data:image/svg+xml,%3Csvg width='56' height='56' fill='none' xmlns='http://www.w3.org/2000/svg'%3E %3Cpath d='M38 16H22M38 23H22M38 30H22M38 37H22' stroke='%23777' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/%3E %3Crect x='8' y='5' width='39' height='44' rx='4' stroke='%23777' stroke-width='2'/%3E %3Ccircle cx='16.5' cy='16' r='1.5' fill='%23777'/%3E %3Ccircle cx='16.5' cy='23' r='1.5' fill='%23777'/%3E %3Ccircle cx='16.5' cy='30' r='1.5' fill='%23777'/%3E %3Ccircle cx='16.5' cy='37' r='1.5' fill='%23777'/%3E %3Ccircle cx='42' cy='43' r='11' fill='%23fff' stroke='%23fff' stroke-width='2'/%3E %3Ccircle cx='42' cy='43' r='9' fill='%23fff' stroke='%23777' stroke-width='2'/%3E %3Cpath d='m39 46 6-6M45 46l-6-6' stroke='%23777' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/%3E %3C/svg%3E" alt="아직 결제내역이 없어요!" width="56px" height="56px">
							<div class="Placeholder__Title-von7t2-1 dqGjWH">
								아직 결제내역이 없어요!
							</div>
							<div class="Placeholder__SubTitle-von7t2-2 gSjDbY">
								지금 바로 피크닉을 시작해보세요.
							</div>
						</div>
				</c:otherwise>	
    		
    		</c:choose>
		</div>
		      	<!-- 페이징 처리  -->
		<c:if test="${!empty paging}">
	        <div class="row list-bottom-util">
	            	<div class="col text-center">
	                    ${pagingWrite}
	               </div>
	        </div>
	    </c:if>
	    <!-- 페이징 처리 end -->

	</div>
	
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <form action="${path}/#" method="post" enctype="multipart/form-data">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel"></h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body p-3 m-1 ">
	      	<label>리뷰 평점</label>
            <div class="jf-input">
                <div class="row">
                    <div class="col py-1 text-nowrap">
                        <c:forEach begin="1" end="10" var="i">
                        <div class="form-check form-check-inline mx-2">
                            <input class="form-check-input" type="radio" name="review_point" id="review_point" value="${i}" <c:if test="${i == 10}"> checked="checked"</c:if>/>
                            <label class="form-check-label" for="review_point${i}">${i}</label>
                        </div>
                        </c:forEach>
                    </div>
                </div>
           	</div>
	      	<label>리뷰 내용</label>
	        <textarea class="form-control form-control-lg" rows="5"></textarea>      		
	        <input type="file" name="file1" class="form-control" accept="image/jpeg, image/png, image/gif">
	        <input type="file" name="file2" class="form-control" accept="image/jpeg, image/png, image/gif">
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	        <button type="button" class="btn btn-primary">작성 완료</button>
	      </div>
	    </div>
	  </div>
  </form>
</div>


<%@ include file="../layout/layout_footer.jsp" %>