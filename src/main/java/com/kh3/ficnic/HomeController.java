package com.kh3.ficnic;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh3.model.board.BoardDAO;
import com.kh3.model.board.BoardDTO;
import com.kh3.model.ficnic.CategoryDAO;
import com.kh3.model.ficnic.FicnicDAO;
import com.kh3.model.ficnic.FicnicDTO;


@Controller
public class HomeController {

    @Inject
    CategoryDAO cdao;

    @Inject
    FicnicDAO fdao;

    @Inject
    BoardDAO bdao;



    // =====================================================================================
    // 메인페이지
    // =====================================================================================
    @RequestMapping("main.do")
    public String main(Model model) {

        // 이런 피크닉은 어때요?
        Map<String, Object> map1 = new HashMap<String, Object>();
        map1.put("category_no", "16000000");
        map1.put("next_num", 2);
        map1.put("parent_str", 16);
        map1.put("search", "");
        List<FicnicDTO> fList1 = fdao.getSiteFicnicList(1, 4, map1);
        model.addAttribute("flist1", fList1);


        // 인기 급상승
        Map<String, Object> map2 = new HashMap<String, Object>();
        map2.put("category_no", "17000000");
        map2.put("next_num", 2);
        map2.put("parent_str", 17);
        map2.put("search", "");
        List<FicnicDTO> fList2 = fdao.getSiteFicnicList(1, 4, map2);
        model.addAttribute("flist2", fList2);


        // 따뜻하고 뜨거운 겨울나기
        Map<String, Object> map3 = new HashMap<String, Object>();
        map3.put("category_no", "18000000");
        map3.put("next_num", 2);
        map3.put("parent_str", 18);
        map3.put("search", "");
        List<FicnicDTO> fList3 = fdao.getSiteFicnicList(1, 4, map3);
        model.addAttribute("flist3", fList3);


        // 조용히 나를 돌아보는 시간
        Map<String, Object> map4 = new HashMap<String, Object>();
        map4.put("category_no", "19000000");
        map4.put("next_num", 2);
        map4.put("parent_str", 19);
        map4.put("search", "");
        List<FicnicDTO> fList4 = fdao.getSiteFicnicList(1, 4, map4);
        model.addAttribute("flist4", fList4);


        // 기획전


        // 이벤트
        List<BoardDTO> event = bdao.getBoardList("event");
        model.addAttribute("eventList", event);


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