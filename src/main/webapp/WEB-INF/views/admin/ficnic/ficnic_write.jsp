<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>


<c:choose>
	<c:when test="${!empty m}">
		<c:set var="tag" value="admin/ficnic/ficnic_modify_ok.do" />
		<c:set var="title" value="수정" />
		<c:set var="icon" value="save" />
		<c:set var="category" value="${fdto.getFicnic_category_no()}" />
	</c:when>

	<c:otherwise>
		<c:set var="tag" value="admin/ficnic/ficnic_write_ok.do" />
		<c:set var="title" value="등록" />
		<c:set var="icon" value="pencil" />
	</c:otherwise>
</c:choose>




<script type="text/javascript">
$("#header .navbar .nav-item:nth-child(1)").addClass("active");

$(function(){
	$("#addBtn").on("click", function(){
		let addBtn = "<div class=\"row form mb-5 view-limit\">\n";
			addBtn += "\t<div class=\"form-group col-sm\">\n";
			addBtn += "\t\t<label>피크닉 타이틀</label>\n";
			addBtn += "\t\t<input name=\"ficnic_info\" />\n";
			addBtn += "\t\t<label for=\"goods_ea_total\">피크닉 내용</label>\n";
			addBtn += "\t\t<textarea name=\"ficnic_info\" rows=\"10\" cols=\"80\"></textarea>\n";
			addBtn += "\t</div>\n";
			addBtn += "\t<button type=\"button\" class=\"delbtn\" /><i class=\"fa fa-minus\"></i></button>\n";
			addBtn += "</div>\n";
		$("#ficnic_div").append(addBtn);	
	});

	$("#optionBtn").on("click", function(){
		let optBtn = "<div class=\"row form mb-1 view-limit\">\n";
			optBtn += "\t<div class=\"form-group col-sm\">\n";
			optBtn += "\t\t<label>옵션 타이틀</label>\n";
			optBtn += "\t\t<input type=\"text\" name=\"ficnic_option_title\" class=\"form-control text-center w-20\" />\n";
			optBtn += "\t\t<label>옵션 가격</label>\n";
			optBtn += "\t\t<input type=\"text\" name=\"ficnic_option_price\" class=\"form-control text-center w-20\" />원\n";
			optBtn += "\t</div>\n";
			optBtn += "\t<button type=\"button\" class=\"delbtn\" /><i class=\"fa fa-minus\"></i></button>\n";
			optBtn += "</div>\n";
		$("#optionDiv").append(optBtn);	
	});

	$(".delbtn").on("click", function(){
		$(this).parent().remove();
	});
});
</script>




<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>피크닉 ${title}</h2>
        <ol class="m-0 p-2">
            <li>피크닉 관리</li>
            <li><b>피크닉 ${title}</b></li>
        </ol>
    </div>
</div>




