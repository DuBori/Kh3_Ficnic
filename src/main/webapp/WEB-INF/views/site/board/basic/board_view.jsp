<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../../layout/layout_header.jsp" %>


<div class="contents w1150">


<script type="text/javascript" >
	$(function() {
		
		/* 댓글 삭제 시 Ajax 처리*/
		$(document).on("click",".delbtn", function() {
			if($(".chk").val() !="c"){
				if (prompt('비밀번호를 입력하세요.') != $(".chk").val()){
					alert('비밀번호가 틀립니다.');
					return false;
				}
			}
			
		     $.ajax({
		         type : "post",
		         contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		         url : "<%=request.getContextPath()%>/board/baord_comment_delete.do",
		         data : {bcomm_no : $(this).attr("name"),
		        	 	 bbs_id : '${bbs_id}',
		        	 	 bdata_no : ${BoardConDto.getBdata_no()} },
		     	 datatype : "text",
		     success : function(data) {
		 		$("#commList").html("");
		 		$("#commList").html(data);
		 		$(".Logininput").val("");
		     },
		     error : function(data) {
		         alert("에러발생");
		     }
		 	});
		});
		
		/* 댓글 입력시 Ajax 처리 */
		$(".subbtn").on("click",function(){
         $.ajax({
	             type : "post",
	             contentType : "application/x-www-form-urlencoded;charset=UTF-8",
	             url : "<%=request.getContextPath()%>/board/baord_comment_insert.do",
	             data : $("#form1").serialize(),
             	 datatype : "text",
             success : function(data) {
         		$("#commList").html("");
         		$("#commList").html(data);
         		$(".Logininput").val(""); 		
             },
             error : function(data) {
                 alert(data);
             }
         });
		});
	});
</script>


<style type="text/css">
	
	.horizon{
		display: flex;
		justify-content: center;
		align-content: center;
	}
	#viewDiv{
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-content: center;
	}
	
</style>


<c:set  var="level_view" value="${boardConf.getBoard_level_view() }"/>
<c:choose>
	<c:when test="${level_view eq 'null'}">
		<c:set var="level" value="모든"/>
	</c:when>
	<c:when test="${level_view eq 'user'}">
		<c:set var="level" value="사이트"/>
	</c:when>
	<c:when test="${level_view eq 'admin' }">
		<c:set var="level" value="관리자"/>
	</c:when>
</c:choose>

