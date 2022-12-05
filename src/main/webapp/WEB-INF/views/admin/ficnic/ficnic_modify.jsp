<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/layout_header.jsp" %>

<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>피크닉 목록</h2>
        <ol class="m-0 p-2">
            <li>피크닉 관리</li>
            <li><b>상품 수정</b></li>
        </ol>
    </div>
</div>

<div class="page-cont">
<div class="card-body p-4">
                    <h4 class="view-limit">기본 정보</h4>
                    <div class="row form mb-5 view-limit">
                        <div class="form-group col">
                            <label>노출 여부</label>
                                                        <div class="btn-group mt-2" role="group" data-toggle="buttons">
                                <label class="btn btn-outline-secondary active">
                                    <input type="radio" name="goods_show" value="Y" checked="checked"><i class="fa fa-eye"></i> 노출
                                </label>
                                <label class="btn btn-outline-secondary">
                                    <input type="radio" name="goods_show" value="N"> <i class="fa fa-eye-slash"></i> 숨김
                                </label>
                            </div>
                                                    </div>
                        <div class="w-100 border-bottom mt-2"></div>

                        <div class="form-group col">
                            <label>품목 구분</label>
                                                        <div class="btn-group mt-2" role="group" data-toggle="buttons">
                                <label class="btn btn-outline-secondary active" onclick="$('#stock_layer, #boxtype_layer').collapse('show'); $('#detail_layer, #ea_layer').collapse('hide');">
                                    <input type="radio" name="goods_cate" value="goods" checked="checked"><i class="fa fa-star-o"></i> 일반상품
                                </label>
                                <label class="btn btn-outline-secondary" onclick="$('#stock_layer, #detail_layer, #boxtype_layer, #ea_layer').collapse('hide');">
                                    <input type="radio" name="goods_cate" value="none"> <i class="fa fa-ellipsis-h"></i> 무형상품
                                </label>
                                <label class="btn btn-outline-secondary" onclick="$('#stock_layer, #boxtype_layer').collapse('hide'); $('#detail_layer, #ea_layer').collapse('show');">
                                    <input type="radio" name="goods_cate" value="pay"> <i class="fa fa-money"></i> 결제전용
                                </label>
                            </div>
                                                    </div>
                        <div class="w-100"></div>
                        <div class="form-group col">
                            <label for="goods_code"><span>*</span> 품목코드</label>
                            <input type="text" name="goods_code" id="goods_code" value="" class="form-control w-30" onkeydown="EngNumInput(this);">
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col">
                            <label for="goods_name"><span>*</span> 품목명</label>
                            <input type="text" name="goods_name" id="goods_name" value="" class="form-control">
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col-sm">
                            <label for="goods_in_price">입고단가</label>
                                                        <input type="text" name="goods_in_price" id="goods_in_price" value="" maxlength="11" class="form-control text-right w-40" onkeydown="NumberInput(this);">원
                        </div>
                        <div class="form-group col-sm">
                            <label for="goods_out_price">출고단가</label>
                            <input type="text" name="goods_out_price" id="goods_out_price" value="" maxlength="11" class="form-control text-right w-40" onkeydown="NumberInput(this);">원
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
				        <button type="button" class="btn btn-primary btn-lg" ><i class="fa fa-pencil"></i> 추가하기</button>    </div>
				    <div class="col-lg-3 text-right pr-0 mr-0"><a href="<%=request.getContextPath()%>/admin/ficnic/ficnic_list.do" class="btn btn-secondary btn-lg"><i class="fa fa-bars"></i> 목록보기</a></div>
				</div>  
</div>

<%@ include file="../layout/layout_footer.jsp" %>