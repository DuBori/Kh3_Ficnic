package com.kh3.admin.controller;

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



    // 예약 전체리스트 메핑
    @RequestMapping("admin/reserv/reserv_list.do")
    public String list(HttpServletRequest request, Model model) {
        // 검색 처리
        String search_type = request.getParameter("search_type");
        if (search_type == null) search_type = "";

        String startDate = request.getParameter("startDate");
        if (startDate == null) startDate = "";

        String endDate = request.getParameter("endDate");
        if (endDate == null) endDate = "";

        String search_no = request.getParameter("search_no");
        if (search_no == null) search_no = "";

        String search_id = request.getParameter("search_id");
        if (search_id == null) search_id = "";
        
        String search_name = request.getParameter("search_name");
        if (search_name == null) search_name = "";
        
        Map<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("search_type", search_type);
        searchMap.put("startDate", startDate);
        searchMap.put("endDate", endDate);
        searchMap.put("search_no", search_no);
        searchMap.put("search_id", search_id);
        searchMap.put("search_name", search_name);


        // 페이징 처리
        int page; // 현재 페이지 변수
        if (request.getParameter("page") != null && request.getParameter("page") != "") {
            page = Integer.parseInt(request.getParameter("page"));
        } else {
            page = 1;
        }
        totalRecord = this.dao.getReservCount(searchMap);	// 총갯수

        // 페이징 DTO
        PageDTO dto = new PageDTO(page, rowsize, totalRecord, searchMap);

        // 페이지 이동 URL
        String pageUrl = request.getContextPath() + "/admin/reserv/reserv_list.do?search_type="+search_type+"&startDate="+startDate+"&endDate="+endDate+"&search_no="+search_no+"&search_id="+search_id+"&search_name="+search_name;

        List<ReservDTO> list = this.dao.getReservList(dto.getStartNo(), dto.getEndNo(), searchMap);
        model.addAttribute("List", list);

        model.addAttribute("totalCount", totalRecord);
        model.addAttribute("paging", dto);
        model.addAttribute("search_type", search_type);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("search_no", search_no);
        model.addAttribute("search_id", search_id);
        model.addAttribute("search_name", search_name);
        model.addAttribute("pagingWrite", Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));

        return "admin/reserv/reserv_list";
    }



    // 예약 상세내역 메핑
    @RequestMapping("admin/reserv/reserv_view.do")
    public String view(Model model, @RequestParam("no") int no, @RequestParam("id") String id) {
    	
    	System.out.println("여기 ====== "+no);
        ReservDTO dto = this.dao.getReservView(no);
        
        System.out.println("여기 ====== "+id);
        MemberDTO mdto = this.mdao.getReservMember(id);
        
        model.addAttribute("dto", dto);
        model.addAttribute("mdto", mdto);

        return "admin/reserv/reserv_view";
    }
    
    
}
