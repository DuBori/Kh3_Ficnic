package com.kh3.site.controller;

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


import com.kh3.model.ficnic.FicnicDAO;
import com.kh3.model.ficnic.FicnicDTO;
import com.kh3.model.qna.QnaCommentDAO;
import com.kh3.model.qna.QnaCommentDTO;
import com.kh3.model.qna.QnaDAO;
import com.kh3.model.qna.QnaDTO;

@Controller
public class SiteQnaController {

    @Autowired
    private QnaDAO qdao;

    @Autowired
    private QnaCommentDAO cdao;

    @Autowired
    private FicnicDAO fdao;    

    
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

    
    
    
  
}
