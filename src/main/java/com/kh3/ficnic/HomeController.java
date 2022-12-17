package com.kh3.ficnic;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh3.model.ficnic.FicnicDAO;


@Controller
public class HomeController {

    @Inject
    FicnicDAO fDao;



    // =====================================================================================
    // 메인페이지
    // =====================================================================================
    @RequestMapping("main.do")
    public String main(Model model) {



















        return "site/main";
    }




    // =====================================================================================
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home() {
        return "index";
    }



    // =====================================================================================
    // 관리자
    // =====================================================================================
    @RequestMapping("admin/")
    public String admin() {
        return "admin/index";
    }


    // =====================================================================================
    // 관리자 메인
    // =====================================================================================
    @RequestMapping("admin/main.do")
    public String admin_main() {
        return "admin/index";
    }

}