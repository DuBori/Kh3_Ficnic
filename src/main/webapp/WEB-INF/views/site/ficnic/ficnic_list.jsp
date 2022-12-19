<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_ficnic.css" />
<script language="javascript" src="${path}/resources/site/js/js_ficnic.js"></script>



<div class="page-info w1100">
    <h2>${ficnic_name}</h2>
    <ol>
        <li><a href="${path}/"><i class="icon-home"></i> HOME</a></li>
        <li>피크닉</li>
        <li><b>${ficnic_name}</b></li>
    </ol>
</div>



<div class="contents w1100 goods-list">

	<c:if test="${!empty clist}">
	<ul class="gl-category">
		<li<c:if test="${param.category eq parent_category_no}"> class="now"</c:if>><a href="ficnic_list.do?category=${parent_category_no}">전체보기</a></li>
	  	<c:forEach var="sub" items="${clist}">
	  	<li<c:if test="${param.category eq sub.getCategory_id()}"> class="now"</c:if>><a href="ficnic_list.do?category=${sub.getCategory_id()}">${sub.getCategory_name()}</a></li>
	  	</c:forEach>
	</ul>
	</c:if>



	<ul class="gl-list ficnic-list">
		<c:choose>
			<c:when test="${!empty flist}">
				<c:forEach items="${flist}" var="dto">
					<li>
						<a href="ficnic_view.do?ficnic_no=${dto.getFicnic_no()}">
						</a>
					</li>
				</c:forEach>
			</c:when>

			<c:otherwise><li class="nodata">등록된 피크닉이 없어요...</li></c:otherwise>
		</c:choose>
	</ul>

	   
	   <div>
	   	<c:choose>
	   	<c:when test="${!empty flist}">
	   		<c:forEach items="${flist }" var="dto">
	   			<c:set var="cnt" value="0"/>
	   			<div class="border" onclick="location.href='${path}/ficnic/ficnic_view.do?ficnic_no=${dto.getFicnic_no()}'">
		   			<img alt="이미지없음" src="${dto.getFicnic_photo1()}">
		   			<p>${dto.getFicnic_location()}</p>
		   			<p>${dto.getFicnic_name()}</p>
		   			<p>★★★★★ 후기 <c:forEach items="${rlist}" var="review" >
		   								<c:if test="${dto.getFicnic_no() eq review.getFicnic_no()}" >
		   									<c:set var="cnt" value="${cnt+1}"/>
		   								</c:if>
		   						  </c:forEach>
		   						  ${cnt}
		   			</p>
		   			<c:choose>
		   				<c:when test="${!empty dto.getFicnic_sale_price()}">
			   				<p>이전가격 : ${dto.getFicnic_market_price()}</p>
			   				할인율 <fmt:formatNumber value="${dto.getFicnic_sale_price()/dto.getFicnic_market_price()*100}" type="percent" pattern="##" />% <fmt:formatNumber value="${dto.getFicnic_sale_price()}"></fmt:formatNumber>원
		   				</c:when>
		   				<c:otherwise>
		   					Only  ${dto.getFicnic_market_price()}
		   				</c:otherwise>
		   			</c:choose>
		   		</div>
	   		</c:forEach>
	   		</c:when>
	   		<c:otherwise>
	   			<h5>등록된 피크닉이 없어요</h5>
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



<%@ include file="../layout/layout_footer.jsp" %>