<!-- #container // START -->
    <main id="container">
      <div class="w1280">
            <div class="page-info row mb-3">
                <div class="d-flex align-items-center justify-content-between">
                    <h2>공지사항</h2>
                    <ol class="m-0 p-2">
                        <li>게시판</li>
                        <li>공지사항</li>
                        <li><b>게시물 내용보기</b></li>
                    </ol>
             </div>
        </div>
       </div>
	<c:choose>
		<c:when test="${level_view ne 'null' and empty session_id  }">
			게시글 읽기 권한이 부족합니다.
		</c:when>
		<c:when test="${level_view eq 'admin' and session_id ne 'admin' }">
			게시글 읽기 권한이 부족합니다.
		</c:when>
		<c:otherwise>
			<div class="page-cont view-form" align="center">
			    <!-- 내용 //START -->
			    <!-- 해당 게시글 정보 -->
			    <div class="row vf-body">
			    	<div>
			    		<div>
			    			<h3>${BoardConDto.getBdata_title()}</h3>
			    		</div>	    			
		    			<div>
		    				<div>
		    					<p>${BoardConDto.getBdata_date()}</p>
		    					<p>${BoardConDto.getBdata_hit()}</p>	    					
		    				</div>			
		    				
		    				<div>
		    					<p>${BoardConDto.getBdata_writer_name() }(${BoardConDto.getBdata_writer_id()})</p>
		    					<p>표시이름 : 작성자</p>
		    				</div>
		    			</div>
		    			
		    			<!-- 게시글 첨부 링크 -->
		    			<div>
			    			<hr>
			    				<p>관련링크 #1 : : <c:if test="${!empty BoardConDto.getBdata_link1()}"><a href="${BoardConDto.getBdata_link1() }">${BoardConDto.getBdata_link1() }</a></c:if> </p>
			    			<hr>
			    				<p>관련링크 #2 : : <c:if test="${!empty BoardConDto.getBdata_link2()}"><a href="${BoardConDto.getBdata_link2() }">${BoardConDto.getBdata_link2() }</a></c:if> </p>
			    			<hr>		
			    		</div>
			    		
			    		<!-- 게시글 내용 -->
			    		<div>
			    			${BoardConDto.getBdata_cont() }
			    		</div>
			    		
			    		<!-- 파일 다운로드 부분 -->
			    		<div>
			    			<hr>
								<c:if test="${!empty BoardConDto.getBdata_file1() }"><p>첨부파일 #1 :<a href="<%=request.getContextPath()%>/site/board/board_download.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}&file=${BoardConDto.getBdata_file1()}">${BoardConDto.getBdata_file1() }</a></p></c:if>
								<c:if test="${!empty BoardConDto.getBdata_file2() }"><p>첨부파일 #2 :<a href="<%=request.getContextPath()%>/site/board/board_download.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}&file=${BoardConDto.getBdata_file2()}">${BoardConDto.getBdata_file2() }</a></p></c:if>
								<c:if test="${!empty BoardConDto.getBdata_file3() }"><p>첨부파일 #3 :<a href="<%=request.getContextPath()%>/site/board/board_download.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}&file=${BoardConDto.getBdata_file3()}">${BoardConDto.getBdata_file3() }</a></p></c:if>
								<c:if test="${!empty BoardConDto.getBdata_file4() }"><p>첨부파일 #4 :<a href="<%=request.getContextPath()%>/site/board/board_download.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}&file=${BoardConDto.getBdata_file4()}">${BoardConDto.getBdata_file4() }</a></p></c:if>
			    			<hr>
			    		</div>  		
			    	</div>
		    	</div>
		    </div>		
		

			<!-- 버튼 //START -->
			    <div class="d-flex justify-content-center mb-4" align="center">
			    	
			    	<!-- 관리자인 경우 || 자신의 게시글인 경우  ||자신의 게시글 x, 3자인 경우  -->
			    	<c:choose>
			    		<c:when test="${BoardConDto.getBdata_writer_id() eq session_id }">
			    			<a href="${path}/board/board_delete.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?\n되돌릴 수 없습니다.');"><i class="fa fa-trash-o"></i> 삭제하기</a>
			    			<a href="${path}/board/board_modify.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}" class="btn btn-primary mx-2"><i class="fa fa-pencil"></i> 수정하기</a>
			    			<a href="${path}/board/board_list.do?bbs_id=${BoardConDto.getBoard_id() }" class="btn btn-secondary"><i class="fa fa-bars"></i> 목록보기</a>
			    		</c:when>
			    		
			    		<c:when test="${'admin' eq session_id }">
			    		    <a href="${path}/board/board_delete.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?\n되돌릴 수 없습니다.');"><i class="fa fa-trash-o"></i> 삭제하기</a>                
			        		<a href="${path}/board/board_list.do?bbs_id=${BoardConDto.getBoard_id() }" class="btn btn-secondary"><i class="fa fa-bars"></i> 목록보기</a>
			    		</c:when>
			    		
			    		<c:when test="${!empty BoardConDto.getBdata_writer_id()}">
			    			<a href="${path}/board/board_delete.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?\n되돌릴 수 없습니다.');"><i class="fa fa-trash-o"></i> 삭제하기</a>
			    			<a href="${path}/board/board_modify.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}" class="btn btn-primary mx-2"><i class="fa fa-pencil"></i> 수정하기</a>
			    			<a href="${path}/board/board_list.do?bbs_id=${BoardConDto.getBoard_id() }" class="btn btn-secondary"><i class="fa fa-bars"></i> 목록보기</a>
			    		</c:when>
			    		
			    		<c:otherwise>
			    		<%-- <a href="${path}/board/board_delete.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?\n되돌릴 수 없습니다.');"><i class="fa fa-trash-o"></i> 삭제하기</a>
			    		<a href="${path}/board/board_modify.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}" class="btn btn-primary mx-2"><i class="fa fa-pencil"></i> 수정하기</a> --%>
			       		<a href="${path}/board/board_list.do?bbs_id=${BoardConDto.getBoard_id() }" class="btn btn-secondary"><i class="fa fa-bars"></i> 목록보기</a>
			    		</c:otherwise>
			    	</c:choose>
			    	</div>
			    	<!-- 버튼 //END -->
			    		<!-- 댓글 작업 시작 //START  -->
					<div align="center">
						<h5>댓글 </h5>
						<!-- 댓글 리스트 출력부 -->
						<c:if test="${!empty boardCommentList }">
							<div id="commList">
								<c:forEach items="${boardCommentList}" var="comment">
									
									<div class="horizon">
									
										<!-- 댓글 작성 계정 부분 -->
										<div>	
												<img alt="이미지 없음" src="">
												
												<div>
													<p>부서</p>
													<p>${comment.getBcomm_name() }</p>
												</div>
											</div>
											
											<div>
												<textarea rows="7" cols="25" readonly="readonly">${comment.getBcomm_cont() }</textarea>
											</div>
											
											<div>
												
												<div>
													<p>${comment.getBcomm_date() }</p>
												</div>
												
												<div>
												<!-- 자신의 댓글인 경우 || 관리자인 경우 || 자신의 댓글 x, 3자인 경우  -->
														<c:if test="${comment.getBcomm_id() eq session_id or session_id eq 'admin' }">
															<input type="hidden" value="c" class="chk">
															<input type="button" class="delbtn" value="삭제"  name="${comment.getBcomm_no() }">
														</c:if>
														<c:if test="${comment.getBcomm_id() eq 'trash'  }">
															<input type="hidden" value="${comment.getBcomm_pw() }" class="chk">
															<input type="button" class="delbtn" value="삭제" name="${comment.getBcomm_no()}">
														</c:if>
												</div>
											</div>
									</div>			
								</c:forEach>
							
							</div>
						</c:if>
						<!-- 댓글 리스트 출력부 end -->
						<!-- 댓글 작성 부분  -->
						<hr>
						<c:choose>
							<c:when test="${boardConf.getBoard_level_comment() ne 'null' and empty session_id  }"> 댓글 작성 권한이 부족합니다.<hr></c:when>
							<c:when test="${boardConf.getBoard_level_comment() eq 'admin' and session_id ne 'admin' }">댓글 작성 권한이 부족합니다.<hr></c:when>
							<c:otherwise>
								<h5>댓글 작성</h5>
								<form  method="post" id="form1" >
									
									<!-- 해당 게시판 ||해당 게시글 번호  -->				
									<input type="hidden" value="${bbs_id}" name="bbs_id">
									<input type="hidden" value="${BoardConDto.getBdata_no()}" name="bdata_no">
									<!--회원 || 비회원-->
									<c:choose>
										<c:when test="${!empty session }">
											<input type="hidden" value="${session_id }" name="bcomm_id">
											<input type="hidden" value="${session_pw }" name="bcomm_pw">
											<div class="horizon">
												
												<!-- 세션 계정 부분 -->
												<div>	
													<img alt="이미지 없음" src="${session_src}">
													
													<div>
														<p>부서${session_major}</p>
														<p>회원 이름<input name="bcomm_name" value="${session_name}"></p>
													</div>
												</div>
												
												<div>
													<textarea rows="7" cols="25" name="bcomm_cont" required="required"></textarea>
												</div>
												
												<div>
													<!-- 권한 작성  -->
													<input type="button" value="댓글 등록"  class="subbtn">
												</div>
											</div>	
										</c:when>			
										<c:otherwise>
											<div>
												<h3>현재 비회원</h3>
												<div>
													작성자 이름<input name="bcomm_name"  required="required" class="Logininput">
													비밀번호<input type="password" name="bcomm_pw" required="required" class="Logininput">	
												</div>
												<div class="horizon">								
													<div>
														<textarea rows="7" cols="25" name="bcomm_cont" required="required" class="Logininput"></textarea>
													</div>
													
													<div>
														<input type="button" value="댓글 등록" class="subbtn">
													</div>
												</div>		
											</div>			
										</c:otherwise>
									</c:choose>
									
								</form>
							</c:otherwise>
						</c:choose>
					</div>  
					<!-- 댓글 작성 부분 end  -->
			            
						
						<!-- 게시물 목록 출력부분  -->
						<div id="viewDiv" align="center">
							<table border="1" cellspacing="0" width="600" align="center">
								<c:forEach items="${List}" var="dto">
								<c:if test="${!empty dto.getBdata_file1()}"><c:set var="file1" value="📷"/></c:if>
								<c:if test="${!empty dto.getBdata_file2()}"><c:set var="file2" value="📷"/></c:if>
								<c:if test="${!empty dto.getBdata_file3()}"><c:set var="file3" value="📷"/></c:if>
								<c:if test="${!empty dto.getBdata_file4()}"><c:set var="file4" value="📷"/></c:if>
								
									<tr>
										<td><c:if test="${dto.getBdata_use_notice() eq 'Y' }">공지🔔</c:if><c:if test="${dto.getBdata_use_notice() ne 'Y' }">${dto.getBdata_no() }</c:if></td>
										<c:if test="${dto.getBdata_use_secret() eq 'Y'}">
											<td><a href="${path}/board/board_view.do?bbs_id=${dto.getBoard_id()}&bdata_no=${dto.getBdata_no()}" onclick="if(propmt('비밀번호를 입력하세요') != ${dto.getBdata_writer_pw()}){return false;}">🔒비밀글 입니다.</a></td>
										</c:if>
										<c:if test="${dto.getBdata_use_secret() eq 'N' or session_id eq 'admin'}">
											<td><a href="<%=request.getContextPath()%>/site/board/board_view.do?bbs_id=${dto.getBoard_id()}&bdata_no=${dto.getBdata_no() }&field=${field}&keyword=${keyword}&page=${paging.getPage()}">${dto.getBdata_title()}</a>${file1}${file2}${file3}${file4}(${dto.getBdata_comment()})</td>
										</c:if>
										
										<td>${dto.getBdata_writer_name() }</td>
										<td>${dto.getBdata_date().substring(0,10) }</td>
										<td>${dto.getBdata_hit() }</td>
									
									</tr>
								</c:forEach>
							</table>
							</div>
					
					
						<!-- 페이징 처리  -->
						<c:if test="${!empty paging}">
					            <div class="row list-bottom-util">
					                <div class="col text-center">
					                    ${pagingWrite}
					                </div>
					            </div>
					    </c:if>
			    		<!-- 페이징 처리 end -->		
	    <!-- 게시물 목록 출력부분 end -->
		</c:otherwise>
	</c:choose>
	 <!-- 내용 //END -->
    </main>
 

</div>


<%@ include file="../../layout/layout_footer.jsp" %>