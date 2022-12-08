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
                                            <option value="user"<c:if test="${search_type eq 'user'}"> selected="selected"</c:if>>신청</option>
                                            <option value="admin"<c:if test="${search_type eq 'admin'}"> selected="selected"</c:if>>예약확정</option>
                                            <option value="exit"<c:if test="${search_type eq 'exit'}"> selected="selected"</c:if>>체험완료</option>
                                            <option value="exit"<c:if test="${search_type eq 'exit'}"> selected="selected"</c:if>>예약취소</option>
                                        </select>
                                    </div>
                                    
                                    <div class="px-0 pt-1 pb-2 collapse show" id="date_layer">
                                         <div class="col-5 d-inline-block px-0">
                                             <div class="input-group">
                                                 <div class="input-group-prepend">
                                                     <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                                 </div>
                                                 <input type="text" name="startDate" value="${startDate }" id="startDt" class="form-control text-center eng" />
                                             </div>
                                         </div>
                                         <div class="d-inline-block pt-2 px-2">~</div>
                                         <div class="col-5 d-inline-block px-0">
                                             <div class="input-group">
                                                 <div class="input-group-prepend">
                                                     <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                                 </div>
                                                 <input type="text" name="endDate" value="${endDate }" id="endDt" class="form-control text-center eng" />
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
                            <a href="${path}/admin/member/member_list.do" class="btn btn-outline-secondary ml-1 mb-2"><i class="fa fa-refresh"></i> 초기화</a>
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
                                <th style="width: 10%; min-width: 100px;">예약번호</th>
                                <th>예약일자</th>
                                <th style="width: 19%; min-width: 180px;" class="table-list-hide">예약명</th>
                                <th style="width: 19%; min-width: 180px;" class="table-list-hide">결제금액</th>
                                <th style="width: 12%; min-width: 100px;" class="table-list-hide">예약자</th>
                                <th style="width: 13%; min-width: 120px;" class="table-list-hide-mob">예약일자</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:set var="list" value="${List}" />
                            <c:choose>
                            <c:when test="${!empty list}">
                            <c:forEach items="${list}" var="dto">
                            <c:set var="showLink" value="onclick=\"popWindow('reserv_view.do?no=${dto.getMember_no()}&id=${dto.getMember_id()}', '700', '900');\"" />
                            <c:set var="result_name" value="<span class=\"search\">${search_name}</span>"></c:set>
                            <c:set var="result_id" value="<span class=\"search\">${search_id}</span>"></c:set>
                            <c:set var="result_email" value="<span class=\"search\">${search_email}</span>"></c:set>
                            <c:set var="result_phone" value="<span class=\"search\">${search_phone}</span>"></c:set>
                            <tr>
                                <td ${showLink} class="py-4 table-list-hide-mob">${dto.getMember_no()}</td>
                                <td ${showLink}>
                                    <c:choose>
                                    <c:when test="${dto.getMember_type() eq 'admin'}">관리자</c:when>
                                    <c:when test="${dto.getMember_type() eq 'exit'}">탈퇴회원</c:when>
                                    <c:otherwise>회원</c:otherwise>
                                    </c:choose>
                                </td>
                                <td ${showLink}>
                                    <p><b><c:choose><c:when test="${search_name != ''}">${dto.getMember_name().replace(search_name, result_name)}</c:when><c:otherwise>${dto.getMember_name()}</c:otherwise></c:choose></b></p>
                                    <p class="eng"><c:choose><c:when test="${search_id != ''}">${dto.getMember_id().replace(search_id, result_id)}</c:when><c:otherwise>${dto.getMember_id()}</c:otherwise></c:choose></p>
                                </td>
                                <td ${showLink} class="eng table-list-hide"><c:choose><c:when test="${search_email != ''}">${dto.getMember_email().replace(search_email, result_email)}</c:when><c:otherwise>${dto.getMember_email()}</c:otherwise></c:choose></td>
                                <td ${showLink} class="eng table-list-hide"><c:choose><c:when test="${search_phone != ''}">${dto.getMember_phone().replace(search_phone, result_phone)}</c:when><c:otherwise>${dto.getMember_phone()}</c:otherwise></c:choose></td>
                                <td ${showLink} class="eng table-list-hide"><fmt:formatNumber value="${dto.getMember_point()}" /></td>
                                <td ${showLink} class="eng table-list-hide-mob">${dto.getMember_joindate().substring(0,10)}<br />${dto.getMember_joindate().substring(11)}</td>
                            </tr>
                            </c:forEach>
                            </c:when>

                            <c:otherwise>
                            <tr>
                                <td colspan="7" class="nodata">No Data</td>
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