<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../layout/layout_header.jsp" %>


<div class="contents w1100 board-list">
	
	<div class="page-cont" align="center">

	<form action="${path}/board/board_view_ok.do" method="post">
		<input type="hidden" value="${bbs_id }" name="bbs_id">
		<input type="hidden" value="${bdata_no }" name="bdata_no">
		<input type="hidden" value="${bdata_writer_id }" name="bdata_writer_id">
		<table>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="pwd" required="required"></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="비밀번호 확인">
					</td>
				</tr> 
				
		
		</table>
	</form>
	
	</div>
	
	
</div>
<%@ include file="../../layout/layout_footer.jsp" %>