<form name="ficnic_form" method="post" enctype="multipart/form-data" action="${path}/${tag}" onsubmit="return chkFicnicWrite();">
<c:if test="${!empty m}"><input type="hidden" name="ficnic_no" value="${fdto.getFicnic_no()}" /></c:if>
<div class="page-cont">
    <div class="row">
        <div class="col-lg mb-4">
            <div class="card input-form">
                <div class="card-body p-4">

                	<h4 class="view-limit">기본 정보</h4>
                    <div class="row form mb-5 view-limit">
						<div class="form-group">
							<label for="ficnic_name"><span>*</span> 피크닉 이름</label>
							<input type="text" name="ficnic_name" id="ficnic_name" value="${fdto.getFicnic_name()}" class="form-control" />
						</div>

						<div class="w-100"></div>

						<div class="form-group col-sm">
							<label for="ficnic_market_price">이전 판매가</label>
							<input type="text" name="ficnic_market_price" id="ficnic_market_price" value="${fdto.getFicnic_market_price()}" class="form-control text-right w-30" onkeyup="NumberInput(this)" /> 원
						</div>
						<div class="form-group col-sm">
							<label for="ficnic_sale_price"><span>*</span> 현재 판매가</label>
							<input type="text" name="ficnic_sale_price" id="ficnic_sale_price" value="${fdto.getFicnic_sale_price()}" class="form-control text-right w-30" onkeyup="NumberInput(this)" /> 원
						</div>

						<div class="w-100 border-bottom mt-2"></div>

                        <div class="form-group join-form">
                            <label><span>*</span> 기본 카테고리</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pb-2">
										<button type="button" class="btn btn-sm btn-warning mt-0" data-toggle="modal" data-target="#modalCategory" onclick="$('#modalCategory').attr('type', 'default');"><i class="fa fa-exclamation"></i> 등록할 분류 선택</button>
										<ul class="cate-show parent mt-2">
											<c:choose>
												<c:when test="${!empty fdto.getFicnic_category_name()}"><li>${fdto.getFicnic_category_name()}</li></c:when>
												<c:otherwise><p>등록된 기본 카테고리가 없습니다.</p></c:otherwise>
											</c:choose>
										</ul>
										<input type="hidden" name="ficnic_category_no" value="${fdto.getFicnic_category_no()}" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group join-form">
                            <label>다중 카테고리</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pb-2">
										<button type="button" class="btn btn-sm btn-info mt-0" data-toggle="modal" data-target="#modalCategory" onclick="$('#modalCategory').attr('type', 'sub');"><i class="fa fa-exclamation"></i> 등록할 분류 선택</button>
										<ul class="cate-show sub mt-2">
											<c:choose>
												<c:when test="${empty fdto.getFicnic_category_sub1() and empty fdto.getFicnic_category_sub2() and empty fdto.getFicnic_category_sub3()}"><p>등록된 다중 카테고리가 없습니다.</p></c:when>
												<c:otherwise>
													<c:if test="${!empty fdto.getFicnic_category_sub1()}"><li class="${fdto.getFicnic_category_sub1()}">${fdto.getFicnic_category_sub1_name()}<button type="button"><i class="fa fa-times"></i></button><input type="hidden" name="ficnic_category_sub[]" value="${fdto.getFicnic_category_sub1()}"></li></c:if>
													<c:if test="${!empty fdto.getFicnic_category_sub2()}"><li class="${fdto.getFicnic_category_sub2()}">${fdto.getFicnic_category_sub2_name()}<button type="button"><i class="fa fa-times"></i></button><input type="hidden" name="ficnic_category_sub[]" value="${fdto.getFicnic_category_sub2()}"></li></c:if>
													<c:if test="${!empty fdto.getFicnic_category_sub3()}"><li class="${fdto.getFicnic_category_sub3()}">${fdto.getFicnic_category_sub3_name()}<button type="button"><i class="fa fa-times"></i></button><input type="hidden" name="ficnic_category_sub[]" value="${fdto.getFicnic_category_sub3()}"></li></c:if>
												</c:otherwise>
											</c:choose>
										</ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>



                	<h4 class="view-limit">선택 옵션 정보</h4>
                    <div class="row form mb-5 view-limit">
                    	asdasdasd
                    </div>



                	<h4 class="view-limit">피크닉 사진</h4>
                    <div class="row form mb-5 view-limit">
						<div class="form-group join-form">
							<label for="ficnic_name">사진 1</label>
                            <div class="jf-input">
                                <div class="row">
                                    <div class="col pb-2">
						<div class="custom-file">
							<input type="file" name="goods_photo_s_kor" class="custom-file-input" id="goods_photo_s_kor_file" />
							<label class="custom-file-label" for="goods_photo_s_kor_file"></label>
						</div>
						<button type="button" class="btn btn-sm btn-outline-danger" onclick="delImgWrite(this, '<?=$ps_uid?>', 'goods_photo_s_kor');"><i class="fa fa-trash-o"></i> 등록된 이미지 삭제</button>
                                    </div>
                                </div>
                            </div>
						</div>
                    </div>



                	<h4 class="view-limit">피크닉 상세 정보</h4>
                    <div class="row form mb-3 view-limit">
						<div class="form-group">
							<label for="ficnic_name"><span>*</span> 피크닉 이름</label>
							<input type="text" name="ficnic_name" id="ficnic_name" value="${fdto.getFicnic_name()}" class="form-control" />
						</div>
                    </div>


                </div>
            </div>
        </div>
    </div>
