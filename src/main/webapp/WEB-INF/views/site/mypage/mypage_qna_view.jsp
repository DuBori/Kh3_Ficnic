<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<c:if test="${empty sess_id}"><script type="text/javascript">alert('회원 로그인이 필요합니다.'); location.href='${path}/member/member_login.do';</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_mypage.css" />
<script language="javascript" src="${path}/resources/site/js/js_mypage.js"></script>

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
                    <tr>
                        <th>작성일자</th>
                        <td class="eng">${dto.getQna_date() }</td>
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


    <!-- 답변 목록 //START -->
    <div class="row rv-body">
        <div class="col-lg mb-5">
            <h4>답변 목록</h4>

            <table class="table-form comment-list">
                <colgroup>
                    <col width="18%" />
                    <col />
                    <col width="15%" />
                    <col width="15%" />
                </colgroup>	

                <c:choose>
                <c:when test="${!empty cdto }">
                <thead>
                    <tr>
                        <th class="text-center">작성자</th>
                        <th class="text-center">내용</th>
                        <th class="text-center">작성일</th>
                        <th class="text-center">기능</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach items="${cdto}" var="cdto">
                    <tr>
                    	<c:choose>
                    	<c:when test="${dto.getMember_id() == cdto.getMember_id() }">
                        <td class="text-center"><b>${cdto.getComment_writer_name() }</b></td>
                        </c:when>
                        <c:otherwise>
                        <td class="text-center text-danger"><b>관리자</b></td>
                        </c:otherwise>
                        </c:choose>
                        <td class="text-left">${cdto.getComment_content() }</td>
                        <td class="text-center eng">${cdto.getComment_date() }</td>
                        <c:choose>
                        <c:when test="${dto.getMember_id() == cdto.getMember_id() }">
                       	<td class="text-center">
                			<a href="${path}/site/mypage/mypage_qna_comment_deleteOk.do?comment_no=${cdto.getComment_no() }&qna_no=${dto.getQna_no() }" onclick="return confirm('정말 삭제하시겠습니까?');" class="delbtn">삭제</a>
            			</td>
                        </c:when>
                        <c:otherwise>
  						<td class="text-center"></td>
                        </c:otherwise>
                        </c:choose>
                    </tr>
                    </c:forEach>
                </tbody>
                </c:when>
                
                <c:otherwise>
                <tbody>
                    <tr>
                        <td colspan="4" class="nodata">답변 내역이 없습니다.</td>
                    </tr>
                </tbody>
                </c:otherwise>
                </c:choose>
            </table>


            <form name="write_form" method="post" action="${path}/site/mypage/mypage_qna_commentOk.do?no=${dto.getQna_no()}">
            <table class="table-form comment-write">
             	<colgroup>
                    <col width="120" />
                    <col />
                    <col width="120" />
             	</colgroup>
			    <tr> 
			        <th>댓글 쓰기</th>										
					<td><textarea name="comment_content" cols="20" rows="3" required></textarea></td>
                    <td><button type="submit"><i class="fa fa-pencil"></i> 쓰기</button></td>
			    </tr> 
	   		</table>
	   		</form>
	   			
        </div>
    </div>
    <!-- 내용 //END -->




    <!-- 버튼 //START -->
        <a href="${path}/site/mypage/mypage_qna_deleteOk.do?qna_no=${dto.getQna_no()}" class="delete" onClick="return confirm('정말 삭제하시겠습니까?');">삭제하기</a>
        <a href="${path}/site/mypage/mypage_qna_modify.do?qna_no=${dto.getQna_no()}" class="modify">수정하기</a>
        <a href="${path}/mypage/mypage_qna_list.do">목록보기</a>
    <!-- 버튼 //END -->
    

</div>



<%@ include file="../layout/layout_footer.jsp" %>