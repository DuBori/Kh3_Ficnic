<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		    <div class="row vf-body">
		    	<div>
		    		<div>
		    			<h3>[00회원]${dd }</h3>
		    		</div>  	
		    	</div>
		    </div>
		    <!-- 내용 //END -->
		
		
		
		    <!-- 버튼 //START -->
		    <div class="d-flex justify-content-center mb-4">
		        <a href="board_ok.php?ps_mode=board_delete&amp;b_id=notice&amp;b_no=3&amp;ps_search=&amp;ps_keyword=&amp;ps_page=1" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?\n되돌릴 수 없습니다.');"><i class="fa fa-trash-o"></i> 삭제하기</a>        <a href="/admin/board/board_write.php?b_id=notice&amp;b_no=3&amp;ps_search=&amp;ps_keyword=&amp;ps_page=1" class="btn btn-primary mx-2"><i class="fa fa-pencil"></i> 수정하기</a>        <a href="/admin/board/board_list.php?b_id=notice&amp;ps_search=&amp;ps_keyword=&amp;ps_page=1" class="btn btn-secondary"><i class="fa fa-bars"></i> 목록보기</a>    </div>
		    <!-- 버튼 //END -->
		</div>
       </div>
    </main>
 
	
</body>
</html>