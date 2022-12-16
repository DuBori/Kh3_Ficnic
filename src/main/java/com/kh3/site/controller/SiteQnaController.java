package com.kh3.site.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh3.model.ficnic.FicnicDAO;
import com.kh3.model.ficnic.FicnicDTO;
import com.kh3.model.qna.QnaCommentDAO;
import com.kh3.model.qna.QnaCommentDTO;
import com.kh3.model.qna.QnaDAO;
import com.kh3.model.qna.QnaDTO;
import com.kh3.util.UploadFile;

@Controller
public class SiteQnaController {

    @Autowired
    private QnaDAO qdao;

    @Autowired
    private QnaCommentDAO cdao;

    @Autowired
    private FicnicDAO fdao;    
    
    // 문의 사진 업로드 설정
    private String qnaFolder = "/resources/data/qna/";
    private String qnaSaveName = "qna";

    
    // =====================================================================================
    // 마이페이지 - 내 1:1 문의 상세목록
    // =====================================================================================
    @RequestMapping("/site/mypage/mypage_qna_view.do")
    public String qna_view(Model model, QnaDTO dto, @RequestParam("no") int no) {
        dto = this.qdao.qnaView(no);
        List<QnaCommentDTO> cdto = this.cdao.getQnaCommentList(no);
        FicnicDTO fdto = this.fdao.getFicnicCont(dto.getFicnic_no());
        
        model.addAttribute("dto", dto);
        model.addAttribute("cdto", cdto);
        model.addAttribute("fdto", fdto);       
    	return "site/mypage/mypage_qna_view";
    }
    

    
    // =====================================================================================
    // 1:1 문의 수정 페이지
    // =====================================================================================
    @RequestMapping("/site/mypage/mypage_qna_modify.do")
    public String qna_modify(Model model, @RequestParam("qna_no") int no) {
    	
    	QnaDTO dto = this.qdao.qnaView(no);
    	model.addAttribute("dto", dto);
        return "site/mypage/mypage_qna_modify";
    }
    
    
    
    // =====================================================================================
    // 1:1 문의 수정하기
    // =====================================================================================
    @RequestMapping("/site/mypage/mypage_qna_modifyOk.do")
    public void qna_modifyOk(QnaDTO dto, MultipartHttpServletRequest mRequest, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();    	
        // 파일저장 이름 >> thisFolder/saveName_일련번호_밀리세컨드.확장자
        List<String> upload_list = UploadFile.fileUpload(mRequest, qnaFolder, qnaSaveName);

        // 기존 파일 있으면 삭제 처리
        for(int i=0; i<upload_list.size(); i++) {
            String check_photo = mRequest.getParameter("ori_qna_file"+(i+1));
            if(check_photo != null && upload_list.get(i) != ""){
                File del_pimage = new File(mRequest.getSession().getServletContext().getRealPath(check_photo));
                if(del_pimage.exists()) del_pimage.delete();
            }
        }
        String modify_file1 = mRequest.getParameter("ori_qna_file1");
        String modify_file2 = mRequest.getParameter("ori_qna_file2");

        if(upload_list.get(0) != "") modify_file1 = upload_list.get(0);
        if(upload_list.get(1) != "") modify_file2 = upload_list.get(1);
        
        
        dto.setQna_file1(modify_file1);
        dto.setQna_file2(modify_file2);


        // 리뷰 수정
        int check = this.qdao.qnaModify(dto);

        if(check > 0){
            out.println("<script>alert('문의글이 수정되었습니다.'); location.href='mypage_qna_list.do';</script>");
        }else{
            out.println("<script>alert('문의글 수정 중 에러가 발생하였습니다.'); history.back();</script>");
        }
        
    }
    
    
    // =====================================================================================
    // 1:1 문의 추가 페이지
    // =====================================================================================
    @RequestMapping("/site/mypage/mypage_qna_write.do")
    public String qna_write() {
    	
    	return "site/mypage/mypage_qna_write";
    }
    
    
    // =====================================================================================
    // 1:1 문의 추가하기
    // =====================================================================================
    @RequestMapping("/site/mypage/mypage_qna_writeOk.do")
    public String qna_writeOK(HttpServletResponse response, QnaDTO dto) {
    	
    	return "site/mypage/mypage_qna_write";
    }
    
    
    
    
  
}
