<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_mypage.css" />
<script language="javascript" src="${path}/resources/site/js/js_mypage.js"></script>


<c:set var="mypage_eng" value="qna" />
<c:set var="mypage_kor" value="내 1:1 문의 내역" />


<%@ include file="../layout/layout_mymenu.jsp" %>



<div class="contents w1100 mypage-qna-modify">



			<form name="form_input" method="post" enctype="multipart/form-data" action="${path}/site/mypage/mypage_qna_writeOk.do">
			<table>
			<tr>	
			<td>
            <label for="qna_title">제목</label>
            <input type="text" name="qna_title" id="qna_title" value="" maxlength="30" class="form-control-plaintext w-100" />
			</td>
			</tr>
			
			<tr>
			<td>
				<label for="qna_cont" style="padding: 60px 0;">내용</label>
                <textarea name="qna_cont" id="qna_cont" cols="20" rows="5" class="form-control"></textarea>
			</td>
			</tr>
			
			<tr> 
			<td>			
            <div class="form-group join-form">
            <label for="board_list_num">첨부 파일 #1</label>
            <div class="jf-input">
            <div class="row">
            <div class="col pb-2">
            <input type="file" name="qna_file1" class="form-control" accept="image/jpeg, image/png, image/gif" />
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
            <input type="file" name="qna_file2" class="form-control" accept="image/jpeg, image/png, image/gif" />
            </div>
            </div>
            </div>
            </div>
			</td>
			</tr> 
			
			<tr>
			<td>
				<button class="btnJoin" type="submit">추가하기</button>
			</td>
			</tr>
			</table>
		</form>



</div>



<%@ include file="../layout/layout_footer.jsp" %>