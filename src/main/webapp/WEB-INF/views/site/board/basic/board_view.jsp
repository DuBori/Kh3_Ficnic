<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<body>
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
	
		<div class="page-cont view-form">
		    <!-- 내용 //START -->
		    <!-- 해당 게시글 정보 -->
		    <div class="row vf-body">
		    	<div>
		    		<div>
		    			<h3>[00회원]${BoardDto.getBdata_title()}</h3>
		    		</div>
	    			
	    			<div>
	    				<div>
	    					<p>${BoardDto.getBdata_date()}</p>
	    					<p>${BoardDto.getBdata_hit()}</p>	    					
	    				</div>			
	    				
	    				<div>
	    					<p>${BoardDto.getBdata_writer_name() }(${BoardDto.getBdata_writer_id()})</p>
	    					<p>표시이름 : 작성자</p>
	    				</div>
	    			</div>
	    			
	    			<!-- 게시글 첨부 링크 -->
	    			<div>
		    			<hr>
		    				<p>관련링크 #1 : : <c:if test="${!empty BoardDto.getBdata_link1()}"><a href="${BoardDto.getBdata_link1() }">${BoardDto.getBdata_link1() }</a></c:if> </p>
		    			<hr>
		    				<p>관련링크 #2 : : <c:if test="${!empty BoardDto.getBdata_link2()}"><a href="${BoardDto.getBdata_link2() }">${BoardDto.getBdata_link2() }</a></c:if> </p>
		    			<hr>		
		    		</div>
		    		
		    		<!-- 게시글 내용 -->
		    		<div>
		    			${BoardDto.getBdata_cont() }
		    		</div>
		    		
		    		<!-- 파일 다운로드 부분 -->
		    		<div>
		    			<hr>
							<c:if test="${!empty BoardDto.getBdata_file1() }"><p>첨부파일 #1 :<a href="#">${BoardDto.getBdata_file1() }</a></p></c:if>
							<c:if test="${!empty BoardDto.getBdata_file2() }"><p>첨부파일 #2 :<a href="#">${BoardDto.getBdata_file2() }</a></p></c:if>
							<c:if test="${!empty BoardDto.getBdata_file3() }"><p>첨부파일 #3 :<a href="#">${BoardDto.getBdata_file3() }</a></p></c:if>
							<c:if test="${!empty BoardDto.getBdata_file4() }"><p>첨부파일 #4 :<a href="#">${BoardDto.getBdata_file4() }</a></p></c:if>
		    			<hr>
		    		</div>  		
		    	</div>
	    	</div>
	    </div>
		    <!-- 내용 //END -->
		
		
		
		    <!-- 버튼 //START -->
		    <div class="d-flex justify-content-center mb-4">
		        <a href="<%=request.getContextPath()%>/site/board/board_delete.do?bbs_id=${boardConf.getBoard_id()}&board_no=${BoardDto.getBdata_no()}" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?\n되돌릴 수 없습니다.');"><i class="fa fa-trash-o"></i> 삭제하기</a>        
		        <a href="<%=request.getContextPath()%>/site/board/board_modify.do?bbs_id=${boardConf.getBoard_id()}&board_no=${BoardDto.getBdata_no()}" class="btn btn-primary mx-2"><i class="fa fa-pencil"></i> 수정하기</a>        
		        <a href="<%=request.getContextPath()%>/site/board/board_list.do?bbs_id=${boardConf.getBoard_id() }" class="btn btn-secondary"><i class="fa fa-bars"></i> 목록보기</a>    
		    </div>
		    <!-- 버튼 //END -->
		</div>
       </div>
    </main>
 
	
</body>
</html>