</div>




<div class="d-flex mt-2 input-form-button">
    <div class="col-lg text-center">
        <a href="ficnic_list.do?search_type=${search_type}&search_name=${search_name}&search_id=${search_id}&search_email=${search_email}&search_phone=${search_phone}&page=${param.page}" class="btn btn-secondary btn-lg m-2"><i class="fa fa-bars"></i> 목록보기</a>
        <button type="submit" class="btn btn-primary btn-lg m-2"><i class="fa fa-${icon}"></i> ${title}하기</button>
    </div>
</div>
</form>




<!-- 상품 분류 선택 //START -->
<div class="modal fade" id="modalCategory" tabindex="-1" aria-hidden="true" type="">
	<div class="modal-dialog modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title"><i class="fa fa-exclamation"></i> 카테고리 선택</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
			</div>
			<div class="modal-body">
				<ul class="folder-tree">
					<c:forEach var="cate" items="${clist}">
					<!-- 대 카테고리 반복 -->
					<c:choose>
						<c:when test="${cate.getSub_category().size() > 0}">
							<c:set var="show_big_class" value="plus" />
							<c:set var="show_big_count" value="<span class=\"count\" />[${cate.getSub_category().size()}]</span>" />
						</c:when>
						<c:otherwise>
							<c:set var="show_big_class" value="normal" />
							<c:set var="show_big_count" value="" />
						</c:otherwise>
					</c:choose>

					<c:choose>
						<c:when test="${cate.getCategory_show() eq 'N'}">
							<c:set var="show_big_disshow" value=" [비노출]" />
							<c:set var="show_big_disclass" value=" noshow" />
						</c:when>
						<c:otherwise>
							<c:set var="show_big_disshow" value="" />
							<c:set var="show_big_disclass" value="" />
						</c:otherwise>
					</c:choose>
					<li class="line-plus depth01-${show_big_class}${show_big_disclass}">
						<div class="ft-title ft-title-large" ctid="${cate.getCategory_id()}" path="${cate.getCategory_name()}">
							<span class="name">${cate.getCategory_name()}${show_big_disshow}</span>
							${show_big_count}
						</div>

						<c:if test="${!empty cate.getSub_category()}">
						<!-- 중 카테고리 반복 -->
						<ul class="sort-list">
							<c:forEach var="subc" items="${cate.getSub_category()}">
							<c:choose>
								<c:when test="${subc.getCategory_show() eq 'N'}">
									<c:set var="show_sub_disshow" value=" [비노출]" />
									<c:set var="show_sub_disclass" value="noshow" />
								</c:when>
								<c:otherwise>
									<c:set var="show_sub_disshow" value="" />
									<c:set var="show_sub_disclass" value="" />
								</c:otherwise>
							</c:choose>
							<li class="${show_sub_disclass}">
								<div class="ft-title" ctid="${subc.getCategory_id()}" path="${cate.getCategory_name()} &gt; ${subc.getCategory_name()}">
									<span class="name">${subc.getCategory_name()}${show_sub_disshow}</span>
								</div>
							</li>
							</c:forEach>
						</ul>
						</c:if>
					</li>
					</c:forEach>
				</ul>
			</div>
			<div class="modal-footer text-center" style="display: block;">
				<button type="button" class="btn btn-secondary btn-close" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" onclick="setCategory();">적용하기</button>
			</div>
		</div>
	</div>
</div>
<!-- 상품 분류 선택 //END -->




<%@ include file="../layout/layout_footer.jsp" %>