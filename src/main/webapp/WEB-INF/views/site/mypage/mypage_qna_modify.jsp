<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_mypage.css" />
<script language="javascript" src="${path}/resources/site/js/js_mypage.js"></script>


<c:set var="mypage_eng" value="qna" />
<c:set var="mypage_kor" value="내 1:1 문의 내역" />


<%@ include file="../layout/layout_mymenu.jsp" %>



<div class="contents w1100 mypage-qna-modify">

		    <!-- 피크닉 정보 //START -->
		    <div class="row rv-body">
		        <div class="col-lg mb-5">
		            <table class="table-form">
		                <colgroup>
		                    <col width="17%" />
		                    <col width="32%" />
		                    <col width="17%" />
		                    <col />
		                </colgroup>
		
		                <tbody>
		                    <tr>
		                        <th>피크닉정보</th>
		                        <td colspan="2">
								    <c:choose>
								    <c:when test="${!empty fdto.getFicnic_photo1() }"><img src="${path}${fdto.getFicnic_photo1()}" alt="" width="80" /></c:when>
								    <c:otherwise><span class="noimg">no img</span></c:otherwise>
								    </c:choose>                        
					                <p><b>${fdto.getFicnic_name() }</b></p>
					                <p class="engnum"><fmt:formatNumber value="${fdto.getFicnic_sale_price() }" />원</p>	                        
		                        </td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
		    </div>
		    <!-- 피크닉 정보 //END -->



			<form name="form_input" method="post" enctype="multipart/form-data" action="${path}/mypage/mypage_qna_modifyOk.do">
			<input type="hidden"  name="qna_no" value="${dto.getQna_no()}">
			<table>
			<tr>	
			<td>
            <label for="qna_title" class="title">제목</label>
            <input type="text" name="qna_title" id="qna_title" value="${dto.getQna_title()}" maxlength="30" class="form-control-plaintext w-100" />
			</td>
			</tr>
			
			<tr>
			<td>
				<label for="qna_cont" style="padding: 60px 0;">내용</label>
                <textarea name="qna_cont" id="qna_cont" cols="20" rows="5" class="form-control">${dto.getQna_cont()}</textarea>
			</td>
			</tr>
			
			<tr> 
			<td>			
            <div class="form-group join-form">
            <label for="board_list_num">첨부 파일 #1</label>
            <div class="jf-input">
            <div class="row">
            <div class="col pb-2">
            <input type="file" name="qna_file_modi1" class="form-control" accept="image/jpeg, image/png, image/gif" />
            <c:if test="${!empty dto.getQna_file1()}">
            <p class="mt-2"><img src="${path}${dto.getQna_file1()}" style="max-width: 400px;" alt="" /></p>
            <input type="hidden" name="ori_qna_file1" value="${dto.getQna_file1()}" />
            </c:if>
            </div>
            </div>
            </div>
            </div>
			</td>
			</tr> 
			
			<tr> 
			<td>			
            <div class="form-group join-form">
            <label for="board_list_num">첨부 파일 #2</label>
            <div class="jf-input">
            <div class="row">
            <div class="col pb-2">
            <input type="file" name="qna_file_modi2" class="form-control" accept="image/jpeg, image/png, image/gif" />
            <c:if test="${!empty dto.getQna_file1()}">            
            <p class="mt-2"><img src="${path}${dto.getQna_file2()}" style="max-width: 400px;" alt="" /></p>
            <input type="hidden" name="ori_qna_file2" value="${dto.getQna_file2()}" />
            </c:if>
            </div>
            </div>
            </div>
            </div>
			</td>
			</tr> 
			
			<tr>
			<td>
				<button class="btnJoin" type="submit">수정하기</button>
			</td>
			</tr>
			</table>
		</form>



</div>



<%@ include file="../layout/layout_footer.jsp" %>