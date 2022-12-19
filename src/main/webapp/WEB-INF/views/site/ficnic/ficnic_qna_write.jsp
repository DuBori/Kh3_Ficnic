<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_qna.css" />
<script language="javascript" src="${path}/resources/site/js/js_ficnic.js"></script>



<div class="page-info w1100">
    <h2>1:1 문의하기</h2>
    <ol>
        <li><a href="${path}/"><i class="icon-home"></i> HOME</a></li>
        <li>피크닉</li>
        <li>${fdto.getFicnic_name() }</li>
        <li><b>1:1 문의하기</b></li>
    </ol>
</div>



<div class="contents w1100 ficnic-qna">

		<form name="form_input" method="post" enctype="multipart/form-data" action="${path}/ficnic/mypage_qna_writeOk.do">
		<input type="hidden" value="${fdto.getFicnic_no() }" name="ficnic_no">
		<div class="input-group flex-nowrap">
		  <textarea placeholder="제목" class="ProductQnaRegisterPage__TextArea-vv74rv-2 dCffyLn" aria-describedby="addon-wrapping" name="qna_title" id="qna_title" required></textarea>		
		</div>
		
		<div class="Fade__Wrapper-sc-1s0ipfq-0 koasSX" style="opacity: 1; display: block;">
			
			<textarea placeholder="연락처를 포함한 개인정보를 남기거나 요청하는 등
직거래 이용 문의는 현장결제로 간주하여 사전안내 없이 삭제 및 이용이 제한될 수 있습니다.
 - 결제, 환불 등 서비스 문의 : 카카오톡 채널 @frip" name="qna_cont" class="ProductQnaRegisterPage__TextArea-vv74rv-2 dCffyL" required></textarea>
		       
		        <div class="fileDiv">
	            <label for="board_list_num">첨부 파일 #1</label>
		            <div class="">
			            <div class="">
				            <div class="">
				            	<input type="file" name="qna_file_modi1" class="form-control" accept="image/jpeg, image/png, image/gif" />
				            </div>
			            </div>
		            </div>
	            </div>
	            
	            <div class="fileDiv">
	            <label for="board_list_num">첨부 파일 #2</label>
		            <div class="jf-input">
			            <div class="">
				            <div class="">
				            	<input type="file" name="qna_file_modi2" class="form-control" accept="image/jpeg, image/png, image/gif" />
				            </div>
			            </div>
		            </div>
	            </div>
			<div class="d-grid gap-2">
			  <button class="btn btn-primary writeBtn" type="submit" font-size="15px" type="submit">등록하기</button>
			</div>	            
		</div>
		</form>

</div>



<%@ include file="../layout/layout_footer.jsp" %>