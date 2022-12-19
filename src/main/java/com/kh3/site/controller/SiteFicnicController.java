package com.kh3.site.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh3.model.ficnic.CategoryDAO;
import com.kh3.model.ficnic.CategoryDTO;
import com.kh3.model.ficnic.FicnicDAO;
import com.kh3.model.ficnic.FicnicDTO;
import com.kh3.model.review.ReviewDAO;
import com.kh3.model.review.ReviewDTO;
import com.kh3.util.PageDTO;
import com.kh3.util.Paging;

@Controller
public class SiteFicnicController {

    @Inject
    CategoryDAO cdao;

    @Inject
    FicnicDAO fdao;

    @Inject
    ReviewDAO rdao;


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
    public String ficnic_view(
        @RequestParam(value = "category", required = false, defaultValue = "") String ficnic_category_no,
        @RequestParam(value = "ficnic_no", required = false, defaultValue = "") int ficnic_no, Model model) {

        // 현재 카테고리 이름
        String parent_category_no = (ficnic_category_no.substring(0, 2)) + "000000";
        String category_name = this.cdao.getCategoryName(parent_category_no);

        FicnicDTO dto = fdao.getFicnicCont(ficnic_no);
        List<ReviewDTO> rList = rdao.getNumList(ficnic_no);

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



        model.addAttribute("dto", dto);
        model.addAttribute("rList", rList);

        model.addAttribute("category_name", category_name);
        model.addAttribute("count", rList.size());
        model.addAttribute("avg", avg);

        model.addAttribute("optionList", optionList);
        model.addAttribute("selectList", selectList);
        model.addAttribute("infoList", infoList);
        model.addAttribute("currList", currList);

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



        return "site/ficnic/ficnic_qna_write";
    }










}