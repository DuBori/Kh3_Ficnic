<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/layout_header.jsp" %>

<script type="text/javascript">
	/* 해당 라디오 버튼이 눌러지면 label html 값이랑 라디오버튼 값 확인해보기  */
	$(function() {
		
		$('#selectDiv').change(function() {
			  alert($(this).val());
		});
		
		$("#goods_name").on("click",function(){
			alert('클릭');
		});

	});
</script>
<c:if test="${!empty m }">
	<c:set var="tag" value="admin/ficnic/modify_ok.do"/>
	<c:set var="title" value="수정"/>
</c:if>
<c:if test="${empty m  }">
	<c:set var="tag" value="admin/ficnic/write_ok.do"/>
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
								<c:when test="${cate.getSub_category().size() > 0}">
									<c:set var="show_big_class" value="plus" />
									<c:set var="show_big_count" value="<span class=\"count\">[${cate.getSub_category().size()}]</span>" />
								</c:when>
								<c:otherwise>
									<c:set var="show_big_class" value="normal" />
									<c:set var="show_big_count" value="" />
								</c:otherwise>
							</c:choose>
							
							<c:choose>
							<c:when test="${cate.getCategory_show() eq 'N'}">
								<c:set var="show_big_disshow" value=" [비노출]" />
								<c:set var="show_big_disclass" value=" noshow" />
							</c:when>
							<c:otherwise>
								<c:set var="show_big_disshow" value="" />
								<c:set var="show_big_disclass" value="" />
							</c:otherwise>
						</c:choose>
						
						<li class="line-plus depth01-${show_big_class}${show_big_disclass}">					
							<div class="ft-title ft-title-large">
								<%-- <input type="hidden" name="category_no[]" value="${cate.getCategory_no()}" />
								<input type="hidden" name="category_id[]" value="${cate.getCategory_id()}" />
								<input type="hidden" name="category_show[]" value="${cate.getCategory_show()}" />
								<input type="hidden" name="category_depth[]" value="${cate.getCategory_depth()}" />
								<input type="hidden" name="category_name[]" value="${cate.getCategory_name()}" />
								<input type="hidden" name="category_image[]" value="${cate.getCategory_image()}" /> --%>
								<option class="name" >${cate.getCategory_name()}${show_big_disshow}</option>${show_big_count}							
							</div>
							


							<c:if test="${!empty cate.getSub_category()}">
							<!-- 중 카테고리 반복 -->
							<ul class="sort-list" id="sort-list-${cate.getCategory_id()}" group="${cate.getCategory_id()}">
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
								<li class="${show_sub_disclass}">
									<div class="ft-title">
