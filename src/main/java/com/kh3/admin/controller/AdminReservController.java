package com.kh3.admin.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh3.model.member.MemberDAO;
import com.kh3.model.member.MemberDTO;
import com.kh3.model.reserv.ReservDAO;
import com.kh3.model.reserv.ReservDTO;
import com.kh3.util.PageDTO;
import com.kh3.util.Paging;

@Controller
public class AdminReservController {

    @Autowired
    private ReservDAO dao;

    @Autowired
    private MemberDAO mdao;


    // 한 페이지당 보여질 게시물의 수
    private final int rowsize = 10;

    // 전체 게시물의 수
    private int totalRecord = 0;




    // =====================================================================================
    // 예약 목록 페이지
    // =====================================================================================
    @RequestMapping("admin/reserv/reserv_list.do")
    public String list(
            @RequestParam(value = "search_status", required = false, defaultValue = "") String search_status,
            @RequestParam(value = "search_sess", required = false, defaultValue = "") String search_sess,
            @RequestParam(value = "search_ficnic", required = false, defaultValue = "") String search_ficnic,
            @RequestParam(value = "search_name", required = false, defaultValue = "") String search_name,
            HttpServletRequest request, Model model) {

        LocalDate startNowDate = LocalDate.now().minusDays(30L); // 오늘로부터 30일전 부터
        String startDay = startNowDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        LocalDate endNowDate = LocalDate.now().with(TemporalAdjusters.lastDayOfMonth()); // 오늘로부터 30일후 까지
        String endDay = endNowDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));


        String search_date_start = "";
        String search_date_end = "";
        if(request.getParameter("search_date_start") != null){ search_date_start = request.getParameter("search_date_start").trim(); }else{ search_date_start = startDay; }
        if(request.getParameter("search_date_end") != null){ search_date_end = request.getParameter("search_date_end").trim(); }else{ search_date_end = endDay; }


        // 검색 설정
        Map<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("search_status", search_status);
        searchMap.put("search_date_start", search_date_start);
        searchMap.put("search_date_end", search_date_end);
        searchMap.put("search_sess", search_sess);
        searchMap.put("search_ficnic", search_ficnic);
        searchMap.put("search_name", search_name);

        // 페이징 처리
        int page; // 현재 페이지 변수
        if (request.getParameter("page") != null && request.getParameter("page") != "") {
            page = Integer.parseInt(request.getParameter("page"));
        } else {
            page = 1;
        }
        totalRecord = this.dao.getReservCount(searchMap); // 총갯수

        // 페이징 DTO
        PageDTO dto = new PageDTO(page, rowsize, totalRecord, searchMap);

        // 페이지 이동 URL
        String pageUrl = request.getContextPath() + "/admin/reserv/reserv_list.do?search_ficnic=" + search_ficnic + "&search_status=" + search_status + "&search_date_start=" + search_date_start + "&search_date_end=" + search_date_end + "&search_sess=" + search_sess + "&search_ficnic=" + search_ficnic + "&search_name=" + search_name;

        List<ReservDTO> list = this.dao.getReservList(dto.getStartNo(), dto.getEndNo(), searchMap);

        model.addAttribute("List", list);
        model.addAttribute("totalCount", totalRecord);
        model.addAttribute("paging", dto);

        model.addAttribute("search_status", search_status);
        model.addAttribute("search_date_start", search_date_start);
        model.addAttribute("search_date_end", search_date_end);
        model.addAttribute("search_sess", search_sess);
        model.addAttribute("search_ficnic", search_ficnic);
        model.addAttribute("search_name", search_name);
        model.addAttribute("pagingWrite", Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));

        return "admin/reserv/reserv_list";
    }





    // =====================================================================================
    // 예약 상세내역 메핑
    // =====================================================================================
    @RequestMapping("admin/reserv/reserv_view.do")
    public String view(@RequestParam("no") int no, @RequestParam("sess") String sess, Model model) {
        ReservDTO dto = this.dao.getReservView(no, sess);

        model.addAttribute("dto", dto);

        return "admin/reserv/reserv_view";
    }

}
