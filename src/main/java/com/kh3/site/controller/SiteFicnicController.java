package com.kh3.site.controller;

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
    @RequestMapping("ficnic/category_list.do")
    public String categoryList(Model model) {
        List<CategoryDTO> list = cdao.getCategoryList();
        model.addAttribute("cList", list);

        return "site/ficnic/category_list";
    }




    // =====================================================================================
    // 피크닉 목록 페이지
    // =====================================================================================
    @RequestMapping("ficnic/ficnic_list.do")
    public String ficnic_List(
        @RequestParam(value = "category", required = false, defaultValue = "") String ficnic_category_no,
        @RequestParam(value = "subcategory", required = false, defaultValue = "") String ficnic_sub,
        @RequestParam(value = "page", required = false, defaultValue = "1") int page,
        HttpServletRequest request, Model model) {

        List<CategoryDTO> cList = cdao.getCategoryList();

        List<ReviewDTO> rList = rdao.getList();

        Map<String, Object> map = new HashMap<String, Object>();

        map.put("category_no", ficnic_category_no);
        map.put("subcategory_no", ficnic_sub);

        totalRecord = fdao.getSiteListCount(map);

        PageDTO dto = new PageDTO(page, rowsize, totalRecord, map);

        // 페이지 이동 URL
        String pageUrl = request.getContextPath() + "/ficnic/ficnic_list.do?category_no=" + ficnic_category_no + "&subcategory=" + ficnic_sub;

        List<FicnicDTO> fList = fdao.getSiteFicnicList(dto.getStartNo(), dto.getEndNo(), map);

        String ficnic_name = "";
        if (!ficnic_sub.equals("")) {
            ficnic_name = this.cdao.getCategoryName(ficnic_sub);
        } else {
            ficnic_name = this.cdao.getCategoryName(ficnic_category_no);
        }

        model.addAttribute("flist", fList);
        model.addAttribute("clist", cList);
        model.addAttribute("rlist", rList);
        model.addAttribute("category_no", ficnic_category_no);
        model.addAttribute("ficnic_name", ficnic_name);

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
        FicnicDTO fdto = fdao.getFicnicCont(ficnic_no);
        List<ReviewDTO> rList = rdao.getNumList(ficnic_no);

        int cnt = 0;
        for (ReviewDTO rev : rList) {
            if (rev.getReview_point() == 5) cnt++;
        }

        int avg = 0;
        if (cnt != 0 && rList.size() != 0) {
            avg = Math.round(cnt / rList.size());
        }

        model.addAttribute("fdto", fdto);
        model.addAttribute("rList", rList);
        model.addAttribute("count", rList.size());
        model.addAttribute("avg", avg);

        return "site/ficnic/ficnic_view";
    }










}