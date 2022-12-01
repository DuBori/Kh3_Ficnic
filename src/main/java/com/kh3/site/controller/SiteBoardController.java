package com.kh3.site.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh3.model.board.BoardCommentDAO;
import com.kh3.model.board.BoardCommentDTO;
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
	private BoardCommentDAO board_CommDao;

	@Inject
	private BoardConfDAO board_ConfDao;

	// 전체 게시물의 수
	private int totalRecord = 0;

	String board_skin="";
	/* 해당 게시판 리스트 조회 메서드 */
	@RequestMapping("/site/board/board_list.do")
	public String board_list(HttpServletRequest request, Model model) {

		String field = request.getParameter("field");
		String keyword = request.getParameter("keyword");
		String bbs_id = request.getParameter("bbs_id");

		/* 해당 게시판 설정 DTO */
		// 해당 게시물 설정값 가져오기
		BoardConfDTO BoardConfdto = board_ConfDao.getBoardConfCont(bbs_id);
		board_skin = BoardConfdto.getBoard_skin();
		
		// 한 페이지당 보여질 게시물의 수 -> 해당 게시물 설정값 가져와야한다.
		int rowsize = BoardConfdto.getBoard_list_num();

		if (field == null)
			field = "";
		if (keyword == null)
			keyword = "";

		// 페이징 처리
		int page; // 현재 페이지 변수
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		} else {
			page = 1;
		}

		totalRecord = this.board_Dao.getListCount(field, keyword, bbs_id);

		// 페이징 DTO

		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("field", field);
		searchMap.put("keyword", keyword);
		searchMap.put("bbs_id", bbs_id);

		PageDTO dto = new PageDTO(page, rowsize, totalRecord, searchMap);

		// 페이지 이동 URL
		String pageUrl = request.getContextPath() + "site/board/board_list.do?field=" + field + "&keyword=" + keyword;

		model.addAttribute("List", this.board_Dao.getBoardList(dto.getStartNo(), dto.getEndNo(), searchMap));

		// 목록보기 , 글보기 , 글쓰기 , 공지사항 쓰기 
		// 댓글 쓰기 , 모든 글 수정 가능 권한 , 모든 글 삭제 권한
		model.addAttribute("boardConfig", BoardConfdto);
		model.addAttribute("totalCount", totalRecord);
		model.addAttribute("paging", dto);
		model.addAttribute("field", field);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pagingWrite",Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));
		model.addAttribute("bbs_id", bbs_id);
		
		return "/site/board/" + board_skin + "/board_list";
	}

	/* 해당 게시판 게시글 작성 폼 페이지 이동 메서드 */
	@RequestMapping("/site/board/board_write.do")
	public String board_write(HttpServletRequest request, Model model) {

		String bbs_id = request.getParameter("bbs_id");
		if (bbs_id == null) bbs_id = "";

		BoardConfDTO BoardConfdto = board_ConfDao.getBoardConfCont(bbs_id);
		board_skin = BoardConfdto.getBoard_skin();
		
		model.addAttribute("board", BoardConfdto);
		model.addAttribute("bbs_id", bbs_id);
		return "/site/board/" + board_skin + "/board_write";
	}
	/* 해당 게시판 게시글 수정 폼 페이지 이동 */
	@RequestMapping("/site/board/board_modify.do")
	public String board_modify(HttpServletRequest request, Model model) {
		
		String bbs_id = request.getParameter("bbs_id");
		if (bbs_id == null) bbs_id = "";
		
		return null;
	}
	
	/* 해당 게시판 게시글 작성 완료 메서드 */
	@RequestMapping("/site/board/board_write_ok.do")
	public void board_write_ok(MultipartHttpServletRequest mrequest, HttpServletResponse response, BoardDTO dto) {


		//config 테이블 id
		String bbs_id=mrequest.getParameter("board_id");
		
		System.out.println(mrequest.getFile("bdata_file1"));
		System.out.println(mrequest.getFile("bdata_file2"));
		
		
		String uploadPath = mrequest.getSession().getServletContext().getRealPath("/")+"resources\\data\\board\\"+bbs_id+"\\";

		System.out.println(uploadPath);

		Iterator<String> iterator =mrequest.getFileNames();
		  
		while(iterator.hasNext()) { 
		 
		  String uploadFileName = iterator.next();
		  
		  MultipartFile mFlie = mrequest.getFile(uploadFileName);
		  
		  
		  
		  String FullFileName = bbs_id+"_"+System.currentTimeMillis()+"_"+mFlie.getOriginalFilename();
		  System.out.println("FullFilename >>> "+FullFileName); 	  
		  try { 
			  File origin = new File(uploadPath+"/"+FullFileName);
			  // 파일 데이터를 지정한 폴더로 실제로 이동시키는 메서드 -->  경로 설정임.
			  mFlie.transferTo(origin);
			  
		  } catch (Exception e) { // TODO Auto-generated catch block
			  e.printStackTrace(); 
			  } 
		  
		  }
		  
			  
			  
	}


	/* 게시글 눌렀을 때 이동 메서드 */
	@RequestMapping("/site/board/board_view.do")
	public String board_view(HttpServletRequest request, Model model) {
		String bbs_id = request.getParameter("bbs_id");

		int bdata_no = 0;
		if (request.getParameter("bdata_no") != null) {
			bdata_no = Integer.parseInt(request.getParameter("bdata_no"));
		}

		/* 게시글 리스트 출력 */
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bbs_id", bbs_id);
		map.put("bdata_no", bdata_no);

		/* 조회수 증가 */
		board_Dao.updateBoardHit(map);

		// 해당 게시판 해당 게시글 가져오기
		BoardDTO BoardConDto = board_Dao.getBoardCont(map);

		// 해당 게시판 해당 게시글 해당 댓글 리스트 가져오기
		List<BoardCommentDTO> BoardCommentList = board_CommDao.getBoardCommList(map);

		/* 게시글 설정값 DTO */
		BoardConfDTO BoardConfdto = board_ConfDao.getBoardConfCont(bbs_id);
		board_skin = BoardConfdto.getBoard_skin();
		
		// 해당 게시판 해당 게시글 내용
		model.addAttribute("BoardConDto", BoardConDto);
		model.addAttribute("boardCommentList", BoardCommentList);

		model.addAttribute("bbs_id", bbs_id);
		/* 게시글 설정값 DTO */
		model.addAttribute("boardConf", BoardConfdto);

		return "/site/board/" + board_skin + "/board_view";
	}

	/* 해당 게시판 댓글 삭제하기 */
	@RequestMapping("/site/board/baord_comment_delete.do")
	public void board_comment_delete(HttpServletResponse response, HttpServletRequest request) throws IOException {

		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();

		/* 게시글 접근 변수, 해당 게시글 번호 변수 bdata_no 해당 댓글 번호 bcomm_no 필요 */
		String bbs_id = request.getParameter("bbs_id");

		int bdata_no = 0;
		int bcomm_no = 0;

		if (request.getParameter("bdata_no") != null) {
			bdata_no = Integer.parseInt(request.getParameter("bdata_no"));
		}
		if (request.getParameter("bcomm_no") != null) {
			bcomm_no = Integer.parseInt(request.getParameter("bcomm_no"));
		}
		/* 게시글 접근 변수, 해당 게시글 번호 변수 bdata_no 해당 댓글 번호 bcomm_no 필요 end */

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bbs_id", bbs_id);
		map.put("bdata_no", bdata_no);
		map.put("bcomm_no", bcomm_no);

		if (board_CommDao.deleteBoardComm(map) > 0) {
			out.println("<script>location.href='" + request.getContextPath() + "/site/board/board_view.do?bbs_id="+bbs_id+"&bdata_no="+bdata_no+"';</script>");
		} else {
			out.println("<script>alert('댓글 삭제 실패'); history.back();</script>");
		}
	}

	/* 게시글 댓글 입력  */
	@RequestMapping("/site/board/baord_comment_insert.do")
	public void baord_comment_insert(HttpServletResponse response, HttpServletRequest request, BoardCommentDTO dto)
			throws IOException {

		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();

		String bbs_id = request.getParameter("bbs_id");

		int bdata_no = 0;
		if (request.getParameter("bdata_no") != null) {
			bdata_no = Integer.parseInt(request.getParameter("bdata_no"));
		}
		
		// 해당 게시판 게시글 || 폼으로 부터 입력받은 dto 데이터
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bbs_id", bbs_id);
		map.put("dto",dto);
		 
		if(board_CommDao.insertBoardComm(map)>0) {
			out.println("<script>location.href='" + request.getContextPath() + "/site/board/board_view.do?bbs_id="+bbs_id+"&bdata_no="+bdata_no+"';</script>");
		}else {
			
		}
		
	}

}
