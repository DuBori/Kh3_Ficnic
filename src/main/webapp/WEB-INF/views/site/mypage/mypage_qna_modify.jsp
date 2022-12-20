<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_qna.css" />
<script language="javascript" src="${path}/resources/site/js/js_qna.js"></script>


<c:set var="mypage_eng" value="qna" />
<c:set var="mypage_kor" value="내 1:1 문의 내역" />


<%@ include file="../layout/layout_mymenu.jsp" %>



<div class="contents w1100 mypage-qna-modify">

    <!-- 피크닉 정보 //START -->
    <div class="row rv-body">
        <div class="col-lg mb-5">
            <table class="table-form">
                <colgroup>
                    <col width="10%" />
                    <col width="32%" />
                    <col width="17%" />
                    <col />
                </colgroup>

                <tbody>
                    <tr>
                        <th>피크닉정보</th>
                        <td colspan="2" class="tdImg">
						    <c:choose>
						    <c:when test="${!empty fdto.getFicnic_photo1() }"><img src="${path}${fdto.getFicnic_photo1()}" alt="" class="qnaImg"/></c:when>
						    <c:otherwise><span class="noimg">no img</span></c:otherwise>
						    </c:choose>                        
			                <p><b>${fdto.getFicnic_name() }</b><span class="engnum"><fmt:formatNumber value="${fdto.getFicnic_sale_price() }" />원</span></p>
                        </td>
                    </tr>
                    <tr>
                        <th>작성일자</th>
                        <td class="engnum" colspan="2">${dto.getQna_date() }</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 피크닉 정보 //END -->

		
		


    <!-- 수정 정보 //START -->
		<form name="form_input" method="post" enctype="multipart/form-data" action="${path}/mypage/mypage_qna_modifyOk.do">
		<input type="hidden"  name="qna_no" value="${dto.getQna_no()}">
		
		<div class="input-group flex-nowrap">
		<textarea class="ProductQnaRegisterPage__TextArea-vv74rv-2 dCffyLn" aria-describedby="addon-wrapping" name="qna_title" id="qna_title" required>${dto.getQna_title() }</textarea>		
		</div>
		
		<div class="Fade__Wrapper-sc-1s0ipfq-0 koasSX" style="opacity: 1; display: block;">
			
		<textarea name="qna_cont" class="ProductQnaRegisterPage__TextArea-vv74rv-2 dCffyL" required>${dto.getQna_cont() }</textarea>
           
	    <!-- 피크닉 정보 //START -->
	    <div class="row rv-body">
	        <div class="col-lg mb-5">
	            <table class="table-form">
	                <colgroup>
	                    <col width="10%" />
	                    <col width="32%" />
	                    <col width="17%" />
	                    <col />
	                </colgroup>
	
	                <tbody>
	                    <tr>
	                        <th>첨부 파일 1#</th>
	                        <td colspan="2">
                            <div class="jf-input">
                                <div class="row">
                                	<c:if test="${!empty dto.getQna_file1()}">
                                	<div class="col-auto pb-2 pr-0"><a href="${path}${dto.getQna_file1()}" target="_blank"><img src="${path}${dto.getQna_file1()}" alt="" width="78" height="78" /></a></div>
                                	</c:if>
                                    <div class="col pb-2">
                                        <input type="file" name="qna_file_modi1" class="form-control" accept="image/jpeg, image/png, image/gif" />
                                        <c:if test="${!empty dto.getQna_file1()}">
                                            <button type="button" class="btn btn-sm btn-outline-danger mt-1" onclick="delQnaPhoto(this, '${dto.getQna_no()}', 1);"><i class="fa fa-trash-o"></i> 등록된 이미지 삭제</button>
                                            <input type="hidden" name="ori_qna_file1" value="${dto.getQna_file1()}" />
                                        </c:if>
                                    </div>
                                </div>
                            </div>
							</td>
	                    </tr>
	                    <tr>
	                        <th>첨부 파일 2#</th>
	                        <td colspan="2">
                            <div class="jf-input">
                                <div class="row">
                                	<c:if test="${!empty dto.getQna_file2()}">
                                	<div class="col-auto pb-2 pr-0"><a href="${path}${dto.getQna_file2()}" target="_blank"><img src="${path}${dto.getQna_file2()}" alt="" width="78" height="78" /></a></div>
                                	</c:if>
                                    <div class="col pb-2">
                                        <input type="file" name="qna_file_modi2" class="form-control" accept="image/jpeg, image/png, image/gif" />
                                        <c:if test="${!empty dto.getQna_file2()}">
                                            <button type="button" class="btn btn-sm btn-outline-danger mt-1" onclick="delQnaPhoto(this, '${dto.getQna_no()}', 2);"><i class="fa fa-trash-o"></i> 등록된 이미지 삭제</button>
                                            <input type="hidden" name="ori_qna_file2" value="${dto.getQna_file2()}" />
                                        </c:if>
                                    </div>
                                </div>
                            </div>
	                        </td>
	                    </tr>
	                </tbody>
	            </table>
	        </div>
	    </div>
	    <!-- 피크닉 정보 //END -->
	            
	            
	            
	            
			<div class="d-grid gap-2">
			  <button class="btn btn-primary writeBtn" type="submit" font-size="15px" type="submit">수정하기</button>
			</div>	            
		</div>
		</form>
    <!-- 수정 정보 //END -->




</div>



<%@ include file="../layout/layout_footer.jsp" %>