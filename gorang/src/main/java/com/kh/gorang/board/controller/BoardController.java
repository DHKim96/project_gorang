package com.kh.gorang.board.controller;

import static com.kh.gorang.common.template.SaveFileController.saveFile;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.kh.gorang.board.model.dto.BoardListDTO;
import com.kh.gorang.board.model.dto.CommentListDTO;
import com.kh.gorang.board.model.dto.InsertCommentDTO;
import com.kh.gorang.board.model.vo.Board;
import com.kh.gorang.board.model.vo.Comment;
import com.kh.gorang.board.model.vo.Report;
import com.kh.gorang.board.service.BoardService;
import com.kh.gorang.common.model.vo.PageInfo;
import com.kh.gorang.common.template.Pagination;
import com.kh.gorang.member.model.vo.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class BoardController {
	
	private final BoardService boardService;
	//게시판 메인
	@RequestMapping("main.bo")
    public String selectListBySort(
            @RequestParam(value="cpage", defaultValue="1") int currentPage,
            @RequestParam(defaultValue="all") String category,
            @RequestParam(value="sort", defaultValue="latest") String sort,
            @RequestParam(defaultValue = "") String content,
            Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("category",category);
		map.put("sort",sort);
		map.put("content",content);
		
		int boardCount = boardService.getBoardCount(map);
		
		PageInfo pi = Pagination.getPageInfo(boardCount, currentPage, 16, 16);
		
		ArrayList<BoardListDTO> boardList = boardService.getBoardList(pi, map);
		
		
		model.addAttribute("category", category);
		model.addAttribute("sort", sort);
		model.addAttribute("content", content);
		model.addAttribute("pi", pi);
		model.addAttribute("boardList", boardList);

        return "board/boardMain";
    }
    
	//게시글 쓰기
	@RequestMapping("write.bo")
	public String commonWrite() {
		return "board/commonWrite";
	}
	
	//게시글 상세
	@RequestMapping("detail.bo")
	public String selectBoard(@RequestParam("boardNo") Integer boardNo,HttpSession session ,Model model) {
	    if (boardNo == null) {
	        model.addAttribute("errorMsg", "게시글 번호가 유효하지 않습니다.");
	        return "board/boardMain";
	    }

	    Board board = boardService.selectBoard(boardNo);
	    
	    Member m = (Member) session.getAttribute("loginUser");
	    
	    if(m != null) {
	    	int memberNo = m.getMemberNo();
		    Map<String, Object> map = new HashMap<String, Object>();
			map.put("memberNo", memberNo);
			map.put("boardNo", boardNo);
		   
		    int isLikedBoard = boardService.isLikedBoard(map);
		    int isScrapBoard = boardService.isScrapBoard(map);
		    model.addAttribute("isLikedBoard", isLikedBoard);
		    model.addAttribute("isScrapBoard", isScrapBoard);
	    } else {
	    	model.addAttribute("isLikedBoard", 0);
	    	model.addAttribute("isScrapBoard", 0);
	    }
	    
	    ArrayList<CommentListDTO> commentList = boardService.getCommentList(boardNo);
	    
	    model.addAttribute("commentList", commentList);
	    
	    int scrapBoardCount = boardService.getScrapBoardCount(boardNo);
	    model.addAttribute("scrapBoardCount",scrapBoardCount);
	    
	    int likeBoardCount = boardService.getLikeBoardCount(boardNo);
	    model.addAttribute("likeBoardCount",likeBoardCount);
	    
	    if (board != null) {
//	    	boardService.increaseViewCount(boardNo);
	        model.addAttribute("board", board);
	        return "board/boardDetail";	
	    } else {
	        model.addAttribute("errorMsg", "게시글 조회 실패");
	        return "board/boardMain";
	    }
	    
	   
	}

	//게시글 추가
	@PostMapping("insert.bo")
	public String insertBoard(
			@ModelAttribute Board board, 
			HttpSession session, 
			Model model,
			@RequestParam(value="upfile", required= false) MultipartFile upfile) {
		
		log.info("upfile={}", upfile.getOriginalFilename());
		
		
		if(!upfile.getOriginalFilename().equals("")) {
			String changeFileName = saveFile(upfile, session, "/board/boardMainContentFile/");
			board.setBoardThumbnail(changeFileName);
		}
//		
		int result = boardService.insertBoard(board);
		if(result>0) {
			session.setAttribute("alertMsg", "게시글을 작성하셨습니다.");
			return "redirect:/main.bo";
		}
		else {
			model.addAttribute("errorMsg", "게시글 작성 실패");
			return "board/write.bo";
		}

	}

	@PostMapping("content.bo")
	@ResponseBody
	public String uploadDetailDesc(List<MultipartFile> fileList, HttpSession session) {
		
		List<String> changeNameList = new ArrayList<String>();
		for(MultipartFile mf : fileList) {
			String changeName = saveFile(mf,session,"/board/boardMainContentFile/");
			changeNameList.add("/board/boardMainContentFile/"+changeName);
		}
		return new Gson().toJson(changeNameList);
	}
	
	@ResponseBody
	@RequestMapping("insert.co")
	public String insertReReply( HttpSession session, InsertCommentDTO insertCommentDTO) {
		int result = 0;
		
		Member m = (Member)session.getAttribute("loginUser");
		insertCommentDTO.setMemberNo(m.getMemberNo());
		
		result = boardService.insertComment(insertCommentDTO);
		
		if(result > 0) {
			return "NNNNY";
		} else {
			return "NNNNN";
		}
		
	}
	
	@ResponseBody
	@RequestMapping("selectList.co")
	public ArrayList<CommentListDTO> getCommentListByAjax(int boradNo){
		return boardService.getCommentList(boradNo);
	}
	
	@GetMapping("update-form.bo") 
	public String updateBoardForm(
			int boardNo,
			Model model) {
		
		Board board = boardService.selectBoard(boardNo);
		
		model.addAttribute("board", board);
			
		return "board/boardUpdateForm";
	}
	
	@PostMapping("update.bo")
	public String updateBoard(
			HttpSession session,
			@ModelAttribute Board board,
			@RequestParam(value="upfile", required= false) MultipartFile upfile) {
		
		
		if(!upfile.getOriginalFilename().equals("")) {
			String changeFileName = saveFile(upfile, session, "/board/boardMainContentFile/");
			board.setBoardThumbnail(changeFileName);
		} else {
			String exBoardThumbnail = boardService.getExBoardThumbnail(board.getBoardNo());
			board.setBoardThumbnail(exBoardThumbnail);
		}
		
		
		int result = boardService.updateBoard(board);
		
		if(result > 0) {
			
			session.setAttribute("msg","게시글을 수정하였습니다");
			return "redirect:/detail.bo?boardNo="+ board.getBoardNo();
		} else {
			session.setAttribute("msg", "게시글 수정을 실패하였습니다.");
			return "redirect:/detail.bo?boardNo="+ board.getBoardNo();
		}
		
		
	}
	
	@PostMapping("delete.bo")
	@ResponseBody
	public String deleteBoard(
			@RequestParam int boardNo) {
		
		int result = boardService.deleteBoard(boardNo);
		
		return result > 0 ? "done" : "undone";
	}
	
	@PostMapping("delete.co")
	@ResponseBody
	public String deleteComment(
			@RequestParam int commentNo) {
		
		int result = boardService.deleteComment(commentNo);
		
		return result > 0 ? "done" : "undone";
	}
	
	
	@PostMapping("like.bo")
	@ResponseBody
	public String likeBoard(
			HttpSession session,
			@RequestParam int boardNo) {
		
		int memberNo = ((Member)session.getAttribute("loginUser")).getMemberNo();
		
		Map<String, Integer> map = new HashMap<>();
		map.put("memberNo", memberNo);
		map.put("boardNo", boardNo);
		
		
		int result = boardService.insertLikeBoard(map);
		
		if(result == 1) {
			return "cancle_like";
		} else if (result == 2) {
			return "do_like";
		} else {
			return "undone";
		}
	}
	
	@PostMapping("scrap.bo")
	@ResponseBody
	public String scrapBoard(
			HttpSession session,
			@RequestParam int boardNo) {
		
		int memberNo = ((Member)session.getAttribute("loginUser")).getMemberNo();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberNo", memberNo);
		map.put("boardNo", boardNo);
		
		int result = boardService.insertScrapBoard(map);
		
		if(result == 1) {
			return "cancle_scrap";
		} else if (result == 2) {
			return "do_scrap";
		} else {
			return "undone";
		}
	}
	
	@PostMapping("report.bo")
	@ResponseBody
	public String reportBoard(
			HttpSession session,
			@ModelAttribute Report report){
		
		int memberNo = ((Member)session.getAttribute("loginUser")).getMemberNo();
		report.setMemberNo(memberNo);
		
		int result = boardService.insertReport(report);
		
		return result > 0 ? "done" : "undone";
	}
	
	
}