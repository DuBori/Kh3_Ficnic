<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layout/layout_header.jsp" %>

<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>상품 목록</h2>
        <ol class="m-0 p-2">
            <li>상품 관리</li>
            <li><b>상품 목록</b></li>
        </ol>
    </div>
</div>

<div class="page-cont">

<div class="card-body px-5 pt-4 pb-3">
		<form name="search_form" method="post" action="${path}/admin/ficnic/ficnic_list.do" >
                    <input type="hidden" name="ps_page" value="1">
                    <div class="row justify-content-center mb-2">
                        <div class="col-sm-3 mb-2">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <label class="input-group-text" for="search_cate">카테고리 구분</label>
                                </div>
                                 <select id="search_boxtype" name="finic_category_no" class="custom-select">
                                   		<option value="">카테고리 없음</option>
                                    <c:forEach items="${clist}" var="dto">
                                    	<option  value="${dto}" <c:if test="${ dto eq category_no }">selected</c:if> >${dto }</option>                                  
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-3 mb-2">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <select name="ficnic_location" class="input-group-text" >
                                    	<option value="">지역</option>
                                    	<c:forEach items="${locationList}" var="dto">
                                    		<option value="${dto}" <c:if test="${dto eq location }">selected</c:if> >${dto}</option>
                                    	</c:forEach>
                                    </select>
                                	<input name="ficnic_address" value="${addr}" <c:if test="${!empty addr }">value="${addr}"</c:if> >
                                </div>                                
                            </div>
                        </div>                     
                        <div class="col-sm-3 mb-2">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <label class="input-group-text" for="ficnic_name">피크닉 이름</label>
                                </div>
                                <input type="text" name="ficnic_name" class="form-control"  <c:if test="${!empty name }">value="${name}"</c:if>>
                            </div>
                        </div>         
                    </div>
                    <div class="row justify-content-center">
                        <div class="search-form-button col-sm-auto mb-2">
                            <button type="submit" class="btn btn-secondary"><i class="fa fa-search"></i> 검색하기</button>
                        </div>
                    </div>
                    </form>
                </div>
</div>
<div class="card-body px-4 pt-0 member-list">
       <table class="table-list mb-2">
           <thead>
               <tr>
                   <th style="width: 100px;" class="table-list-hide-mob">피크닉 번호</th>
                   <th style="width: 120px;" class="table-list-hide">피크닉 분류</th>
                   <th style="width: 120px;" colspan="2">피크닉 이름</th>
                   <th style="width: 120px;" class="table-list-hide">현재 판매가</th>
                   <th style="width: 120px;" class="table-list-hide-mob">총 판매개수</th>
                   <th style="width: 120px;">기능</th>
               </tr>
           </thead>

           <tbody>
           	<c:forEach items="${flist }" var="dto">
           	 <c:set var="showLink" value="onclick=\"popWindow('ficnic_view.do?no=${dto.getFicnic_no()}', '700', '900');\"" />
	           	<tr>
	           	   <td class="table-list-hide-mob"><span class="text-primary">${dto.getFicnic_no()}</span></td>
	           	   <td ${showLink} class="table-list-hide">${dto.getFicnic_category_no() }</td>
                   <td ${showLink} style="width: 100px;" colspan="2">${dto.getFicnic_name() }</td>
                   <td ${showLink} class="eng table-list-hide">${dto.getFicnic_sale_price() }</td>
                   <td ${showLink} class="eng table-list-hide-mob">${dto.getFicnic_sale() }</td>
                   <td>
                    <a href="${path}/admin/ficnic/ficnic_modify.do?no=${dto.getFicnic_no()}" class="btn btn-outline-success btn-sm">수정</a>
                       &nbsp;
                    <a href="${path}/admin/ficnic/ficnic_delete.do?no=${dto.getFicnic_no()}" class="btn btn-outline-danger btn-sm" onclick="return confirm('정말 삭제하시겠습니까?\n되돌릴 수 없습니다.');">삭제</a>                                                                    </td>
               </tr>
	        </c:forEach>   
            </tbody>
       </table>
       
      	<!-- 페이징 처리  -->
		<c:if test="${!empty paging}">
	            <div class="row list-bottom-util">
	                <div class="col text-center">
	                    ${pagingWrite}
	                </div>
	            </div>
	    </c:if>
	    <!-- 페이징 처리 end -->
       <div class="row mt-2 list-bottom-util">
	    	<div class="col-md-4 text-right mt-3">
	        	<a href="${path}/admin/ficnic/ficnic_write.do" class="btn btn-primary"><i class="fa fa-plus"></i> 상품 추가</a>
	   	 	</div>
   	 	</div>
       
</div>


<%@ include file="../layout/layout_footer.jsp" %>