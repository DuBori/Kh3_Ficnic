<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<body>

<h2>피크닉 정보 보기</h2>

<div class="page-cont">

    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>피크닉 기본 정보</h4>
                    <div class="row form">
                        <div class="form-group col d-flex align-items-center mb-2">
                            <label>피크닉 이름</label>
                            <div class="px-3">${dto.getFicnic_name()}</div>
                        </div>

                        <div class="w-100 border-bottom"></div>

                        <div class="form-group col d-flex align-items-center">
                            <label>피크닉 카테고리</label>
                            <c:forEach items="${clist }" var="cdto">	                        
                            	<c:if test="${cdto.getCategory_id() eq dto.getFicnic_category_no() }"> ${cdto.getCategory_name() }</c:if>
                            	<c:forEach items="${cdto.getSub_category()}" var="subdto">
                            		<c:if test="${subdto.getCategory_id() eq dto.getFicnic_category_no() }"> ${subdto.getCategory_name() }</c:if> 
                            		                        
                            		<c:if test="${!empty dto.getFicnic_category_sub1() and dto.getFicnic_category_sub1() eq subdto.getCategory_id()}">/${subdto.getCategory_name() }</c:if>
                            		<c:if test="${!empty dto.getFicnic_category_sub2() and dto.getFicnic_category_sub2() eq subdto.getCategory_id()}">/${subdto.getCategory_name() }</c:if>
                            		<c:if test="${!empty dto.getFicnic_category_sub3() and dto.getFicnic_category_sub3() eq subdto.getCategory_id()}">/${subdto.getCategory_name() }</c:if>  	
                            	</c:forEach>                          	
                            	<c:if test="${!empty dto.getFicnic_category_sub1() and dto.getFicnic_category_sub1() eq cdto.getCategory_id()}">/${cdto.getCategory_name() }</c:if>
                            	<c:if test="${!empty dto.getFicnic_category_sub2() and dto.getFicnic_category_sub2() eq cdto.getCategory_id()}">/${cdto.getCategory_name() }</c:if>
                            	<c:if test="${!empty dto.getFicnic_category_sub3() and dto.getFicnic_category_sub3() eq cdto.getCategory_id()}">/${cdto.getCategory_name() }</c:if>   	
                            </c:forEach>
                        </div>
                                                
                        <div class="w-100"></div>
                        <div class="form-group col d-flex align-items-center">
                            <label>매장가</label>
                            <div class="px-3"><fmt:formatNumber value="${dto.getFicnic_market_price()}"/></div>원
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col d-flex align-items-center">
                            <label>세일가</label>
                            <div class="px-3 engnum"><fmt:formatNumber value="${dto.getFicnic_sale_price()}"/></div>원
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col d-flex align-items-center">
                            <label>주소</label>
                            <div class="px-3 engnum">(${dto.getFicnic_location()})${dto.getFicnic_address() }</div>
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col d-flex align-items-center">
                            <label>등록일자</label>
                            <div class="px-3 engnum">${dto.getFicnic_date().substring(0,10) }</div>
                        </div>                        
                        <table border="1" cellspacing="0">
							<thead>
								<tr>
									<th>피크닉 옵션</th>
									<th>피크닉가격</th>
								</tr>								
							</thead>
							<tbody>
								<c:forEach items="${optionList}" var="dto">
									 <tr>
										 	<td>${dto.title }</td>
										 	<td>${dto.price }</td>
									 </tr>	
								</c:forEach>	
						</tbody>
						</table>
						
						<c:if test="${!empty selectList }">
							<table border="1" cellspacing="0">
							<thead>
								<tr>
									<th>피크닉 추가 선택 옵션</th>
									<th>피크닉 추가 선택 가격</th>
								</tr>								
							</thead>	
							<tbody>
								<c:forEach items="${selectList}" var="dto">
									 <tr>
										 	<td>${dto.title }</td>
										 	<td>${dto.price }</td>
									 </tr>	
								</c:forEach> 
								
							</tbody>					
							</table>
						</c:if>
						
						<c:if test="${!empty infoList }">
							<table border="1" cellspacing="0">
							<thead>
								<tr>
									<th>피크닉 정보 옵션</th>
									<th>피크닉 정보 가격</th>
								</tr>								
							</thead>	
							<tbody>
								<c:forEach items="${infoList}" var="dto">
									 <tr>
										 	<td>${dto.title }</td>
										 	<td>${dto.cont }</td>
									 </tr>	
								</c:forEach> 
								
							</tbody>					
							</table>
						</c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>상세 정보</h4>
                    <div class="w-100"></div>
                    <div class="form-group col d-flex align-items-center">
                        <label>커리큘럼</label>
                        <div class="px-3 engnum">${dto.getFicnic_curriculum() }</div>
                    </div>
                    <div class="w-100"></div>
                    <div class="form-group col d-flex align-items-center">
                        <label>기타정보</label>
                        <div class="px-3 engnum">${dto.getFicnic_etc() }</div>
                    </div>
                    <div class="w-100"></div>
                    <div class="form-group col d-flex align-items-center">
                        <label>포함사항</label>
                        <div class="px-3 engnum">${dto.getFicnic_include() }</div>
                    </div>
                    <div class="w-100"></div>
                    <div class="form-group col d-flex align-items-center">
                        <label>불포함사항</label>
                        <div class="px-3 engnum">${dto.getFicnic_notinclude() }</div>
                    </div>
                    <div class="w-100"></div>
                    <div class="form-group col d-flex align-items-center">
                        <label>준비물</label>
                        <div class="px-3 engnum">${dto.getFicnic_prepare() }</div>
                    </div>
                    
                    <div class="w-100"></div>
                    <div class="form-group col d-flex align-items-center">
                        <label>유의사항</label>
                        <div class="px-3 engnum">${dto.getFicnic_caution() }</div>
                    </div>
                    
                    
					<div class="column form">		
						<div class="w-100"></div>
                        <div class="form-group col d-flex align-items-center">            
                            <div class="px-3 engnum">${dto.getFicnic_detail()}</div>
                        </div>
					</div>
					
					
                </div>
            </div>
        </div>
    </div>
   
   <div class="my-2 text-center">
    <button type="button" class="btn btn-outline-secondary" onclick="window.print();"><i class="fa fa-print"></i> 인쇄하기</button>
        <button type="button" class="btn btn-secondary ml-2" onclick="window.close();"><i class="fa fa-times"></i> 창닫기</button>
	</div> 

</div>



</body>



<%@ include file="../layout/layout_footer.jsp" %>