<%--									<input type="hidden" name="category_id[]" value="${subc.getCategory_id()}" />
										<input type="hidden" name="category_show[]" value="${subc.getCategory_show()}" />
										<input type="hidden" name="category_depth[]" value="${subc.getCategory_depth()}" />
										<input type="hidden" name="category_name[]" value="${subc.getCategory_name()}" /> --%>
										<option class="name">--${subc.getCategory_name()}${show_sub_disshow}</option>
									</div>
									
								</li>
								</c:forEach>
							</ul>
							</c:if>
						</li>
						</c:forEach>
						</select>
                        
                     </div>
                      
                     <form action="<%=request.getContextPath()%>/${tag}" method="get">
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
                          <input type="text" name="ficnic_no" id="goods_code" value="" class="form-control w-30" onkeydown="EngNumInput(this);">
                      </div>
                      <div class="w-100"></div>
                      <div class="form-group col">
                          <label for="goods_name"><span>*</span> 피크닉 이름</label>
                          <input type="text" name="ficnic_name" id="goods_name" value="" class="form-control">
                      </div>
                      <c:if test="${!empty m }">
	                      <div class="w-100"></div>
	                      <div class="form-group col-sm">
	                          <label for="goods_in_price">이전 판매가</label>
	                          <input type="text" name="ficnic_market_price" id="goods_in_price" value="" maxlength="11" class="form-control text-right w-40" onkeydown="NumberInput(this);">원
	                      </div>
                      </c:if>
                      <div class="w-100"></div>
                      <div class="form-group col-sm">
                          <label for="goods_in_price">현재판매가</label>
                          <input type="text" name="ficnic_sale_price" id="goods_in_price" value="" maxlength="11" class="form-control text-right w-40" onkeydown="NumberInput(this);">원
                      </div>
                  </div>


                  <div class="collapse show" id="stock_layer">
                      <h4 class="view-limit">재고기준 (낱개)</h4>
                      <div class="row form mb-5 view-limit">
                          <div class="form-group col-sm">
                              <label for="goods_ea_out">아웃박스</label>
                              <input type="text" name="goods_ea_out" id="goods_ea_out" value="" maxlength="8" class="form-control text-center w-30" onkeydown="NumberInput(this);">개
                          </div>
                          <div class="form-group col-sm">
                              <label for="goods_ea_in">인박스</label>
                              <input type="text" name="goods_ea_in" id="goods_ea_in" value="" maxlength="8" class="form-control text-center w-30" onkeydown="NumberInput(this);">개
                          </div>
                          <p class="text-danger p-0 mt-1"><i class="fa fa-lightbulb-o"></i> 낱개 기준 수량을 입력해주세요.</p>
                          <p class="text-success p-0"><i class="fa fa-lightbulb-o"></i> 입력 예) 인박스 1박스 = 낱개 50개 / 아웃박스 1박스 = 낱개 1,000개 (인박스 20박스)</p>
                      </div>
                  </div>



                  <div class="collapse" id="ea_layer">
                      <h4 class="view-limit">단일재고</h4>
                      <div class="row form mb-5 view-limit">
                          <div class="form-group col-sm">
                              <label for="goods_ea_total">재고수량</label>
                              <input type="text" name="goods_ea_total" id="goods_ea_total" value="" maxlength="8" class="form-control text-center w-20" onkeydown="NumberInput(this);">개
                          </div>
                      </div>
                  </div>



                  <h4 class="view-limit">추가정보</h4>
                  <div class="row form view-limit">
                      <div class="form-group col-sm collapse" id="boxtype_layer">
                          <label for="goods_boxtype">박스 타입</label>
                          <select id="goods_boxtype" name="goods_boxtype" class="form-control custom-select w-40">
                              <option value="">- 선택하세요 -</option>
                                                              <option value="13">블루본/어흥(2D)</option>
                                                              <option value="12">어흥(3D)/트라이</option>
                                                              <option value="11">사이영판(2D)</option>
                                                              <option value="10">사이영판(3D)</option>
                                                              <option value="8">카카오 94 (3D)</option>
                                                              <option value="7">카카오(2D)</option>
                                                              <option value="6">흔한남매</option>
                                                              <option value="5">아이바나리</option>
                                                              <option value="4">챔피온</option>
                                                              <option value="3">케이팝</option>
                                                              <option value="2">에어데이즈</option>
                                                              <option value="1">웰커버</option>
                                                          </select>
                      </div>
                      <div class="w-100"></div>

                      <div class="form-group col">
                          <label for="goods_photo">상품사진</label>
                          <input type="file" name="goods_photo" id="goods_photo" class="form-control w-50">
                      </div>
                                              <p class="text-primary p-0 mt-1"><i class="fa fa-lightbulb-o"></i> 이미지 파일을 업로드해 주세요 (.jpg, .jpeg, .gif, .png) 파일크기 최대 2MB</p>
                  </div>



                  <div class="view-limit mt-5 collapse" id="detail_layer">
                      <h4>상품 상세</h4>
                      <div>
                          <textarea name="goods_detail" class="form-control" rows="6"></textarea>
                      </div>
                  </div>
              </div>
              
		<div class="d-flex mt-2 input-form-button">
		    <div class="col-lg-3 pl-0 ml-0">
		            </div>
		    <div class="col-lg-6 text-center">
		        <button type="submit" class="btn btn-primary btn-lg" ><i class="fa fa-pencil"></i> 추가하기</button>    </div>
		    <div class="col-lg-3 text-right pr-0 mr-0"><a href="<%=request.getContextPath()%>/admin/ficnic/ficnic_list.do" class="btn btn-secondary btn-lg"><i class="fa fa-bars"></i> 목록보기</a></div>
		</div>                	
	</div>
	</form>

<%@ include file="../layout/layout_footer.jsp" %>