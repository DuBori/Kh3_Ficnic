<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>

<div class="contents w1100">

		<!-- 카테고리 리스트  -->
		<div>
			<select onchange="if(this.value) location.href=(this.value);">
				<option value="">카테고리 없음</option>
				<c:forEach items="${clist }" var="dto">
					<option value="${path}/ficnic/ficnic_list.do?category=${dto.getCategory_id()}"<c:if test="${dto.getCategory_id() eq category_no  }">selected</c:if> >${dto.getCategory_name() }</option>	
				</c:forEach>
			</select>
			
		</div>
	   
	   <div>
	  	<c:forEach items="${clist }" var="dto">
	  		<c:if test="${dto.getCategory_id() eq category_no }">
		  		<c:forEach items="${dto.getSub_category() }" var="sub">
		  			<a href="${path}/ficnic/ficnic_list.do?category=${dto.getCategory_id()}&subcategory=${sub.getCategory_id()}">${sub.getCategory_name() }</a>
		  		</c:forEach>
	  		</c:if>
	  	</c:forEach>
	   </div>
	   
	   <div>
	   	<h3><c:if test="${!empty ficnic_name}">${ficnic_name } 프립</c:if></h3>
	   	<c:choose>
	   	<c:when test="${!empty flist }">
	   		<c:forEach items="${flist }" var="dto">
	   			<c:set var="cnt" value="0"/>
	   			<div class="border" onclick="location.href='${path}/ficnic/ficnic_view.do?ficnic_no=${dto.getFicnic_no() }'">
		   			<img alt="이미지없음" src="${dto.getFicnic_photo1() }">
		   			<p>${dto.getFicnic_location()}</p>
		   			<p>${dto.getFicnic_name()}</p>
		   			<p>★★★★★ 후기 <c:forEach items="${rlist}" var="review" >
		   								<c:if test="${dto.getFicnic_no() eq review.getFicnic_no() }" >
		   									<c:set var="cnt" value="${cnt+1}"/>
		   								</c:if>
		   						  </c:forEach>
		   						  ${cnt}
		   			</p>
		   			<c:choose>
		   				<c:when test="${!empty dto.getFicnic_sale_price() }">
			   				<p>이전가격 : ${dto.getFicnic_market_price()}</p>
			   				할인율 <fmt:formatNumber value="${dto.getFicnic_sale_price()/dto.getFicnic_market_price()*100}" type="percent" pattern="##" />% <fmt:formatNumber value="${dto.getFicnic_sale_price() }"></fmt:formatNumber>원
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