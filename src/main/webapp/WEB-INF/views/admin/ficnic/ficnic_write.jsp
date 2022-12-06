<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/layout_header.jsp" %>

<script type="text/javascript">
	
	$(function() {
		
		$('#selectDiv').change(function() {
			 $("input[name=ficnic_category_no]").val($(this).find("option:selected").data("sub"));
		});
		
	});
</script>
<c:if test="${!empty m }">
	<c:set var="tag" value="admin/ficnic/ficnic_modify_ok.do"/>
	<c:set var="title" value="수정"/>
</c:if>
<c:if test="${empty m  }">
	<c:set var="tag" value="admin/ficnic/ficnic_write_ok.do"/>
	<c:set var="title" value="등록"/>
</c:if>

<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>피크닉 ${title }</h2>
        <ol class="m-0 p-2">
            <li>피크닉 관리</li>
            <li><b>상품 ${title }</b></li>
        </ol>
    </div>
</div>

<div class="page-cont">
	
	<div class="card-body p-4">
           <h4 class="view-limit">기본 정보</h4>
                  <div class="row form mb-5 view-limit">
                  	<!-- 카테고리 DTO  -->
                      <div class="form-group col">
                          <label>노출 여부</label>
                          <div class="btn-group mt-2" role="group" data-toggle="buttons">
                              <label class="btn btn-outline-secondary active">
                                  <input type="radio" name="category_show" value="Y" checked="checked"><i class="fa fa-eye"></i> 노출
                              </label>
                              <label class="btn btn-outline-secondary">
                                  <input type="radio" name="category_show" value="N"> <i class="fa fa-eye-slash"></i> 숨김
                              </label>
                          </div>
                      </div>
                      
                      <div class="w-100 border-bottom mt-2"></div>

                     <div class="form-group col">
                          <label>피크닉 카테고리</label>
                          <select id="selectDiv">
                        <c:forEach var="cate" items="${clist}">
							<!-- 대 카테고리 반복 -->
							<c:choose>
								<c:when test="${cate.getCategory_show() eq 'N'}">
									<c:set var="show_big_disshow" value=" [비노출]" />
								</c:when>
								<c:otherwise>
									<c:set var="show_big_disshow" value="" />
								</c:otherwise>
							</c:choose>
								<option class="name" data-sub="${cate.getCategory_id()}" >${cate.getCategory_name()}${show_big_disshow}</option>							
							<c:if test="${!empty cate.getSub_category()}">
							<!-- 중 카테고리 반복 -->
								<!-- 리스트로 담아온 sub_category  -->
								<c:forEach var="subc" items="${cate.getSub_category()}">
									<c:choose>
										<c:when test="${subc.getCategory_show() eq 'N'}">
											<c:set var="show_sub_disshow" value=" [비노출]" />
											<c:set var="show_sub_disclass" value="noshow" />
										</c:when>
										<c:otherwise>
											<c:set var="show_sub_disshow" value="" />
											<c:set var="show_sub_disclass" value="" />
										</c:otherwise>
									</c:choose>
									
									<%-- <input type="hidden" name="category_id[]" value="${subc.getCategory_id()}" />--%>
									<option class="name" data-sub="${subc.getCategory_id()}">--${subc.getCategory_name()}${show_sub_disshow}</option>							
								</c:forEach>
							</c:if>
						</c:forEach>
						</select>
                        
                     </div>
                      
                     <form action="<%=request.getContextPath()%>/${tag}" method="post" enctype="multipart/form-data">
		                     <div class="form-group col">
		                          <label>서브 카테고리</label>
		                          <div class="btn-group mt-2" role="group" data-toggle="buttons">
		                               <label for="goods_code"><span>*</span> 서브 카테고리 리스트(3개까지)</label>
		                          	   <input type="text" name="ficnic_category_sub" id="goods_code" value="" class="form-control w-30" onkeydown="EngNumInput(this);"> 
		                          </div>
		                     </div>
		                      <div class="w-100"></div>
		                      <div class="form-group col">
		                          <label for="goods_code"><span>*</span> 피크닉 코드(카테고리)</label>
		                          <input type="text" name="ficnic_category_no" value="" class="form-control w-30" onkeydown="EngNumInput(this);">
		                      </div>
		                      <div class="w-100"></div>
		                      <div class="form-group col">
		                          <label for="goods_name"><span>*</span> 피크닉 이름</label>
		                          <input type="text" name="ficnic_name" id="goods_name" value="" class="form-control">
		                      </div>
		                      <c:if test="${!empty m and fdto.getFicnic_market_price() ne 0}">
			                      <div class="w-100"></div>
			                      <div class="form-group col-sm">
			                          <label for="goods_in_price">이전 설정 판매가</label>
			                          <input type="text" name="ficnic_market_price" disabled="disabled" id="goods_in_price" value="${fdto.getFicnic_market_price()}" maxlength="11" class="form-control text-right w-40" onkeydown="NumberInput(this);">원
			                      </div>
		                      </c:if>
		                      <div class="w-100"></div>
		                      <div class="form-group col-sm">
		                          <label for="goods_in_price">설정할 판매가</label>
		                          <input type="text" name="ficnic_sale_price" id="goods_in_price" value="" maxlength="11" class="form-control text-right w-40" onkeydown="NumberInput(this);">원
		                      </div>
		                  </div>
						 
		                  <div>
		                      <h4 class="view-limit">판매 개수</h4>
		                      <div class="row form mb-5 view-limit">
		                          <div class="form-group col-sm">
		                              <label for="goods_ea_total">수량</label>
		                              <input type="text" name="ficnic_sale" id="goods_ea_total" value="${fdto.getFicnic_sale()}" maxlength="8" class="form-control text-center w-20" onkeydown="NumberInput(this);">개
		                          </div>
		                      </div>
		                  </div>
		                  
		                  <h4 class="view-limit">옵션</h4>
		              	  <c:if test="${!empty m and !empty mapList }">
							  	<c:forEach var="option" items="${mapList}">
							  		<div class="row form mb-1 view-limit">
							  		  <div class="form-group col-sm">
			                              <label for="goods_ea_total">옵션 타이틀</label>
			                              <input type="text" name="ficnic_option_title" value="${option.title}" maxlength="8" class="form-control text-center w-20" >
			                              
			                              <label for="goods_ea_total">옵션 가격</label>
			                              <input type="text" name="ficnic_option_price" value="${option.price}" maxlength="8" class="form-control text-center w-20" >원
			                          </div>
							  		</div>		
						  		</c:forEach>
						  </c:if>
						  <c:if test="${empty m }">
						  	<c:forEach begin="1" end="2">
						  	<div class="row form mb-1 view-limit">
							  		  <div class="form-group col-sm">
			                              <label for="goods_ea_total">옵션 타이틀</label>
			                              <input type="text" name="ficnic_option_title" value="${option.title}" maxlength="8" class="form-control text-center w-20" >
			                              
			                              <label for="goods_ea_total">옵션 가격</label>
			                              <input type="text" name="ficnic_option_price" value="${option.price}" maxlength="8" class="form-control text-center w-20" >원
			                          </div>
							  		</div>
						  	</c:forEach>
						  </c:if>
		                  
		                  <div>
		                      <h4 class="view-limit">날짜 선택</h4>
		                      <div class="row form mb-1 view-limit">
		                          <div class="form-group col-sm">
		                          	  <input type="radio" name="ficnic_date_use" value="Y" maxlength="5" class="form-control text-center w-10" <c:if test="${fdto.getFicnic_date_use() eq 'Y' }">checked</c:if> >Y
		                          	  <input type="radio" name="ficnic_date_use" value="N" maxlength="5" class="form-control text-center w-10" <c:if test="${fdto.getFicnic_date_use() eq 'N' }">checked</c:if>>N	
		                          </div>
		                      </div>
		                  </div>
		                  
		                  <div class="row form view-limit">
		                      <div class="w-100"></div>
		                      <div class="form-group col">
		                          <label>상품 사진</label>
		                          <input type="file" name="ficnic_photo"  class="form-control w-50">
		                          <input type="file" name="ficnic_photo"  class="form-control w-50">
		                          <input type="file" name="ficnic_photo"  class="form-control w-50">
		                          <input type="file" name="ficnic_photo"  class="form-control w-50">
		                          <input type="file" name="ficnic_photo"  class="form-control w-50">
		                      </div>
		                      <p class="text-primary p-0 mt-1"><i class="fa fa-lightbulb-o"></i> 이미지 파일을 업로드해 주세요 (.jpg, .jpeg, .gif, .png) 파일크기 최대 2MB</p>
		                  </div>
		                  
		                  <div>
		                      <h4 class="view-limit">피크닉 정보</h4>
		                      <div class="row form mb-5 view-limit">
		                          <div class="form-group col-sm">
		                              <label for="goods_ea_total">피크닉 정보</label>
		                              <input type="text" name="ficnic_info"  value="${fdto.getFicnic_info()}" maxlength="8" class="form-control text-center w-20" >
		                          </div>
		                      </div>
		                  </div>
		                  <div>
		                      <h4 class="view-limit">피크닉 상세</h4>
		                      <div class="row form mb-5 view-limit">
		                          <div class="form-group col-sm">
		                              <label for="goods_ea_total">피크닉 상세</label>
		                              <input type="text" name="ficnic_detail"  value="${fdto.getFicnic_detail()}" maxlength="8" class="form-control text-center w-20" >
		                          </div>
		                      </div>
		                  </div>
		                  <div>
		                      <h4 class="view-limit">피크닉 커리큘럼</h4>
		                      <div class="row form mb-5 view-limit">
		                          <div class="form-group col-sm">
		                              <label for="goods_ea_total">피크닉 커리큘럼</label>
		                              <input type="text" name="ficnic_curriculum"  value="${fdto.getFicnic_curriculum()}" maxlength="8" class="form-control text-center w-20" >
		                          </div>
		                      </div>
		                  </div>
		                  <div>
		                      <h4 class="view-limit">기타 정보</h4>
		                      <div class="row form mb-5 view-limit">
		                          <div class="form-group col-sm">
		                              <label for="goods_ea_total">기타 정보</label>
		                              <input type="text" name="ficnic_etc"  value="${fdto.getFicnic_etc()}" maxlength="8" class="form-control text-center w-20" >
		                          </div>
		                      </div>
		                  </div>
		                  
		                  <div>
		                      <h4 class="view-limit">진행지역</h4>
		                      <div class="row form mb-5 view-limit">
		                          <div class="form-group col-sm">
		                              <label for="goods_ea_total">진행지역</label>
		                              <input type="text" name="ficnic_location"  value="${fdto.getFicnic_location()}" maxlength="8" class="form-control text-center w-20" >
		                          </div>
		                      </div>
		                  </div>
		                  <div>
		                      <h4 class="view-limit">진행장소</h4>
		                      <div class="row form mb-5 view-limit">
		                          <div class="form-group col-sm">
		                              <label for="goods_ea_total">진행장소</label>
		                              <input type="text" name="ficnic_address"  value="${fdto.getFicnic_address()}" maxlength="8" class="form-control text-center w-20" >
		                          </div>
		                      </div>
		                  </div>
		                  <div>
		                      <h4 class="view-limit">포함사항</h4>
		                      <div class="row form mb-5 view-limit">
		                          <div class="form-group col-sm">
		                              <label for="goods_ea_total">포함사항</label>
		                              <input type="text" name="ficnic_include"  value="${fdto.getFicnic_include()}" maxlength="8" class="form-control text-center w-20" >
		                          </div>
		                      </div>
		                  </div>
		                  <div>
		                      <h4 class="view-limit">미포함사항</h4>
		                      <div class="row form mb-5 view-limit">
		                          <div class="form-group col-sm">
		                              <label for="goods_ea_total">미포함사항</label>
		                              <input type="text" name="ficnic_notinclude"  value="${fdto.getFicnic_notinclude()}" maxlength="8" class="form-control text-center w-20" >
		                          </div>
		                      </div>
		                  </div>
		                  <div>
		                      <h4 class="view-limit">준비물</h4>
		                      <div class="row form mb-5 view-limit">
		                          <div class="form-group col-sm">
		                              <label for="goods_ea_total">준비물</label>
		                              <input type="text" name="ficnic_prepare"  value="${fdto.getFicnic_prepare()}" maxlength="8" class="form-control text-center w-20" >
		                          </div>
		                      </div>
		                  </div>
		                  <div>
		                      <h4 class="view-limit">유의사항</h4>
		                      <div class="row form mb-5 view-limit">
		                          <div class="form-group col-sm">
		                              <label for="goods_ea_total">유의사항</label>
		                              <input type="text" name="ficnic_caution"  value="${fdto.getFicnic_caution()}" maxlength="8" class="form-control text-center w-20" >
		                          </div>
		                      </div>
		                  </div>
		                  
		              </div>
		              
						<div class="d-flex mt-2 input-form-button">
						    <div class="col-lg-3 pl-0 ml-0">
						            </div>
						    <div class="col-lg-6 text-center">
								<button type="submit" class="btn btn-primary btn-lg" ><i class="fa fa-pencil"></i> ${title}하기</button>    
							</div>
						    <div class="col-lg-3 text-right pr-0 mr-0">
						    	<a href="<%=request.getContextPath()%>/admin/ficnic/ficnic_list.do" class="btn btn-secondary btn-lg"><i class="fa fa-bars"></i> 목록보기</a>
						    </div>
						</div>                	
					</div>
				</form>

<%@ include file="../layout/layout_footer.jsp" %>