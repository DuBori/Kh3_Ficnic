package com.kh3.admin.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh3.model.coupon.CouponDTO;
import com.kh3.model.ficnic.CategoryDAO;
import com.kh3.model.ficnic.CategoryDTO;
import com.kh3.model.ficnic.FicnicDAO;
import com.kh3.model.ficnic.FicnicDTO;
import com.kh3.util.UploadFile;

@Controller
public class AdminFicnicController {

    @Inject
    private FicnicDAO dao;

    @Inject
    private CategoryDAO cdao;


    // 카테고리 업로드 설정
    private String categoryFolder = "/resources/data/category/";
    private String categorySaveName = "category";

    // 피크닉 업로드 설정
    private String ficnicFolder = "/resources/data/ficnic/";
    private String ficnicSaveName = "ficnic";
    // 한 페이지당 보여질 게시물의 수
    private final int rowsize = 10;

    // 전체 게시물의 수
    private int totalRecord = 0;



    // 피크닉 목록 페이지
    @RequestMapping("admin/ficnic/ficnic_list.do")
    public String ficnicList(Model model, HttpServletRequest request) {
    	
    	// 대분류 카테고리 리스트
    	List<CategoryDTO> cList = cdao.getCategoryList();
        
    	List<FicnicDTO> fList = dao.getFicnicList();
    	
       
       	model.addAttribute("flist", fList);
    	model.addAttribute("clist", cList);
    	

        return "admin/ficnic/ficnic_list";
    }


    // 피크닉 보기 페이지
    @RequestMapping("admin/ficnic/ficnic_view.do")
    public String ficnicView(Model model, @RequestParam("no") int no) {
        return "admin/ficnic/ficnic_view";
    }



    // 피크닉 등록 페이지
    @RequestMapping("admin/ficnic/ficnic_write.do")
    public String ficnicWrite(Model model, HttpServletRequest request) {
    	
    	List<CategoryDTO> cList = cdao.getCategoryList();
    	model.addAttribute("clist", cList);
        return "admin/ficnic/ficnic_write";
    }



    // 피크닉 등록 처리
    @RequestMapping("admin/ficnic/ficnic_write_ok.do")
    public void ficnicWriteOk(FicnicDTO dto,MultipartHttpServletRequest mRequest ,HttpServletResponse response) throws Exception {
    	
    	response.setContentType("text/html; charset=utf-8");
    	PrintWriter out= response.getWriter();
    	
        // 파일저장 이름 >> thisFolder/saveName_일련번호_밀리세컨드.확장자
        List<String> ficnic_imagesrc = new ArrayList<String>();
        
        List<String> upload_list = UploadFile.fileUpload(mRequest, ficnicFolder, ficnicSaveName);
    	for(String imgsrc : upload_list) {
    		System.out.println(imgsrc);
    		ficnic_imagesrc.add(imgsrc);
    	}
    	
    	
    	if(this.dao.writeFicnic(dto, ficnic_imagesrc)>0) {
    		out.println("<script>location.href='"+mRequest.getContextPath()+"/admin/ficnic/ficnic_list.do'</script>");
    	}else {
    		out.println("<script>alert('피크닉 등록 실패'); history.back()</script>");
    	}
    	
    }



    // 피크닉 수정 페이지
    @RequestMapping("admin/ficnic/ficnic_modify.do")
    public String ficnicModify(@RequestParam("no") int no,Model model) {
    	int cnt=0;
    	// 기존에 있던 해당 피크닉 상품 정보 불러와야한다.
    	FicnicDTO fdto =this.dao.getFicnicCont(no);
    	List<CategoryDTO> cList = cdao.getCategoryList();
    	
    	 String[] optionTitle = fdto.getFicnic_option_title().split("★");
    	//String[] optionTitle = "[제주] 제주로컬푸드 이용한 셀프 베이킹 (예약 가능)★[11세~대인] 제주고사리파스타★[10세~대인] 제주통밀당근파운드케이크".split("★");
    	//String[] optionPrice = "30000★27000★30000".split("★");
    	 String[] optionPrice = fdto.getFicnic_option_price().split("★");
		
		//System.out.println(fdto.getFicnic_option_title());
    	
    	List<HashMap<String, String>> mapList = new ArrayList<HashMap<String,String>>();
    
    	for(String value : optionTitle) {
    		HashMap<String, String> map = new HashMap<String, String>();
    		map.put("title", value);
    		map.put("price", optionPrice[cnt]);
    		cnt++;
    		mapList.add(map);
    	}
    	 
    	model.addAttribute("clist", cList);
    	
    	model.addAttribute("fdto",fdto);

    	model.addAttribute("mapList",mapList);
    	model.addAttribute("m", "m");
    	
    	return "admin/ficnic/ficnic_write";
    }



