package com.kh3.site.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh3.model.ficnic.CategoryDAO;
import com.kh3.model.ficnic.CategoryDTO;

@Controller
public class SiteFicnicController {

    @Inject
    CategoryDAO cdao;


    // 카테고리 페이지
    @RequestMapping("ficnic/category_list.do")
    public String categoryList(Model model) {
        List<CategoryDTO> list = cdao.getCategoryList();
        model.addAttribute("cList", list);

        return "site/ficnic/category_list";
    }








}