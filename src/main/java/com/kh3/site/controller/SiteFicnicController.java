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
import com.kh3.util.PageDTO;
import com.kh3.util.Paging;

@Controller
public class SiteFicnicController {

    @Inject
    CategoryDAO cdao;

    @Inject
    FicnicDAO fdao;

    // 한 페이지당 보여질 게시물의 수
    private final int rowsize = 10;

    // 전체 게시물의 수
    private int totalRecord = 0;
    
    // 카테고리 페이지
    @RequestMapping("ficnic/category_list.do")
    public String categoryList(Model model) {
        List<CategoryDTO> list = cdao.getCategoryList();
        model.addAttribute("cList", list);

        return "site/ficnic/category_list";
    }
    
    // 피크닉 페이지
    @RequestMapping("ficnic/ficnic_list.do")
    public String ficnic_List(
    		@RequestParam( value = "category", required = false , defaultValue = "") String finic_category_no,
    		@RequestParam(value = "page",required = false ,defaultValue = "1") int page,
    		HttpServletRequest request,
    		Model model) {
    	
    	List<CategoryDTO> cList = cdao.getCategoryList();
    	
    	Map<String, Object> map = new HashMap<String, Object>();
		map.put("category_no", finic_category_no);
    	
		totalRecord = fdao.getListCount(map);
		
		PageDTO dto = new PageDTO(page, rowsize, totalRecord, map);
    	
    	// 페이지 이동 URL
    	String pageUrl = request.getContextPath() + "/admin/ficnic/ficnic_list.do?category_no="+finic_category_no;

    	List<FicnicDTO> fList = fdao.getFicnicList();
    	
    	System.out.println(dto.getAllPage()+","+dto.getStartBlock()+","+ dto.getEndBlock()+","+dto.getEndBlock()+","+dto.getPage());
    	
    	model.addAttribute("flist", fList);
    	model.addAttribute("clist", cList);	
    	model.addAttribute("totalCount", totalRecord);
		model.addAttribute("paging", dto);
		model.addAttribute("pagingWrite",Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));
		
    	return "site/ficnic/ficnic_list";
    }








}