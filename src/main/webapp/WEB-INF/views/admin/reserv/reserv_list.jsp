<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<script type="text/javascript">$("#header .navbar .nav-item:nth-child(2)").addClass("active");</script>


<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>예약 목록</h2>
        <ol class="m-0 p-2">
            <li>예약 관리</li>
            <li><b>예약 목록</b></li>
        </ol>
    </div>
</div>



<div class="page-cont">
    <div class="row mb-3">
        <div class="col-lg">
            <div class="card">
                <div class="card-body px-5 pt-4 pb-3">
                    <form name="search_form" method="get" action="${path}/admin/reserv/reserv_list.do" class="row py-2 px-3">
                    <div class="row justify-content-center">
                        <div class="col-lg-9">
                            <div class="row justify-content-center">
                                <div class="col-md-4 mb-2">
                                
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="search_type">유형</label>
                                        </div>
                                        <select id="search_type" name="search_type" class="custom-select">
                                            <option value="">- 전체보기 -</option>
                                            <option value="reserv"<c:if test="${search_type eq 'reserv'}"> selected="selected"</c:if>>신청</option>
                                            <option value="confirm"<c:if test="${search_type eq 'confirm'}"> selected="selected"</c:if>>예약확정</option>
                                            <option value="done"<c:if test="${search_type eq 'done'}"> selected="selected"</c:if>>체험완료</option>
                                            <option value="cancel"<c:if test="${search_type eq 'cancel'}"> selected="selected"</c:if>>예약취소</option>
                                        </select>
                                    </div>
                                    
                                    <div class="px-0 pt-1 pb-2 collapse show" id="date_layer">
                                         <div class="col-5 d-inline-block px-0">
                                             <div class="input-group">
                                                 <div class="input-group-prepend">
                                                     <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                                 </div>
                                                 <input type="text" name="startDate" value="${startDay }" id="startDt" class="form-control text-center eng" />
                                             </div>
                                         </div>
                                         <div class="d-inline-block pt-2 px-2">~</div>
                                         <div class="col-5 d-inline-block px-0">
                                             <div class="input-group">
                                                 <div class="input-group-prepend">
                                                     <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                                 </div>
                                                 <input type="text" name="endDate" value="${endDay }" id="endDt" class="form-control text-center eng" />
                                             </div>
                                         </div>
                                     </div>
                                                                         
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row justify-content-center">
                        <div class="col-lg-6">
                            <div class="row justify-content-center">
                                <div class="col-md-4 mb-2">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="search_name">예약 번호</label>
                                        </div>
                                        <input type="text" id="search_no" name="search_no" value="${search_no}" class="form-control">
                                    </div>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="search_id">예약자 이름</label>
                                        </div>
                                        <input type="text" id="search_id" name="search_id" value="${search_id}" class="form-control">
                                    </div>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text" for="search_id">상품명</label>
                                        </div>
                                        <input type="text" id="search_name" name="search_name" value="${search_name}" class="form-control">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="search-form-button col-lg-auto text-center">
                            <button type="submit" class="btn btn-secondary mb-2"><i class="fa fa-search"></i> 검색하기</button>
                            <a href="${path}/admin/reserv/reserv_list.do" class="btn btn-outline-secondary ml-1 mb-2"><i class="fa fa-refresh"></i> 초기화</a>
                        </div>
                    </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <div class="row">
        <div class="col-lg">
            <div class="card">
                <div class="card-header bg-white border-0 pt-4 pl-4">총 <b class="text-primary"><fmt:formatNumber value="${totalCount}" /></b> 개의 예약</div>

                <div class="card-body px-4 pt-0">
                    <table class="table-list hover mb-2">
                        <thead>
                            <tr>
                                <th style="width: 6.5%; min-width: 50px;" class="table-list-hide-mob">상태</th>
                                <th style="width: 15%; min-width: 100px;">예약번호</th>
                                <th>상품명/옵션</th>
                                <th style="width: 15%; min-width: 180px;" class="table-list-hide">결제수단/결제금액</th>
                                <th style="width: 15%; min-width: 100px;" class="table-list-hide">예약자</th>
                                <th style="width: 13%; min-width: 120px;" class="table-list-hide-mob">예약일자</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:set var="list" value="${List}" />
                            <c:choose>
                            <c:when test="${!empty list}">
                            <c:forEach items="${list}" var="dto">
                            <c:set var="showLink" value="onclick=\"popWindow('reserv_view.do?no=${dto.getReserv_no()}&id=${dto.getMember_id() }', '700', '900');\"" />
                            <c:set var="result_no" value="<span class=\"search\">${search_no}</span>"></c:set>
                            <c:set var="result_id" value="<span class=\"search\">${search_id}</span>"></c:set>
                            <c:set var="result_name" value="<span class=\"search\">${search_name}</span>"></c:set>
                            <tr>
                                <td ${showLink}>
                                    <c:choose>
                                    <c:when test="${dto.getReserv_status() eq 'reserv'}">신청</c:when>
                                    <c:when test="${dto.getReserv_status() eq 'confirm'}">예약확정</c:when>
                                    <c:when test="${dto.getReserv_status() eq 'done'}">체험완료</c:when>
                                    <c:otherwise>예약취소</c:otherwise>
                                    </c:choose>
                                </td>
                                <td ${showLink} class="py-4 table-list-hide-mob"><c:choose><c:when test="${search_no != ''}">${dto.getReserv_sess().replace(search_no, result_no)}</c:when><c:otherwise>${dto.getReserv_sess()}</c:otherwise></c:choose></td>
                                <td ${showLink}>
                                    <p><b><c:choose><c:when test="${search_name != ''}">${dto.getReserv_ficnic_name().replace(search_name, result_name)}</c:when><c:otherwise>${dto.getReserv_ficnic_name()}</c:otherwise></c:choose></b></p>
                                    <p class="eng">${dto.getReserv_ficnic_option_title()}</p>
                                </td>
                                <td ${showLink} class="eng table-list-hide">
                                <c:choose>
                                <c:when test="${dto.getReserv_payment() eq 'naver'}">네이버페이</c:when>
                                <c:when test="${dto.getReserv_payment() eq 'kakao'}">카카오페이</c:when>
                                <c:when test="${dto.getReserv_payment() eq 'nobankbook'}">무통장 입금</c:when>
                                <c:when test="${dto.getReserv_payment() eq 'toss'}">실시간 계좌이체</c:when>
                                <c:otherwise>카드결제</c:otherwise>
                                </c:choose><br>
                                <fmt:formatNumber value="${dto.getReserv_total_price()}" />
                                </td>
                                <td ${showLink} class="eng table-list-hide"><c:choose><c:when test="${search_id != ''}">${dto.getReserv_name().replace(search_id, result_id)}</c:when><c:otherwise>${dto.getReserv_name()}</c:otherwise></c:choose><br>${dto.getMember_id() }</td>
                                <td ${showLink} class="table-list-hide-mob">${dto.getReserv_date()}</td>
                            </tr>
                            </c:forEach>
                            </c:when>

                            <c:otherwise>
                            <tr>
                                <td colspan="6" class="nodata">No Data</td>
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




<div class="row mt-2 list-bottom-util">
    <div class="col-md-4 mt-3"></div>

    <div class="col-md-4 text-center mt-3">
        <c:if test="${!empty paging}">${pagingWrite}</c:if>
    </div>

    <div class="col-md-4 text-right mt-3">
        <c:choose>
        <c:when test="${!empty keyword}"><a href="${path}/admin/reserv/reserv_list.do" class="btn btn-outline-secondary"><i class="fa fa-list"></i> 예약 목록</a></c:when>
        </c:choose>
    </div>
</div>


<%@ include file="../layout/layout_footer.jsp" %>