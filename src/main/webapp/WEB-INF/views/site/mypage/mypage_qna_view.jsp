<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_qna.css" />
<script language="javascript" src="${path}/resources/site/js/js_qna.js"></script>

<% pageContext.setAttribute("newLine", "\n"); %>

<c:set var="mypage_eng" value="qna" />
<c:set var="mypage_kor" value="내 1:1 문의 확인" />
<c:set var="dto" value="${dto}" />
<c:set var="cdto" value="${cdto}" />
<c:set var="fdto" value="${fdto}" />

<%@ include file="../layout/layout_mymenu.jsp" %>



<div class="contents w1100 mypage-qna">

    <!-- 기본 정보 //START -->
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
			                <p><b>${fdto.getFicnic_name() }</b></p>
			                <p class="engnum"><fmt:formatNumber value="${fdto.getFicnic_sale_price() }" />원</p>	                        
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
    <!-- 기본 정보 //END -->



    <!-- 내용 //START -->
    <div class="row rv-body">
        <div class="col-lg mb-5">
            <table class="table-form">
                <colgroup>
                    <col width="17%" />
                    <col />
                </colgroup>

                <tbody>
                    <tr>
                        <th>제목</th>
                        <td>${dto.getQna_title() }</td>
                    </tr>
                    <tr> 
                        <th>내용</th>
                        <td>${dto.getQna_cont().replace(newLine, "<br />")}
                        <c:if test="${!empty dto.getQna_file1() or !empty dto.getQna_file2()}"><div class="w-100 border-bottom"></div></c:if>
                        <c:if test="${!empty dto.getQna_file1()}">
                        <div class="form-group join-form">
                            <label>첨부파일 1</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2"><img src="${path}${dto.getQna_file1()}" style="max-width: 100%;" alt="" /></div>
                                </div>
                            </div>
                        </div>
                        </c:if>

                        <c:if test="${!empty dto.getQna_file2()}">
                        <div class="form-group join-form">
                            <label>첨부파일 2</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pt-1 pb-2"><img src="${path}${dto.getQna_file2()}" style="max-width: 100%;" alt="" /></div>
                                </div>
                            </div>
                        </div>
                        </c:if>
                        
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 내용 //END -->


    <!-- 댓글 목록 //START -->
    <div class="row rv-body">
        <div class="col-lg mb-5">
            <h4>답변 목록</h4>
               <table class="table-list">
                        <thead>
                            <tr>
                                <th style="width: 15%; min-width: 120px;">작성자</th>
                                <th>내용</th>
                                <th style="width: 17%; min-width: 120px;">작성일</th>
                            </tr>
                        </thead>

                        <tbody id="comment-list">
                        	<c:if test="${!empty cdto}">
                        	<c:forEach items="${cdto}" var="cdto">
                            <tr id="comment-${cdto.getComment_no()}">
                                <td>
                                	<p><b>${cdto.getComment_writer_name()}</b></p>
                                </td>
                                <td class="text-left pl-4">${cdto.getComment_content().replace(newLine, "<br />")}</td>
                                <td>
                                	<p class="engnum">${cdto.getComment_date().substring(0,10)}<br />${cdto.getComment_date().substring(11)}</p>
                            		<button type="button" class="btn btn-sm btn-outline-danger mt-1 px-1 py-0 qnaDeleteBtn" name="comment_no" value="${cdto.getComment_no()}"><i class="fa fa-trash-o"></i> 삭제</button>
                                </td>
                            </tr>
                            </c:forEach>
                            </c:if>

                            <c:if test="${empty cdto}">
                            <tr>
                            	<td colspan="3" class="nodata">댓글이 없습니다.</td>
                            </tr>
                            </c:if>
                        </tbody>
            </table>


            <table class="comment-write">
             	<colgroup>
                    <col width="120" />
                    <col />
                    <col width="120" />
             	</colgroup>
			    <tr> 
                   <td>
                       <p><b>댓글 쓰기</b></p>
						<input type="hidden" id="qna_no" name="qna_no" value="${param.no}" />
						<input type="hidden" id="member_id" name="member_id" value="${sess_id }" />
						<input type="hidden" id="comment_writer_name" name="comment_writer_name" value="${sess_name }" />						
                    </td>
					<td><textarea name="comment_contentOk" class="comment_contentOk" id="comment_contentOk" cols="20" rows="3" ></textarea></td>
                    <td><button type="button" class="btn btn-lg btn-primary rounded-0 qnaWriteBtn" id="qnaWriteBtn" style="padding: .94rem 1.1rem;"><i class="fa fa-pencil"></i> 댓글 쓰기</button></td>
			    </tr> 
	   		</table>
	   			
        </div>
    </div>
    <!-- 내용 //END -->




    <!-- 버튼 //START -->
	<div class="qv-btn">
        <a href="${path}/mypage/mypage_qna_deleteOk.do?qna_no=${dto.getQna_no()}" class="delete" onClick="return confirm('정말 삭제하시겠습니까?');">삭제하기</a>
        <a href="${path}/mypage/mypage_qna_modify.do?qna_no=${dto.getQna_no()}" class="modify">수정하기</a>
        <a href="${path}/mypage/mypage_qna_list.do" class="list">목록보기</a>
    </div>
    <!-- 버튼 //END -->
    

</div>



<%@ include file="../layout/layout_footer.jsp" %>