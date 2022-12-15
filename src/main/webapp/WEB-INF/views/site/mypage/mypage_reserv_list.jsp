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
		    			<div class="mypage-wish card w-20 m-1 p-1 d-flex flex-column border justify-content-center align-items-center ">
							  <img src="${path }${dto.getReserv_ficnic_photo()}" class="card-img-top" style="width:200px" alt="...">
							  <div class="mypage-wish card-body">
							    <p class="card-location">지역</p>
							    <h5 class="card-title" style="size: 1px">${dto.getReserv_ficnic_name() }</h5>
							  </div>
							  <ul class="mypage-wish list-group list-group-flush">
							    <li class="list-group-item">예약날짜 ${dto.getReserv_date()}</li>
							    <li class="list-group-item">${dto.getReserv_total_price() }</li>
							  </ul>
							  <div class="mypage-wish card-body">
							    <c:if test="${dto.getReserv_date() > today and dto.getReserv_status() ne 'cancel'}"> <a href="${path}/mypage/mypage_reserv_view.do?reserv_no=${dto.getReserv_no()}" class="card-link">상세내역 보기</a></c:if>
							    <c:if test="${dto.getReserv_date() < today and dto.getReserv_status() ne 'cancel'}"> <a href="#" class="card-link">리뷰달기</a></c:if>
							    <c:if test="${dto.getReserv_status() eq 'cancel'}"> <a href="#" class="card-link">예약취소</a></c:if>
							  </div>
						</div>	
					</c:if>
					</c:forEach>
				</c:when>
				<c:otherwise>
						<div class="Placeholder__Wrapper-von7t2-0 gjaxFh">
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
	</div>
	
	
	
	
	
	<div class="row">
	        <div class="col-lg">
	            <div class="card border-0">
	                <div class="card-header bg-white border-0 pt-0 pl-0">총 <b class="text-primary"><fmt:formatNumber value="${totalCount}" /></b> 개의 예약</div>
	
	                <div class="card-body p-0">
	                    <table class="table-list mb-2 board-list">
	                        <thead>
	                            <tr>
	                                <th style="width: 80px;" class="table-list-hide">No.</th>
	                                <th style="width: 80px;" class="table-list-hide-mob">예약 번호</th>
	                                <th>예약 피크닉</th>
	                                <th style="width: 120px;">최종 결제금액</th>
	                                <th style="width: 120px;">예약 일자</th>
	                                <th style="width: 80px;" class="table-list-hide-mob">예약 상태</th>
	                            </tr>
	                        </thead>
	
	                        <tbody>
	                            <c:choose>
	                                <c:when test="${!empty List}">
	                                <c:forEach var="dto" items="${List}">
	                                <tr onclick="location.href='#';">
	                                    <td class="text-center eng table-list-hide">${dto.getReserv_no() }</td>
	                                    <td class="text-left pl-3 subject">${dto.getReserv_sess() }</td>
	                                    <td class="text-center table-list-hide-mob">${dto.getReserv_ficnic_name()}</td>
	                                    <td class="text-center eng">${dto.getReserv_total_price() }</td>
	                                    <td class="text-center eng table-list-hide-mob">${dto.getReserv_date() }</td>
	                                    <td class="text-center eng table-list-hide-mob">${dto.getReserv_status() }</td>
	                                </tr>
	                                </c:forEach>
	                                </c:when>
	
	                                <c:otherwise>
	                                <tr>
	                                    <td colspan="6" class="nodata">
										<div class="Placeholder__Wrapper-von7t2-0 gjaxFh">
											<img src="data:image/svg+xml,%3Csvg width='56' height='56' fill='none' xmlns='http://www.w3.org/2000/svg'%3E %3Cpath d='M38 16H22M38 23H22M38 30H22M38 37H22' stroke='%23777' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/%3E %3Crect x='8' y='5' width='39' height='44' rx='4' stroke='%23777' stroke-width='2'/%3E %3Ccircle cx='16.5' cy='16' r='1.5' fill='%23777'/%3E %3Ccircle cx='16.5' cy='23' r='1.5' fill='%23777'/%3E %3Ccircle cx='16.5' cy='30' r='1.5' fill='%23777'/%3E %3Ccircle cx='16.5' cy='37' r='1.5' fill='%23777'/%3E %3Ccircle cx='42' cy='43' r='11' fill='%23fff' stroke='%23fff' stroke-width='2'/%3E %3Ccircle cx='42' cy='43' r='9' fill='%23fff' stroke='%23777' stroke-width='2'/%3E %3Cpath d='m39 46 6-6M45 46l-6-6' stroke='%23777' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/%3E %3C/svg%3E" alt="아직 결제내역이 없어요!" width="56px" height="56px"><div class="Placeholder__Title-von7t2-1 dqGjWH">
												아직 결제내역이 없어요!
											</div>
											<div class="Placeholder__SubTitle-von7t2-2 gSjDbY">
												지금 바로 피크닉을 시작해보세요.
											</div>
										</div>
										</td>
	                                </tr>
	                                </c:otherwise>
	                            </c:choose>
	                        </tbody>
	                    </table>
	                </div>
	            </div>
	        </div>
	    </div>
	
	
	
	    <div class="row mt-2 list-bottom-util">
	        <div class="col-md-4 mt-3">
	            <form name="search_form" method="get" action="${path}/mypage/mypage_reserv_list.do">
	            <div class="input-group list-search-form w-80">
	                <select name="field" class="custom-select col-sm-4">
	                    <option value="">미선택</option>
	                    <option value="body">내용</option>
	                </select>
	                <input type="text" name="keyword" value="" class="form-control rounded-right" />
	                <button type="submit" class="btn btn-secondary ml-1"><i class="icon-magnifier"></i> 검색</button>
	            </div>
	            </form>
	        </div>
	

	
	        <div class="col-md-4 text-right mt-3">
	                         <c:choose>
	                             <c:when test="${!empty field}">
	                                <a href="<%=request.getContextPath()%>/mypage/mypage_reserv_list.do" class="btn btn-outline-secondary"><i class="fa fa-list mr-1"></i> 게시물 전체목록</a>
	                             </c:when>
	                         </c:choose>
	
	        </div>
	    </div>
   


</div>



<%@ include file="../layout/layout_footer.jsp" %>