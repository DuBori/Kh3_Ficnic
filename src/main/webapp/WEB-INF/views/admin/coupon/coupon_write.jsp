<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/layout_header.jsp" %>
<script type="text/javascript">$("#header .navbar .nav-item:nth-child(4)").addClass("active");</script>



<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>쿠폰 등록</h2>
        <ol class="m-0 p-2">
            <li>쿠폰 관리</li>
            <li><b>쿠폰 등록</b></li>
        </ol>
    </div>
</div>




<form name="form_input" method="post" action="<%=request.getContextPath() %>/admin/coupon/coupon_write_ok.do">
<div class="page-cont">
    <div class="row">
        <div class="col-lg mb-4">
            <div class="card input-form">
                <div class="card-body p-4">
                    <h4 class="view-limit">쿠폰 기본 정보</h4>
                    <div class="row form mb-5 view-limit">
                        <div class="form-group col mb-2">
                            <label for="coupon_name">쿠폰 이름</label>
                            <input type="text" name="coupon_name" id="coupon_name" maxlength="30" class="form-control w-100" required />
                        </div>

                        <div class="w-100 border-bottom"></div>

                        <div class="form-group col">
                            <label for="coupon_use_type">사용 구분</label>
                            <div class="btn-group mt-2" role="group" data-toggle="buttons">
                                <label class="btn btn-outline-secondary active" onclick="$('#category_layer, #goods_layer').collapse('hide');">
                                    <input type="radio" name="coupon_use_type" value="cart" checked="checked" /> 장바구니
                                </label>
                                <label class="btn btn-outline-secondary" onclick="$('#category_layer').collapse('show'); $('#goods_layer').collapse('hide');">
                                    <input type="radio" name="coupon_use_type" value="category" /> 카테고리
                                </label>
                                <label class="btn btn-outline-secondary" onclick="$('#goods_layer').collapse('show'); $('#category_layer').collapse('hide');">
                                    <input type="radio" name="coupon_use_type" value="goods" /> 상품지정
                                </label>
                            </div>
                        </div>

                        <div class="px-0 collapse hide" id="category_layer">
                            <div class="w-100"></div>
                            <div class="form-group join-form">
                                <label>사용 카테고리</label>
                                <div class="jf-input">
                                    <div class="row">
                                        <div class="col pb-2">
                                            <button type="button" class="btn btn-sm btn-outline-info">카테고리 지정</button>
                                            <ul class="list-box">
                                                <li><input type="hidden" name="coupon_category_value" value="10000000" />아웃도어<button type="button"><i class="fa fa-times"></i></button></li>
                                                <li><input type="hidden" name="coupon_category_value" value="15000000" />피트니스<button type="button"><i class="fa fa-times"></i></button></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="px-0 collapse hide" id="goods_layer">
                            <div class="w-100"></div>
                            <div class="form-group join-form">
                                <label>사용 상품</label>
                                <div class="jf-input">
                                    <div class="row">
                                        <div class="col pb-2">
                                            <button type="button" class="btn btn-sm btn-outline-success">상품 지정</button>
                                            <ul class="list-box">
                                                <li><input type="hidden" name="coupon_category_value" value="01020000" />테스트 상품<button type="button"><i class="fa fa-times"></i></button></li>
                                                <li><input type="hidden" name="coupon_category_value" value="01100000" />테2스2트2 상품<button type="button"><i class="fa fa-times"></i></button></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group col">
                            <label for="coupon_max_ea">최대 발행 갯수</label>
                            <input type="text" name="coupon_max_ea" id="coupon_max_ea" maxlength="11" class="form-control text-center w-15" onkeydown="NumberInput(this);" /> 개
                        </div>
                        <div class="w-100"></div>
                    </div>



                    <h4 class="view-limit">쿠폰 할인 정보</h4>
                    <div class="row form mb-4 view-limit">
                        <div class="form-group join-form">
                            <label>할인 금액</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pb-2">
                                        <input type="text" name="coupon_price" id="coupon_price" maxlength="11" class="form-control d-inline text-center w-30" onkeydown="NumberInput(this);" required />
                                        <select id="coupon_price_type" name="coupon_price_type" class="custom-select w-25">
                                            <option value="price">금액 (원)</option>
                                            <option value="percent">할인률 (%)</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group col mb-2">
                            <label for="coupon_price_over">최소 사용 금액</label>
                            <input type="text" name="coupon_price_over" id="coupon_price_over" maxlength="11" class="form-control text-center w-30" onkeydown="NumberInput(this);" /> 원
                        </div>
                        <div class="form-group col mb-2">
                            <label for="coupon_price_max">최대 할인 금액</label>
                            <input type="text" name="coupon_price_max" id="coupon_price_max" maxlength="11" class="form-control text-center w-30" onkeydown="NumberInput(this);" /> 원
                        </div>

                        <div class="w-100 border-bottom"></div>

                        <div class="form-group join-form">
                            <label for="coupon_date_type" class="pt-3">사용 기간</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col">
                                        <div class="btn-group" role="group" data-toggle="buttons">
                                            <label class="btn btn-outline-secondary active" onclick="$('#after_layer, #date_layer').collapse('hide');">
                                                <input type="radio" name="coupon_date_type" value="free" checked="checked" /> 무제한
                                            </label>
                                            <label class="btn btn-outline-secondary" onclick="$('#after_layer').collapse('show'); $('#date_layer').collapse('hide');">
                                                <input type="radio" name="coupon_date_type" value="after" /> 발급후 며칠까지
                                            </label>
                                            <label class="btn btn-outline-secondary" onclick="$('#after_layer').collapse('hide'); $('#date_layer').collapse('show');">
                                                <input type="radio" name="coupon_date_type" value="date" /> 기간설정
                                            </label>
                                        </div>

                                        <div class="px-0 pt-1 pb-2 collapse hide" id="after_layer">
                                            발급 후 <input type="text" name="coupon_date_valueCheck" maxlength="3" class="form-control d-inline mx-2 text-center w-15" onkeydown="NumberInput(this);" /> 일까지 사용 가능
                                        </div>

                                        <div class="px-0 pt-1 pb-2 collapse hide" id="date_layer">
                                            <div class="col-5 d-inline-block px-0">
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                    <input type="text" name="coupon_start_date" id="startDt" class="form-control text-center eng" />
                                                </div>
                                            </div>
                                            <div class="d-inline-block pt-2 px-2">~</div>
                                            <div class="col-5 d-inline-block px-0">
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                    <input type="text" name="coupon_end_date" id="endDt" class="form-control text-center eng" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




<div class="d-flex mt-2 input-form-button">
    <div class="col-lg text-center">
        <a href="<%=request.getContextPath()%>/admin/coupon/coupon_list.do?search_type=${param.search_type}&search_name=${param.search_name}&page=${param.page}" class="btn btn-secondary btn-lg m-2"><i class="fa fa-bars"></i> 목록보기</a>
        <button type="submit" class="btn btn-primary btn-lg m-2"><i class="fa fa-pencil"></i> 등록하기</button>
    </div>
</div>
</form>





<%@ include file="../layout/layout_footer.jsp" %>