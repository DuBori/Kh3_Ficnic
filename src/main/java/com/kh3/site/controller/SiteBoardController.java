package com.kh3.site.controller;

import java.io.File;
import java.net.http.HttpResponse;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh3.model.board.BoardCategoryDAO;
import com.kh3.model.board.BoardConfDAO;
import com.kh3.model.board.BoardConfDTO;
import com.kh3.model.board.BoardDAO;
import com.kh3.model.board.BoardDTO;
import com.kh3.util.PageDTO;
import com.kh3.util.Paging;


@Controller
public class SiteBoardController {

	@Inject
	private BoardDAO board_Dao;
	
	@Inject
	private BoardCategoryDAO board_CategoryDao;
	
	@Inject
	private BoardConfDAO board_ConfDao; 
	

	// 전체 게시물의 수
    private int totalRecord = 0;

	
	private String path="site/board/";
	
//	HttpServletRequest request;
//	String bbs_id = request.getParameter("bbs_id");
//	
//	
	/* 해당 게시판 리스트 조회 메서드 */
	@RequestMapping("/site/board/board_list.do")
	public String board_list(HttpServletRequest request,Model model) {
		
		// skin 처리 미완성
		String board_skin = "basic";
        
		
		String field = request.getParameter("field");
        String keyword = request.getParameter("keyword");
        String bbs_id = request.getParameter("bbs_id");
        
        BoardConfDTO BoardConfdto = board_ConfDao.getBoardCont(bbs_id);
    	
        //해당 게시물 설정값 가져오기
        // 한 페이지당 보여질 게시물의 수 -> 해당 게시물 설정값 가져와야한다.
        int rowsize = BoardConfdto.getBoard_list_num();
        
        
        if(field == null) field = "";
        if(keyword == null) keyword = "";
        
        // 페이징 처리
        int page; // 현재 페이지 변수
        if(request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }else{
            page = 1;
        }
        
        totalRecord = this.board_Dao.getListCount(field, keyword,bbs_id);
        
        // 페이징 DTO
        
        Map<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("field", field);
        searchMap.put("keyword", keyword);
        searchMap.put("bbs_id", bbs_id);
        
        PageDTO dto = new PageDTO(page, rowsize, totalRecord,searchMap);
        
        // 페이지 이동 URL
        String pageUrl = request.getContextPath()+"site/board/board_list.do?field="+field+"&keyword="+keyword;

        model.addAttribute("List", this.board_Dao.getBoardList(dto.getStartNo(),dto.getEndNo(),searchMap));
       
        model.addAttribute("board", BoardConfdto);
    	model.addAttribute("totalCount", totalRecord);
        model.addAttribute("paging", dto);
        model.addAttribute("field", field);
        model.addAttribute("keyword", keyword);
        model.addAttribute("pagingWrite", Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));

        return "/site/board/"+board_skin+"/board_list";
	}
	
	/* 해당 게시판 게시글 작성 폼 페이지 이동 메서드*/
	@RequestMapping("/site/board/*/board_write.do")
	public String board_write(HttpServletRequest request,Model model) {
		
		
		String bbs_id = request.getParameter("bbs_id");
		if(bbs_id == null) bbs_id ="";
		
		BoardConfDTO BoardConfdto = board_ConfDao.getBoardCont(bbs_id);
		
		model.addAttribute("board", BoardConfdto);
		
		return "/site/board/"+BoardConfdto.getBoard_skin()+"/board_write";
	}

	/* 해당 게시판 게시글 작성 완료 메서드 */
	@RequestMapping("/site/board/board_write_ok.do")
	public boolean board_write_ok(MultipartHttpServletRequest request,HttpServletResponse response, BoardDTO boardDTO) {
		
		boolean isUpload = false;
		
		String uploadPath="";
		
		Calendar cal= Calendar.getInstance();
		
		int year = cal.get(Calendar.YEAR);
		
		int month = cal.get(Calendar.MONTH)+1;
		
		int day = cal.get(Calendar.DAY_OF_MONTH);
		
		//해당 데이터 내용 db에 업로드
		if(board_Dao.insertBoardCont(boardDTO)>0) {
			// 업로드된 파일들의 이름 목록을 제공하는 메서드.
			Iterator<String> iterator =request.getFileNames();
			
			while(iterator.hasNext()) {
				String uploadFileName = iterator.next();
				
				MultipartFile mFlie = request.getFile(uploadFileName);
				
				String FullFileName = mFlie.getOriginalFilename();
			
				// 실제 폴더를 만들어 보자
				// .........\\ resources\\upload\\2022-11-25
				
				// 날짜별 파일 생성
				String homedir = uploadPath + year+"-"+month+"-"+day;
				
				File path1 = new File(homedir);
				if(!path1.exists()) {
					path1.mkdirs();
				}
				
				// 실제 파일을 만들어 보자
				
				String saveFileName = FullFileName;
				
				if(!saveFileName.equals("")) {
				
					saveFileName = System.currentTimeMillis()+"_"+saveFileName;
					try {
						File origin = new File(homedir+"/"+saveFileName);
						
						// 파일 데이터를 지정한 폴더로 실제로 이동시키는 메서드 --> 그냥 경로 설정
						mFlie.transferTo(origin);
						
						isUpload = true;
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}

		}
		return isUpload;
	}

	/* 게시글 눌렀을 때 이동하는 메서드 */
	@RequestMapping("/site/board/board_view.do")
	public String board_modify(HttpServletRequest request,Model model) {
		
		
		String bbs_id = request.getParameter("bbs_id");
		BoardConfDTO BoardConfdto = board_ConfDao.getBoardCont(bbs_id);
		
		// 페이징 및 검색 처리
		String field = request.getParameter("field");
        String keyword = request.getParameter("keyword");
      

        //해당 게시물 설정값 가져오기
        // 한 페이지당 보여질 게시물의 수 -> 해당 게시물 설정값 가져와야한다.
        int rowsize = BoardConfdto.getBoard_list_num();
        
        
        if(field == null) field = "";
        if(keyword == null) keyword = "";
        
        // 페이징 처리
        int page; // 현재 페이지 변수
        if(request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }else{
            page = 1;
        }
        
        totalRecord = this.board_Dao.getListCount(field, keyword,bbs_id);
        
        // 페이징 DTO
        
        Map<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("field", field);
        searchMap.put("keyword", keyword);
        searchMap.put("bbs_id", bbs_id);
        
        PageDTO dto = new PageDTO(page, rowsize, totalRecord,searchMap);
        
        // 페이지 이동 URL
        String pageUrl = request.getContextPath()+"site/board/board_list.do?field="+field+"&keyword="+keyword;
        
		model.addAttribute("field", field);
		model.addAttribute("keyword", keyword);
		
		model.addAttribute("board", BoardConfdto);
    	model.addAttribute("totalCount", totalRecord);
        model.addAttribute("paging", dto);
        model.addAttribute("field", field);
        model.addAttribute("keyword", keyword);
        model.addAttribute("pagingWrite", Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));
        
		return "/site/board/"+BoardConfdto.getBoard_skin()+"/board_view";
	}
	
}
