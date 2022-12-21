package com.kh3.site.controller;


import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.taglibs.standard.lang.jstl.test.beans.PublicBean1;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh3.model.ficnic.CategoryDAO;
import com.kh3.model.ficnic.CategoryDTO;
import com.kh3.model.ficnic.FicnicDAO;
import com.kh3.model.ficnic.FicnicDTO;
import com.kh3.model.member.McouponDAO;
import com.kh3.model.member.McouponDTO;
import com.kh3.model.member.MemberDAO;
import com.kh3.model.member.MemberDTO;
import com.kh3.model.member.WishDAO;
import com.kh3.model.qna.QnaDAO;
import com.kh3.model.qna.QnaDTO;
import com.kh3.model.reserv.ReservDAO;
import com.kh3.model.reserv.ReservDTO;
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
    
    @Inject
    McouponDAO mdao;

    @Inject
    WishDAO wdao;
    
    @Inject
    MemberDAO memberDAO;

    @Inject
    ReservDAO reservDAO;

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
        @RequestParam(value = "sort", required = false, defaultValue = "popular") String sort,
        @RequestParam(value = "page", required = false, defaultValue = "1") int page,
        HttpServletRequest request, HttpSession session, Model model) {

        // 카테고리 정보
        CategoryDTO cdto = cdao.getCategoryCont(ficnic_category_no);
        String parent_category_no = (ficnic_category_no.substring(0, 2)) + "000000";

        // 카테고리 피크닉 불러오기 위한 설정
        int next_num = cdto.getCategory_depth() * 2;
        String parent_str = ficnic_category_no.substring(0, next_num);


        // 세션 아이디 가져오기
        String sess_id = "";
        if(session.getAttribute("sess_id") != null) {
            sess_id = (String) session.getAttribute("sess_id");
        }

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("category_no", ficnic_category_no);
        map.put("sort", sort);
        map.put("next_num", next_num);
        map.put("parent_str", parent_str);
        map.put("sess_id", sess_id);


        totalRecord = fdao.getSiteListCount(map);
        PageDTO dto = new PageDTO(page, rowsize, totalRecord, map);

        // 페이지 이동 URL
        String pageUrl = request.getContextPath() + "/ficnic/ficnic_list.do?category=" + ficnic_category_no + "&sort=" + sort;


        // 카테고리 피크닉 목록
        List<FicnicDTO> fList = fdao.getSiteFicnicList(dto.getStartNo(), dto.getEndNo(), map);

        // 현재 카테고리 이름
        String category_name = this.cdao.getCategoryName(parent_category_no);

        // 서브 카테고리 목록
        List<CategoryDTO> cList = cdao.getSiteSubCategoryList(parent_category_no);


        model.addAttribute("flist", fList);
        model.addAttribute("clist", cList);
        model.addAttribute("category_no", ficnic_category_no);
        model.addAttribute("sort", sort);
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
    public String ficnic_view(
        @RequestParam(value = "category", required = false, defaultValue = "") String ficnic_category_no,
        @RequestParam(value = "ficnic_no", required = false, defaultValue = "") int ficnic_no,
        HttpSession session, Model model) {

        FicnicDTO dto = fdao.getFicnicCont(ficnic_no);

        // 조회수 늘리기
        fdao.updateFicnicHit(ficnic_no);


        if(ficnic_category_no.equals("") || ficnic_category_no == "null") {
            ficnic_category_no = dto.getFicnic_category_no();
        }

        // 현재 카테고리 이름
        String parent_category_no = (ficnic_category_no.substring(0, 2)) + "000000";
        String category_name = this.cdao.getCategoryName(parent_category_no);


        // 위시리스트 체크
        String ficnic_wish = "N";
        if(session.getAttribute("sess_id") != null) {
            int chkWish = this.wdao.getFicnicInWish(ficnic_no, (String) session.getAttribute("sess_id"));
            if(chkWish > 0) ficnic_wish = "Y";
        }
       
        
        Map<String, Object> numListMap = new HashMap<String, Object>();
        numListMap.put("ficnic_no", ficnic_no);
        numListMap.put("getType", "");
        List<ReviewDTO> rList = rdao.getNumList(numListMap);


        // 리뷰 점수
        int cnt = 0;
        for (ReviewDTO rev : rList) {
            if (rev.getReview_point() > 9) cnt++;
        }

        int avg = 0;
        if (cnt > 0 && rList.size() > 0) {
            avg = (int) Math.round((double) cnt / (double) rList.size() * 100);
        }


        /* 앞단 보여질 option 처리 */
        List<HashMap<String, Object>> optionList = new ArrayList<HashMap<String, Object>>();

        String[] optionTitle = null;
        if (dto.getFicnic_option_title() != null) optionTitle = dto.getFicnic_option_title().split("★");

        Object[] optionPrice = null;
        if (dto.getFicnic_option_price() != null) optionPrice = dto.getFicnic_option_price().split("★");

        if (optionTitle != null && optionPrice != null) {
            cnt = 0;
            for (String value : optionTitle) {
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("title", value);
                map.put("price", Integer.parseInt((String) optionPrice[cnt]));

                if(cnt == 0) {
                    map.put("cls", "info");
                    map.put("btn", "plus");
                }else{
                    map.put("cls", "danger");
                    map.put("btn", "minus");
                }

                optionList.add(map);
                cnt++;
            }
        }



        /* 앞단 보여질 select_option 처리 */
        List<HashMap<String, Object>> selectList = new ArrayList<HashMap<String, Object>>();

        String[] selectTitle = null;
        if (dto.getFicnic_select_title() != null) selectTitle = dto.getFicnic_select_title().split("★");

        Object[] selectPrice = null;
        if (dto.getFicnic_select_price() != null) selectPrice = dto.getFicnic_select_price().split("★");

        if (selectTitle != null && selectPrice != null) {
            cnt = 0;
            for (String value : selectTitle) {
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("title", value);
                map.put("price", Integer.parseInt((String) selectPrice[cnt]));

                if(cnt == 0) {
                    map.put("cls", "info");
                    map.put("btn", "plus");
                }else{
                    map.put("cls", "danger");
                    map.put("btn", "minus");
                }

                selectList.add(map);
                cnt++;
            }
        }



        /* 앞단 보여질 info 처리 */
        List<HashMap<String, Object>> infoList = new ArrayList<HashMap<String, Object>>();

        String[] infoAll = null;
        if (dto.getFicnic_info() != null) infoAll = dto.getFicnic_info().split("★");

        if(infoAll != null) {
            cnt = 0;
            for (String ilist : infoAll) {
                String[] infoEpd = ilist.split("○");

                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("title", infoEpd[0]);
                map.put("cont", infoEpd[1]);

                if(cnt == 0) {
                    map.put("cls", "info");
                    map.put("btn", "plus");
                }else{
                    map.put("cls", "danger");
                    map.put("btn", "minus");
                }

                infoList.add(map);
                cnt++;
            }
        }



        /* 앞단 보여질 curriculum 처리 */
        List<HashMap<String, Object>> currList = new ArrayList<HashMap<String, Object>>();

        String[] currAll = null;
        if (dto.getFicnic_curriculum() != null) currAll = dto.getFicnic_curriculum().split("★");

        if(currAll != null) {
            cnt = 0;
            for (String clist : currAll) {
                String[] currEpd = clist.split("○");

                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("time", currEpd[0]);
                map.put("cont", currEpd[1]);

                if(cnt == 0) {
                    map.put("cls", "info");
                    map.put("btn", "plus");
                }else{
                    map.put("cls", "danger");
                    map.put("btn", "minus");
                }

                currList.add(map);
                cnt++;
            }
        }


        // 오늘 날짜 넘기
        LocalDate getDate = LocalDate.now();
        String todayDate = getDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));


        model.addAttribute("dto", dto);
        model.addAttribute("rList", rList);

        model.addAttribute("category_name", category_name);
        model.addAttribute("ficnic_wish", ficnic_wish);
        model.addAttribute("count", rList.size());
        model.addAttribute("avg", avg);

        model.addAttribute("optionList", optionList);
        model.addAttribute("selectList", selectList);
        model.addAttribute("infoList", infoList);
        model.addAttribute("currList", currList);

        model.addAttribute("todayDate", todayDate);

        return "site/ficnic/ficnic_view";
    }




    // =====================================================================================
    // 피크닉 내용 보기 - 리뷰 목록 페이지
    // =====================================================================================
    @RequestMapping("ficnic/ficnic_review.do")
    public String ficnic_review(@RequestParam(value = "ficnic_no", required = false, defaultValue = "") int ficnic_no,
    		@RequestParam(value = "getType", required = false, defaultValue = "") String getType, 
    		@RequestParam(value = "page", required = false, defaultValue = "1") int page, Model model, HttpServletRequest request) {
        
    	// 정렬 설정
    	Map<String, Object> searchMap = new HashMap<String, Object>();
    	searchMap.put("ficnic_no", ficnic_no);
    	searchMap.put("getType", getType);
    	// 페이징
    	totalRecord = this.rdao.getSiteReviewCount(searchMap);

		PageDTO pdto = new PageDTO(page, rowsize, totalRecord, searchMap);
		
		// 정렬 쿼리
		List<ReviewDTO> rList = rdao.getNumList(pdto.getStartNo(), pdto.getEndNo(), searchMap);
		System.out.println("rlist>>>" + rList);
		System.out.println("pdto>>>" + pdto.getStartNo());

		// 페이지 이동 URL
		String pageUrl = request.getContextPath()+"/ficnic/ficnic_review.do?ficnic_no="+ficnic_no+"&getType="+getType;
		

    	FicnicDTO fdto = fdao.getFicnicCont(ficnic_no);
		int count = fdao.countAll(ficnic_no);
		int rcount = fdao.countReviewPoint(ficnic_no);
     
	    
        model.addAttribute("fdto", fdto);
        model.addAttribute("rList", rList);
		model.addAttribute("count", count);
		model.addAttribute("rcount", rcount);
		
		model.addAttribute("paging", pdto);
		model.addAttribute("page", page);
		model.addAttribute("getType", getType);
		model.addAttribute("pagingWrite",Paging.showPage(pdto.getAllPage(), pdto.getStartBlock(), pdto.getEndBlock(), pdto.getPage(), pageUrl));
		
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
    
    
    @RequestMapping("ficnic/reserv_form.do")
    public String pay(
    		@RequestParam(value = "ficnic_no") int ficnic_no,
    		ReservDTO dto,
    		HttpServletRequest request,
    		HttpSession session,
    		Model model) throws ParseException {
    	
    	FicnicDTO fdto= this.fdao.getFicnicCont(ficnic_no);
    	
    	// 회원 쿠폰 보유 여부
    	List<McouponDTO> mlist= mdao.getCouponView((String)session.getAttribute("sess_id"));
    	
    	MemberDTO memdto= memberDAO.getReservMember((String)session.getAttribute("sess_id"));
    	
    	
    	model.addAttribute("fdto", fdto);
    	model.addAttribute("dto", dto);
    	model.addAttribute("memdto", memdto);
    	model.addAttribute("mlist", mlist);
    	model.addAttribute("couponCount", mlist.size());
    	
    	return "site/ficnic/ficnic_pay";
    }
    
    @RequestMapping("ficnic/reserv_form_ok.do")
    public void reserv_form_ok(
    		ReservDTO rDto ,
    		HttpServletResponse response) throws IOException {
    	
    	response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

       
        String checkSess = checkSess();
        rDto.setReserv_sess(checkSess);
        
        if(reservDAO.insertReserv(rDto)>0) {
        	out.println("<script>alert('예약 완료');location.href='ficnic_list.do';</script>");
        }else {
        	out.println("<script>alert('예약 실패');history.back();</script>");
        }
        
       
    }

    
    public String checkSess() {
    	
    	boolean isTrue=false;  	
        
    	String sub="";
        
        // reservSess 재귀함수처리 
    	for(int i=0; i<6; i++) {
        	sub+= (int)(Math.random()*10)+1;
        }
    	
    	// 오늘 날짜 넘기
        LocalDate getDate = LocalDate.now();
        String todayDate = getDate.format(DateTimeFormatter.ofPattern("yyMMdd"));
    

        sub = todayDate+"-"+sub;
        
        List<ReservDTO> list =  reservDAO.getReservList(sub);
        
        for(ReservDTO val : list) {
        	if(sub.equals(val.getReserv_sess())){  		
        		isTrue=true;
        	}      	
        }
       if(isTrue) {
    	   return checkSess();
       }else {
    	   return sub;
       }
        
    }
    
    
   


}