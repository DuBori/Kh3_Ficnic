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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh3.model.ficnic.CategoryDAO;
import com.kh3.model.ficnic.CategoryDTO;
import com.kh3.model.ficnic.FicnicDAO;
import com.kh3.model.ficnic.FicnicDTO;
import com.kh3.util.PageDTO;
import com.kh3.util.Paging;
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
    	

    	// 피크닉 데이터가 존재하는 지역
    	List<String> locationList = dao.getFicnicLocationList();
    	
    	// 피크닉 데이터가 존재하는 카테고리 
    	List<FicnicDTO> cList = cdao.getExistCategoryList();
    	
		/* 페이징 처리 */
    	// 페이징 처리
		int page; // 현재 페이지 변수
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		} else {
			page = 1;
		}
		String finic_category_no="";
		String ficnic_location="";
		String ficnic_address="";
		String ficnic_name="";
		if (request.getParameter("finic_category_no")!=null) {
			finic_category_no = request.getParameter("finic_category_no");
		}
		if (request.getParameter("ficnic_location")!=null) {
			ficnic_location = request.getParameter("ficnic_location");
		}
		if (request.getParameter("ficnic_address")!=null) {
			ficnic_address = request.getParameter("ficnic_address");
		}
		if (request.getParameter("ficnic_name")!=null) {
			ficnic_name = request.getParameter("ficnic_name");
		}
		
		ficnic_location = request.getParameter("ficnic_location");
		ficnic_name = request.getParameter("ficnic_name");
		
		System.out.println(finic_category_no+","+ficnic_location+","+ficnic_name);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("category_no", finic_category_no);
		map.put("location", ficnic_location);
		map.put("addr", ficnic_address);
		map.put("name", ficnic_name);
		
		totalRecord = dao.getListCount(map);
		
		PageDTO dto = new PageDTO(page, rowsize, totalRecord, map);
       
		// 페이지 이동 URL
		String pageUrl = request.getContextPath() + "/admin/ficnic/ficnic_list.do?category_no="+finic_category_no+"&location="+ficnic_location+"&name"+ficnic_name;

		System.out.println(dto.getStartNo()+","+dto.getEndNo());
		List<FicnicDTO> fList = dao.getFicnicList(dto.getStartNo(), dto.getEndNo(), map);
		
		
       	model.addAttribute("flist", fList);
    	model.addAttribute("clist", cList);
    	model.addAttribute("locationList", locationList);
    	model.addAttribute("totalCount", totalRecord);
		model.addAttribute("paging", dto);
		model.addAttribute("pagingWrite",Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));
		
		model.addAttribute("category_no", finic_category_no);
		model.addAttribute("location", ficnic_location);
		model.addAttribute("addr", ficnic_address);
		model.addAttribute("name", ficnic_name);
		
        return "admin/ficnic/ficnic_list";
    }


    // 피크닉 보기 페이지
    @RequestMapping("admin/ficnic/ficnic_view.do")
    public String ficnicView(Model model, @RequestParam("no") int no) {
    	int cnt = 0;
    	FicnicDTO fdto=dao.getFicnicCont(no);
    	List<CategoryDTO> clist=cdao.getCategoryList();
    	
    	String[] optionTitle = null; if(fdto.getFicnic_option_title()!= null) optionTitle = fdto.getFicnic_option_title().split("★");
    	Object[] optionPrice = null; if(fdto.getFicnic_option_price()!= null) optionPrice = fdto.getFicnic_option_price().split("★");
		
    	String[] selectTitle = null; if(fdto.getFicnic_select_title()!= null) selectTitle = fdto.getFicnic_select_title().split("★");
    	Object[] selectPrice = null; if(fdto.getFicnic_select_price()!= null) selectPrice = fdto.getFicnic_select_price().split("★");
		
    	
    	List<HashMap<String, Object>> optionList = new ArrayList<HashMap<String,Object>>();
    	/* 앞단 보여질 option 처리 */
    	cnt=0;
    	for(String value : optionTitle) {
    		HashMap<String, Object> map = new HashMap<String, Object>();
    		map.put("title", value);
    		map.put("price", Integer.parseInt((String) optionPrice[cnt]));
    		optionList.add(map);
    		cnt++;
    	}   
    	/* 앞단 보여질 select_option 처리 */
    	
    	
    	List<HashMap<String, Object>> selectList = new ArrayList<HashMap<String,Object>>();
		
    	/* 앞단 보여질 option 처리 */
    	/* 앞단 보여질 select_option 처리 */
    		
    	if(selectTitle!=null && selectPrice!=null) {
	    	cnt=0;
	    	for(String value : selectTitle) {
	    		HashMap<String, Object> map = new HashMap<String, Object>();
	    		map.put("title", value);
	    		map.put("price", Integer.parseInt((String) selectPrice[cnt]));
	    		selectList.add(map);
	    		cnt++;
	    	}   
    	}

		/* 앞단 보여질 info 처리 */
    	String[] list =fdto.getFicnic_info().split("★");
    	
    	List<HashMap<String, Object>> infoList = new ArrayList<HashMap<String,Object>>();
    	cnt=0;
    	for(String value: list) {
    		String[] valueList = value.split(",");
    		HashMap<String, Object> map = new HashMap<String, Object>();
    		map.put("title", valueList[0]);
    		map.put("cont", valueList[1]);
    		infoList.add(map);
    	}
    	
    	model.addAttribute("dto", fdto);
    	model.addAttribute("clist", clist);
    	model.addAttribute("optionList",optionList);
    	model.addAttribute("selectList",selectList);
    	model.addAttribute("infoList",infoList);
    	
    	
    	
    	
    	
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
    	int cnt=0;
    	//서브 카테고리 처리
    	String[] ficnicSub =null;
    	if(mRequest.getParameter("ficnic_sub")!=null) {
    		ficnicSub=mRequest.getParameter("ficnic_sub").split("/");
    		for(String sub : ficnicSub) {
    			switch (cnt) {
				case 0:
					dto.setFicnic_category_sub1(sub);
					break;
				case 1:
					dto.setFicnic_category_sub2(sub);
					break;
				case 2:
					dto.setFicnic_category_sub3(sub);
					break;

				default:
					break;
				}
    			cnt++;
    		}
    	}
    	
    	// 들어온 구분자 ',' '★' 처리하기
    	if (dto.getFicnic_option_title()!=null) dto.setFicnic_option_title(dto.getFicnic_option_title().replace(",", "★"));
    	if (dto.getFicnic_option_price()!=null) dto.setFicnic_option_price(dto.getFicnic_option_price().replace(",", "★"));
    	if (dto.getFicnic_select_title()!=null) dto.setFicnic_select_title(dto.getFicnic_option_title().replace(",",  "★"));
    	if (dto.getFicnic_select_price()!=null) dto.setFicnic_option_price(dto.getFicnic_option_price().replace(",","★"));
    	String res="";
    	

		/* 피크닉 정보(info) 처리 */
    	if(dto.getFicnic_info()!=null) {
    		String[] infoList = dto.getFicnic_info().split(",");
        	cnt=0;
        	for(String info : infoList) {
        		if(cnt%2==0) {
        			res+=info+",";	
        		}else{
        			res+=info;
        			if(cnt!= infoList.length-1) res+="★";
        		}
        		cnt++;	
        	}
    	}
    	
    	
    	
    	
    	dto.setFicnic_info(res);
    	
    	
    	
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
    	int cnt = 0;

    	// 기존에 있던 해당 피크닉 상품 정보 불러와야한다.
    	FicnicDTO fdto = this.dao.getFicnicCont(no);
    	List<CategoryDTO> cList = cdao.getCategoryList();
    	
    	String[] optionTitle = null; if(fdto.getFicnic_option_title()!= null) optionTitle = fdto.getFicnic_option_title().split("★");
    	Object[] optionPrice = null; if(fdto.getFicnic_option_price()!= null) optionPrice = fdto.getFicnic_option_price().split("★");
	
    	String[] selectTitle = null; if(fdto.getFicnic_select_title()!= null) selectTitle = fdto.getFicnic_select_title().split("★");
    	Object[] selectPrice = null; if(fdto.getFicnic_select_price()!= null) selectPrice = fdto.getFicnic_select_price().split("★");
		 
    	 
    	 
    	List<HashMap<String, Object>> optionList = new ArrayList<HashMap<String,Object>>();
		
    	/* 앞단 보여질 option 처리 */
    	cnt=0;
    	for(String value : optionTitle) {
    		HashMap<String, Object> map = new HashMap<String, Object>();
    		map.put("title", value);
    		map.put("price", Integer.parseInt((String) optionPrice[cnt]));
    		optionList.add(map);
    		cnt++;
    	}   
    	/* 앞단 보여질 select_option 처리 */
    	

    	
    	List<HashMap<String, Object>> selectList = new ArrayList<HashMap<String,Object>>();
		
    	/* 앞단 보여질 option 처리 */
    	/* 앞단 보여질 select_option 처리 */
    		
    	if(selectTitle!=null && selectPrice!=null) {
	    	cnt=0;
	    	for(String value : selectTitle) {
	    		HashMap<String, Object> map = new HashMap<String, Object>();
	    		map.put("title", value);
	    		map.put("price", Integer.parseInt((String) selectPrice[cnt]));
	    		selectList.add(map);
	    		cnt++;
	    	}   
    	}

		/* 앞단 보여질 info 처리 */
    	String[] list =fdto.getFicnic_info().split("★");

    	
    	List<HashMap<String, String>> infoList = new ArrayList<HashMap<String,String>>();
    	
//    	for(String value: list) {
//    		String[] valueList = value.split(",");
//    		HashMap<String, String> map = new HashMap<String, String>();
//    		map.put("title", valueList[0]);
//    		map.put("cont", valueList[1]);
//    		infoList.add(map);
//    	}


    	model.addAttribute("clist", cList);
    	
    	model.addAttribute("fdto",fdto);
    	model.addAttribute("infoList", infoList);

    	model.addAttribute("optionList",optionList);
    	model.addAttribute("selectList",selectList);
    	model.addAttribute("m", "m");
    	
    	return "admin/ficnic/ficnic_write";
    }



    // 피크닉 수정 처리
    @RequestMapping("admin/ficnic/ficnic_modify_ok.do")
    public void ficnicModifyOk(FicnicDTO dto,MultipartHttpServletRequest mRequest,HttpServletResponse response) throws Exception {
    	int cnt=0;
    	response.setContentType("text/html; charset=utf-8");
    	PrintWriter out= response.getWriter();
    	
        // 파일저장 이름 >> thisFolder/saveName_일련번호_밀리세컨드.확장자
    	String ficnic_image1 = mRequest.getParameter("ori_ficnic_image1");
    	String ficnic_image2 = mRequest.getParameter("ori_ficnic_image2");
    	String ficnic_image3 = mRequest.getParameter("ori_ficnic_image3");
    	String ficnic_image4 = mRequest.getParameter("ori_ficnic_image4");
    	String ficnic_image5 = mRequest.getParameter("ori_ficnic_image5");
    	
        List<String> upload_list = UploadFile.fileUpload(mRequest, ficnicFolder, ficnicSaveName);
        cnt=0;
       
        for(int i=0; i<upload_list.size();i++) {
        	 String check_photo = mRequest.getParameter("ori_ficnic_image"+(i+1));
        	if(check_photo !=null && upload_list.get(i) != "") {
                File del_pimage = new File(mRequest.getSession().getServletContext().getRealPath(check_photo));
                if(del_pimage.exists()) del_pimage.delete();
        	}
        	
        }   
        
        if(upload_list.get(0) != "") ficnic_image1 = upload_list.get(0);
        if(upload_list.get(1) != "") ficnic_image2 = upload_list.get(1);
        if(upload_list.get(2) != "") ficnic_image3 = upload_list.get(2);
        if(upload_list.get(3) != "") ficnic_image4 = upload_list.get(3);
        if(upload_list.get(4) != "") ficnic_image5 = upload_list.get(4);
    
        dto.setFicnic_photo1(ficnic_image1);
        dto.setFicnic_photo1(ficnic_image2);
        dto.setFicnic_photo1(ficnic_image3);
        dto.setFicnic_photo1(ficnic_image4);
        dto.setFicnic_photo1(ficnic_image5);       
        
        
        
        
        
    	// 들어온 구분자 ',' 처리하기
    	if (dto.getFicnic_option_title()!=null) dto.setFicnic_option_title(dto.getFicnic_option_title().replace(",", "★"));
    	if (dto.getFicnic_option_price()!=null) dto.setFicnic_option_price(dto.getFicnic_option_price().replace(",", "★"));
    	if (dto.getFicnic_select_title()!=null) dto.setFicnic_select_title(dto.getFicnic_option_title().replace(",",  "★"));
    	if (dto.getFicnic_select_price()!=null) dto.setFicnic_option_price(dto.getFicnic_option_price().replace(",","★"));
    	String res="";
    	

    	
    	if(dto.getFicnic_info()!=null) {
    		String[] infoList = dto.getFicnic_info().split(",");
        	cnt=0;
        	for(String info : infoList) {
        		if(cnt%2==0) {
        			res+=info+",";	
        		}else{
        			res+=info;
        			if(cnt!= infoList.length-1) res+="★";
        		}
        		cnt++;	
        	}
    	}
    	dto.setFicnic_info(res);
    	
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
    	
        // 기존 파일 있으면 삭제 처리
        FicnicDTO fdto =this.dao.getFicnicCont(no);
        
        if(fdto.getFicnic_photo1()!=null) {
            File del_pimage = new File(request.getSession().getServletContext().getRealPath(fdto.getFicnic_photo1()));
            if(del_pimage.exists()) del_pimage.delete();
        	
        }
        if(fdto.getFicnic_photo2()!=null) {
            File del_pimage = new File(request.getSession().getServletContext().getRealPath(fdto.getFicnic_photo2()));
            if(del_pimage.exists()) del_pimage.delete();
        	
        }
        if(fdto.getFicnic_photo3()!=null) {
            File del_pimage = new File(request.getSession().getServletContext().getRealPath(fdto.getFicnic_photo3()));
            if(del_pimage.exists()) del_pimage.delete();
        	
        }
        if(fdto.getFicnic_photo4()!=null) {
            File del_pimage = new File(request.getSession().getServletContext().getRealPath(fdto.getFicnic_photo4()));
            if(del_pimage.exists()) del_pimage.delete();
        	
        }
        if(fdto.getFicnic_photo5()!=null) {
            File del_pimage = new File(request.getSession().getServletContext().getRealPath(fdto.getFicnic_photo5()));
            if(del_pimage.exists()) del_pimage.delete();
        	
        }

        
        
    	if(this.dao.deleteFicnic(no)>0) {
    		this.dao.updateSeq(no);
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