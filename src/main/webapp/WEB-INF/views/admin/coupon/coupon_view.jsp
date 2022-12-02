<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="layout_none" value="Y" />
<%@ include file="../layout/layout_header.jsp" %>



<h2>쿠폰 정보 보기</h2>


<div class="page-cont">

    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>쿠폰 기본 정보</h4>
                    <div class="row form">
                        <div class="form-group col d-flex align-items-center mb-2">
                            <label>쿠폰 이름</label>
                            <div class="px-3">카테고리 쿠폰</div>
                        </div>

                        <div class="w-100 border-bottom"></div>

                        <div class="form-group col d-flex align-items-center">
                            <label>사용 구분</label>
                            <div class="px-3">카테고리</div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group join-form">
                            <label>사용 카테고리</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pb-2">
                                        <ul class="list-view">
                                            <li>아웃도어</li>
                                            <li>피트니스</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group col d-flex align-items-center">
                            <label>최대 발행 갯수</label>
                            <div class="px-3 engnum">100</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>




    <div class="row mb-3">
        <div class="col">
            <div class="card view-form">
                <div class="card-body p-4">
                    <h4>쿠폰 할인 정보</h4>

                    <div class="row form">
                        <div class="form-group col d-flex align-items-center">
                            <label>할인 금액</label>
                            <div class="px-3 engnum">10%</div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group col d-flex align-items-center mb-2">
                            <label>최소 사용 금액</label>
                            <div class="px-3 engnum">15,000원</div>
                        </div>
                        <div class="form-group col d-flex align-items-center mb-2">
                            <label>최대 할인 금액</label>
                            <div class="px-3 engnum">3,000원</div>
                        </div>

                        <div class="w-100 border-bottom"></div>

                        <div class="form-group col d-flex align-items-center">
                            <label>사용 기간</label>
                            <div class="px-3 engnum">2022/12/01 00:00:00 ~ 2022/12/31 23:59:59</div>
                        </div>
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



<%@ include file="../layout/layout_footer.jsp" %>