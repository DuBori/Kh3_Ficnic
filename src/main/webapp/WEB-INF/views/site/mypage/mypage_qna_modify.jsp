<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_mypage.css" />
<script language="javascript" src="${path}/resources/site/js/js_mypage.js"></script>


<c:set var="mypage_eng" value="reserv" />
<c:set var="mypage_kor" value="피크닉 예약 정보" />


<%@ include file="../layout/layout_mymenu.jsp" %>



<div class="contents w1100 mypage-qna-modify">



			<form name="form_input" method="post" enctype="multipart/form-data" action="${path}/site/mypage/mypage_qna_modifyOk.do">
			<input type="hidden"  value="${dto.getQna_no()}">
			<table>
			<tr>	
			<td>
            <label for="review_name">작성자 이름</label>
            <input type="text" name="review_name" id="qna_name" value="${dto.getQna_name()}" maxlength="30" class="form-control-plaintext w-100" readonly="readonly" />
			</td>
			</tr>
			
			<tr>
			<td>
				<label for="review_cont" style="padding: 60px 0;">리뷰 내용</label>
                <textarea name="qna_cont" id="review_cont" cols="20" rows="5" class="form-control">${dto.getQna_cont()}</textarea>
			</td>
			</tr>
			
			<tr> 
			<td>			
            <div class="form-group join-form">
            <label for="board_list_num">첨부 파일 #1</label>
            <div class="jf-input">
            <div class="row">
            <div class="col pb-2">
            <input type="file" name="review_photo_modi1" class="form-control" accept="image/jpeg, image/png, image/gif" />
            <p class="mt-2"><img src="${path}${dto.getQna_file1()}" style="max-width: 400px;" alt="" /></p>
            <input type="hidden" name="ori_qna_file1" value="${dto.getQna_file1()}" />
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
            <input type="file" name="review_photo_modi1" class="form-control" accept="image/jpeg, image/png, image/gif" />
            <p class="mt-2"><img src="${path}${dto.getQna_file2()}" style="max-width: 400px;" alt="" /></p>
            <input type="hidden" name="ori_qna_file2" value="${dto.getQna_file2()}" />
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