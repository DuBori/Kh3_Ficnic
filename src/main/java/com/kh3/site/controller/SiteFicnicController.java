package com.kh3.site.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh3.model.ficnic.CategoryDAO;
import com.kh3.model.ficnic.CategoryDTO;
import com.kh3.model.ficnic.FicnicDAO;
import com.kh3.model.ficnic.FicnicDTO;
import com.kh3.model.qna.QnaDAO;
import com.kh3.model.qna.QnaDTO;
import com.kh3.model.review.ReviewDAO;
import com.kh3.model.review.ReviewDTO;
import com.kh3.util.PageDTO;
import com.kh3.util.Paging;
import com.kh3.util.UploadFile;

@Controller
public class SiteFicnicController {

    @Inject
    CategoryDAO cdao;

    @Inject
    FicnicDAO fdao;

    @Inject
    ReviewDAO rdao;
    
    @Inject
    QnaDAO qdao;

    // 문의 사진 업로드 설정
    private String qnaFolder = "/resources/data/qna/";
    private String qnaSaveName = "qna";


    // 한 페이지당 보여질 게시물의 수
    private final int rowsize = 10;

    // 전체 게시물의 수
    private int totalRecord = 0;




    // =====================================================================================
    // 카테고리 페이지
    // =====================================================================================
    @RequestMapping("ficnic/ficnic_category.do")
    public String categoryList(Model model) {
        List<CategoryDTO> list = cdao.getSiteCategoryList();
        model.addAttribute("cList", list);

        return "site/ficnic/ficnic_category";
    }




    // =====================================================================================
    // 피크닉 목록 페이지
    // =====================================================================================
    @RequestMapping("ficnic/ficnic_list.do")
    public String ficnic_List(
        @RequestParam(value = "category", required = false, defaultValue = "") String ficnic_category_no,
        @RequestParam(value = "page", required = false, defaultValue = "1") int page,
        HttpServletRequest request, Model model) {

        // 카테고리 정보
        CategoryDTO cdto = cdao.getCategoryCont(ficnic_category_no);
        String parent_category_no = (ficnic_category_no.substring(0, 2)) + "000000";

        // 카테고리 피크닉 불러오기 위한 설정
        int next_num = cdto.getCategory_depth() * 2;
        String parent_str = ficnic_category_no.substring(0, next_num);


        Map<String, Object> map = new HashMap<String, Object>();
        map.put("category_no", ficnic_category_no);
        map.put("next_num", next_num);
        map.put("parent_str", parent_str);


        totalRecord = fdao.getSiteListCount(map);
        PageDTO dto = new PageDTO(page, rowsize, totalRecord, map);

        // 페이지 이동 URL
        String pageUrl = request.getContextPath() + "/ficnic/ficnic_list.do?category=" + ficnic_category_no;


        // 카테고리 피크닉 목록
        List<FicnicDTO> fList = fdao.getSiteFicnicList(dto.getStartNo(), dto.getEndNo(), map);

        // 현재 카테고리 이름
        String category_name = this.cdao.getCategoryName(parent_category_no);

        // 서브 카테고리 목록
        List<CategoryDTO> cList = cdao.getSiteSubCategoryList(parent_category_no);


        model.addAttribute("flist", fList);
        model.addAttribute("clist", cList);
        model.addAttribute("category_no", ficnic_category_no);
        model.addAttribute("parent_category_no", parent_category_no);
        model.addAttribute("category_name", category_name);

        model.addAttribute("totalCount", totalRecord);
        model.addAttribute("paging", dto);
        model.addAttribute("pagingWrite", Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));

        return "site/ficnic/ficnic_list";
    }




    // =====================================================================================
    // 피크닉 내용 보기 페이지
    // =====================================================================================
    @RequestMapping("ficnic/ficnic_view.do")
    public String ficnic_view(@RequestParam(value = "ficnic_no", required = false, defaultValue = "") int ficnic_no, Model model) {
        FicnicDTO dto = fdao.getFicnicCont(ficnic_no);
        List<ReviewDTO> rList = rdao.getNumList(ficnic_no);

        int cnt = 0;
        for (ReviewDTO rev : rList) {
            if (rev.getReview_point() == 5) cnt++;
        }

        int avg = 0;
        if (cnt != 0 && rList.size() != 0) {
            avg = Math.round(cnt / rList.size());
        }

        model.addAttribute("dto", dto);
        model.addAttribute("rList", rList);
        model.addAttribute("count", rList.size());
        model.addAttribute("avg", avg);

        return "site/ficnic/ficnic_view";
    }




    // =====================================================================================
    // 피크닉 내용 보기 - 리뷰 목록 페이지
    // =====================================================================================
    @RequestMapping("ficnic/ficnic_review.do")
    public String ficnic_review(@RequestParam(value = "ficnic_no", required = false, defaultValue = "") int ficnic_no, Model model) {
        FicnicDTO fdto = fdao.getFicnicCont(ficnic_no);
        List<ReviewDTO> rList = rdao.getNumList(ficnic_no);
		int count = fdao.countAll(ficnic_no);
		int rcount = fdao.countReviewPoint(ficnic_no);
        
        model.addAttribute("fdto", fdto);
        model.addAttribute("rList", rList);
		model.addAttribute("count", count);
		model.addAttribute("rcount", rcount);

        return "site/ficnic/ficnic_review";
    }




    // =====================================================================================
    // 피크닉 내용 보기 - 1:1 문의 작성 페이지
    // =====================================================================================
    @RequestMapping("ficnic/ficnic_qna.do")
    public String ficnic_qna(@RequestParam(value = "ficnic_no", required = false, defaultValue = "") int ficnic_no, Model model) {
    	FicnicDTO fdto = this.fdao.getFicnicCont(ficnic_no);
    	

    	model.addAttribute("fdto", fdto);
        return "site/ficnic/ficnic_qna_write";
    }


    // =====================================================================================
    // 1:1 문의 추가하기
    // =====================================================================================
    @RequestMapping("ficnic/mypage_qna_writeOk.do")
    public void qna_writeOk(HttpServletResponse response, MultipartHttpServletRequest mRequest, QnaDTO dto, HttpServletRequest request, HttpSession session) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        session = request.getSession();
        
        String id = (String) session.getAttribute("sess_id");
        String pw = (String) session.getAttribute("sess_pw");
        String name = (String) session.getAttribute("sess_name");
        
        dto.setMember_id(id);
    	dto.setQna_pw(pw);
    	dto.setQna_name(name);
        
        // 파일저장 이름 >> thisFolder/saveName_일련번호_밀리세컨드.확장자
        List<String> upload_list = UploadFile.fileUpload(mRequest, qnaFolder, qnaSaveName);        
        for(int i=0; i<upload_list.size(); i++){
            switch (i) {
                case 0:
                    dto.setQna_file1(upload_list.get(0));
                    break;
                case 1:
                	dto.setQna_file2(upload_list.get(1));
                    break;
                default:
                    break;
            }
        }

        // 문의글 등록
        int check = this.qdao.qnaWriteOk(dto);

        if(check > 0){
            out.println("<script>alert('문의글이 추가되었습니다.'); location.href='ficnic_view.do?ficnic_no="+dto.getFicnic_no()+"';</script>");
        }else{
            out.println("<script>alert('문의글 추가 중 에러가 발생하였습니다.'); history.back();</script>");
        }
    	
    }
    
    
    @RequestMapping("ficnic/ficnic_pay.do")
    public String pay() {
    	System.out.println("들어옴");
    	return "site/ficnic/ficnic_pay";
    }








}