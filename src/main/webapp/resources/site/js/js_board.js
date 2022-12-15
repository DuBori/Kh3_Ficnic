
/////////////////////////////////////////////////////
// 댓글 관련
/////////////////////////////////////////////////////
$(function() {
    /* 댓글 삭제 시 Ajax 처리*/
    $(document).on("click",".delbtn", function() {
        if($(".chk").val() !="c"){
            if(prompt('비밀번호를 입력하세요.') != $(".chk").val()){
                alert('비밀번호가 틀립니다.');
                return false;
            }
        }
            
        $.ajax({
            type : "post",
            contentType : "application/x-www-form-urlencoded;charset=UTF-8",
            url : "baord_comment_delete.do",
            data : {
                    bcomm_no : $(this).attr("name"),
                    bbs_id : '${bbs_id}',
                    bdata_no : ${BoardConDto.getBdata_no()}
            },
            datatype : "text",

            success : function(data) {
                $("#commList").html(data);
                $(".Logininput").val("");
            },

            error : function(e) {
                alert("Error : "+e.status);
            }
        });
    });



    /* 댓글 입력시 Ajax 처리 */
    $(".subbtn").on("click",function(){
        $.ajax({
            type : "post",
            contentType : "application/x-www-form-urlencoded;charset=UTF-8",
            url : "baord_comment_insert.do",
            datatype : "text",
            data : $("#form1").serialize(),

            success : function(data) {
                $("#commList").html(data);
                $(".Logininput").val("");
            },

            error : function(e) {
                alert("Error : "+e.status);
            }
        });
    });
});