    // 피크닉 수정 처리
    @RequestMapping("admin/ficnic/ficnic_modify_ok.do")
    public void ficnicModifyOk(FicnicDTO dto,MultipartHttpServletRequest mRequest,HttpServletResponse response) throws Exception {
    
    	response.setContentType("text/html; charset=utf-8");
    	PrintWriter out= response.getWriter();
    	
        // 파일저장 이름 >> thisFolder/saveName_일련번호_밀리세컨드.확장자
    	/*  기존에 존재하는 DTO에 있는 이미지만큼 삭제해야함. */
        String ficnic_image1 = mRequest.getParameter("ori_ficnic_image1");
        String ficnic_image2 = mRequest.getParameter("ori_ficnic_image2");
        String ficnic_image3 = mRequest.getParameter("ori_ficnic_image3");
        String ficnic_image4 = mRequest.getParameter("ori_ficnic_image4");
        String ficnic_image5 = mRequest.getParameter("ori_ficnic_image5");
        
        List<String> list = new ArrayList<String>();
        list.add(ficnic_image1);
        list.add(ficnic_image2);
        list.add(ficnic_image3);
        list.add(ficnic_image4);
        list.add(ficnic_image5);
         
        List<String> upload_list = UploadFile.fileUpload(mRequest, ficnicFolder, ficnicSaveName);
        if(upload_list.size() > 0) {   
        	for(String value : list) {     		
        		if(value != null){
                    File del_pimage = new File(mRequest.getSession().getServletContext().getRealPath(value));
                    if(del_pimage.exists()) del_pimage.delete();
                }
        	}  	
        }
    	
    	if(this.dao.modifyFicnic(dto,upload_list)>0) {
    		out.println("<script>location.href='"+mRequest.getContextPath()+"/admin/ficnic/ficnic_list.do'</script>");
    	}else {
    		out.println("<script>alert('피크닉 수정 실패'); history.back()</script>");
    	}
    }
    




    // 피크닉 삭제 처리
    @RequestMapping("admin/ficnic/ficnic_delete.do")
    public void ficnicDelete(@RequestParam("no") int no,HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	response.setContentType("text/html; charset=utf-8");
    	PrintWriter out= response.getWriter();
    	
    	if(this.dao.deleteFicnic(no)>0) {
    		out.println("<script>location.href='"+request.getContextPath()+"/admin/ficnic/ficnic_list.do'</script>");
    	}else {
    		out.println("<script>alert('피크닉 삭제 실패'); history.back()</script>");
    	}
    }






    ////////////////////////////////////////////////////////////////////////////////////////////////////






    // 카테고리 관리 목록 페이지
    @RequestMapping("admin/ficnic/category_list.do")
    public String categoryList(Model model) {
        List<CategoryDTO> list = cdao.getCategoryList();
        model.addAttribute("clist", list);

        return "admin/ficnic/category_list";
    }


    // 카테고리 정렬 순서 저장
    @RequestMapping("admin/ficnic/category_rank_ok.do")
    public void categoryRank(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String[] cateid = request.getParameterValues("category_id[]");
        for(int i=0; i<cateid.length; i++) {
            cdao.setCategoryRank(cateid[i], i+1);
        }

        PrintWriter out = response.getWriter();
        out.println("<script>location.href='category_list.do';</script>");
    }


    // 카테고리 추가
    @RequestMapping("admin/ficnic/category_write_ok.do")
    public void categoryWrite(MultipartHttpServletRequest mRequest, HttpServletResponse response) throws IOException {
        String ps_ctid = mRequest.getParameter("ps_ctid");
        String category_show = mRequest.getParameter("category_show");
        String category_name = mRequest.getParameter("category_name");


        // 파일저장 이름 >> thisFolder/saveName_일련번호_밀리세컨드.확장자
        String category_image = null;
        List<String> upload_list = UploadFile.fileUpload(mRequest, categoryFolder, categorySaveName);
        if(upload_list.size() > 0) {
            category_image = upload_list.get(0);
        }


        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        int check = cdao.addCategory(ps_ctid, category_show, category_name, category_image);
        if(check > 0) {
            out.println("<script>location.href='category_list.do';</script>");
        }else{
            out.println("<script>alert('카테고리 등록 중 에러가 발생하였습니다.'); history.back();</script>");
        }
    }


    // 카테고리 수정
    @RequestMapping("admin/ficnic/category_modify_ok.do")
    public void categoryModify(MultipartHttpServletRequest mRequest, HttpServletResponse response) throws IOException {
        String ps_ctid = mRequest.getParameter("ps_ctid");
        String category_show = mRequest.getParameter("category_show");
        String category_name = mRequest.getParameter("category_name");


        // 파일저장 이름 >> thisFolder/saveName_일련번호_밀리세컨드.확장자
        String category_image = mRequest.getParameter("ori_category_image");
        List<String> upload_list = UploadFile.fileUpload(mRequest, categoryFolder, categorySaveName);
        if(upload_list.size() > 0) {
            // 기존 파일 있으면 삭제 처리
            if(category_image != null){
                File del_pimage = new File(mRequest.getSession().getServletContext().getRealPath(category_image));
                if(del_pimage.exists()) del_pimage.delete();
            }
            category_image = upload_list.get(0);
        }


        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        int check = cdao.modifyCategory(ps_ctid, category_show, category_name, category_image);
        if(check > 0) {
            out.println("<script>location.href='category_list.do';</script>");
        }else{
            out.println("<script>alert('카테고리 수정 중 에러가 발생하였습니다.'); history.back();</script>");
        }
    }


    // 카테고리 삭제
    @RequestMapping("admin/ficnic/category_delete.do")
    public void categoryDelete(@RequestParam("ps_ctid") String ps_ctid, HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        CategoryDTO cdto = cdao.getCategoryCont(ps_ctid);

        // 기존 파일 있으면 삭제 처리
        if(cdto.getCategory_image() != null){
            File del_pimage = new File(request.getSession().getServletContext().getRealPath(cdto.getCategory_image()));
            if(del_pimage.exists()) del_pimage.delete();
        }

        int check = cdao.deleteCategory(ps_ctid);
        if(check > 0) {
            cdao.updateCategorySeq(cdto.getCategory_no());
            cdao.updateCategoryFicnic(ps_ctid);
            out.println("<script>location.href='category_list.do';</script>");
        }else{
            out.println("<script>alert('카테고리 삭제 중 에러가 발생하였습니다.'); history.back();</script>");
        }
    }




}