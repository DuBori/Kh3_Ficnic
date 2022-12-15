<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../layout/layout_header.jsp" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:if test="${level.view ne 'Y'}"><script>alert('게시물 보기 권한이 없습니다.'); history.back();</script></c:if>

<link type="text/css" rel="stylesheet" href="${path}/resources/site/css/css_board.css" />
<script language="javascript" src="${path}/resources/site/js/js_board.js"></script>


<%@ include file="../../layout/layout_csmenu.jsp" %>


<div class="contents w1100 view-form board-view">

    <div class="row vf-body">
        <div class="col-lg mb-4">
            <div class="card border-0">
                <div class="card-body p-0 pt-2">
                    <h2>${BoardConDto.getBdata_title()}</h2>

                    <div class="d-flex py-2 border-bottom vfb-info">
                        <div class="col text-left">
                            <p>${BoardConDto.getBdata_date()}</p>
                            <p>조회수 : <fmt:formatNumber value="${BoardConDto.getBdata_hit()}" /></p>
                        </div>

                        <div class="col text-right pt-2">
                        	<p class="writer">${BoardConDto.getBdata_writer_name()}<c:if test="${BoardConDto.getBdata_writer_id() ne 'null'}"> (${BoardConDto.getBdata_writer_id()})</c:if></p>
                        </div>
                    </div>

                    <c:if test="${!empty BoardConDto.getBdata_link1()}">
                    	<div class="d-flex py-2 border-bottom">
            				<div class="col"><i class="fa fa-link"></i> 관련링크 #1 : <a href="${BoardConDto.getBdata_link1()}" target="_blank">${BoardConDto.getBdata_link1()}</a></div>
            			</div>
                    </c:if>
                    <c:if test="${!empty BoardConDto.getBdata_link2()}">
                    	<div class="d-flex py-2 border-bottom">
            				<div class="col"><i class="fa fa-link"></i> 관련링크 #2 : <a href="${BoardConDto.getBdata_link2()}" target="_blank">${BoardConDto.getBdata_link2()}</a></div>
            			</div>
                    </c:if>


					<c:if test="${!empty BoardConDto.getBdata_file1()}">
						<p>첨부파일 #1 :<a href="<%=request.getContextPath()%>/site/board/board_download.do?bbs_id=${BoardConDto.getBoard_id()}&bdata_no=${BoardConDto.getBdata_no()}&file=${BoardConDto.getBdata_file1()}">${BoardConDto.getBdata_file1()}</a></p>
					</c:if>


                    <?=$show_img_file1?>
                    <?=$show_img_file2?>
                    <?=$show_img_file3?>
                    <?=$show_img_file4?>
                    <?=$show_img_file5?>

                    <div class="d-flex pt-4 pb-5 border-bottom">
                        <div class="col">
                            ${BoardConDto.getBdata_cont().replace(newLine, '<br />')}
                        </div>
                    </div>

                    <?=$show_down_file1?>
                    <?=$show_down_file2?>
                    <?=$show_down_file3?>
                    <?=$show_down_file4?>
                    <?=$show_down_file5?>
                </div>
            </div>
        </div>
    </div>
    <!-- 내용 //END -->



    <!-- 버튼 //START -->
    <div class="d-flex justify-content-center mb-4">
        <? if($b_data["board_writer_id"] == $gw_check_id){ ?><a href="board_ok.php?ps_mode=board_delete&b_id=<?=$b_id?>&b_no=<?=$b_no?>&ps_search=<?=$ps_search?>&ps_keyword=<?=$ps_keyword?>&ps_page=<?=$ps_page?>" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?\n되돌릴 수 없습니다.');"><i class="icon-trash mr-1"></i> 삭제하기</a><? } ?>
        <? if($b_data["board_writer_id"] == $gw_check_id){ ?><a href="/board/board_write.php?b_id=<?=$b_id?>&amp;b_no=<?=$b_no?>&amp;ps_search=<?=$ps_search?>&amp;ps_keyword=<?=$ps_keyword?>&amp;ps_page=<?=$ps_page?>" class="btn btn-primary mx-2"><i class="icon-note mr-1"></i> 수정하기</a><? } ?>
        <a href="/board/board.php?b_id=<?=$b_id?>&amp;ps_search=<?=$ps_search?>&amp;ps_keyword=<?=$ps_keyword?>&amp;ps_page=<?=$ps_page?>" class="btn btn-secondary"><i class="icon-list mr-1"></i> 목록보기</a>
    </div>
    <!-- 버튼 //END -->




    <!-- 댓글 //START -->
    <div class="row vf-comment">
        <div class="col-lg">
            <div class="card border input-form">
                <div class="card-body pt-3 pb-4">
                    <ul class="vfc-list">
                        <?
                            while($c_list = gw_fetch($c_result)){
                                $c_no = $c_list["uid"];
                                $c_body = auto_link(nl2br(settings_re($c_list["comment_body"])));
                                $c_date = date("Y.m.d", $c_list["register_date"])."<br />".date("H:i:s", $c_list["register_date"]);

                                $writer_data = gw_fetch(gw_query("select * from gw_member_list where member_id = '$c_list[comment_id]'"));
                                if($writer_data["member_class"] >= 9){
                                    $c_writer = "<b><img src=\"".$skin_dir."/images/company_logo_small.png\" /> 관리자</b>";
                                }else{
                                    $c_writer = "<b>".$c_list["comment_name"]."</b><span>(".$c_list["comment_id"].")</span>";
                                }
                        ?>
                        <li class="d-flex border-bottom py-3">
                            <div class="vfcl-writer"><?=$c_writer?></div>
                            <div class="vfcl-body px-3"><?=$c_body?></div>
                            <div class="vfcl-date text-center">
                                <p><?=$c_date?></p>
                                <? if($c_list["comment_id"] == $gw_check_id){ ?><a href="board_ok.php?ps_mode=comment_delete&b_id=<?=$b_id?>&b_no=<?=$b_no?>&c_no=<?=$c_no?>&ps_search=<?=$ps_search?>&ps_keyword=<?=$ps_keyword?>&ps_page=<?=$ps_page?>" class="btn btn-sm btn-outline-danger py-0 mt-2" onclick="return confirm('이 댓글을 삭제하시겠습니까?');"><i class="icon-close mr-1"></i> 삭제</a><? } ?>
                            </div>
                        </li>
                        <? } ?>
                    </ul>


                    <? if($bbs_config["board_class_comment"] <= $gw_check_class){ ?>
                    <form name="comment_form" method="post" action="board_ok.php">
                    <input type="hidden" name="ps_mode" value="comment_write" />
                    <input type="hidden" name="b_id" value="<?=$b_id?>" />
                    <input type="hidden" name="b_no" value="<?=$b_no?>" />
                    <input type="hidden" name="comment_id" value="<?=$gw_check_id?>" />
                    <input type="hidden" name="comment_pw" value="<?=$gw_check_pw?>" />
                    <input type="hidden" name="comment_name" value="<?=$gw_check_name?>" />
                    <input type="hidden" name="ps_page" value="<?=$ps_page?>" />
                    <input type="hidden" name="ps_search" value="<?=$ps_search?>" />
                    <input type="hidden" name="ps_keyword" value="<?=$ps_keyword?>" />
                    <div class="d-flex justify-content-center vfc-form">
                        <div class="vfcf-writer"><?=$gw_check_name?></div>
                        <div class="vfcf-input"><textarea name="comment_body" class="form-control" rows="4"></textarea></div>
                        <div class="vfcf-btn">
                            <button type="button" class="btn btn-info" onclick="form_comment(this)">
                                <i class="icon-pencil mr-1"></i> 댓글 등록
                            </button>
                        </div>
                    </div>
                    </form>
                    <? } ?>
                </div>
            </div>
        </div>
    </div>
    <!-- 댓글 //END -->


</div>




<%@ include file="../../layout/layout_footer.jsp" %>