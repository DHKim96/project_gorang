package com.kh.gorang.board.service;

import java.util.ArrayList;
import java.util.Map;

import com.kh.gorang.board.model.dto.BoardListDTO;
import com.kh.gorang.board.model.dto.CommentListDTO;
import com.kh.gorang.board.model.dto.InsertCommentDTO;
import com.kh.gorang.board.model.vo.Board;

import com.kh.gorang.board.model.vo.Comment;
import com.kh.gorang.board.model.vo.Report;
import com.kh.gorang.common.model.vo.PageInfo;

public interface BoardService{
	// 게시글 총 갯수 가져오기
    int selectListCount();

    // 게시글 리스트 조회(게시글메인)
    ArrayList<Board> selectList(PageInfo pi);

    // 게시글 리스트 조회(최신 순)
    ArrayList<Board> selectListByLatest(PageInfo pi);

    // 게시글 리스트 조회(조회수 순)
    ArrayList<Board> selectListByViewCount(PageInfo pi);

    // 게시글 리스트 조회(태그별)
    ArrayList<Board> selectListByTag(PageInfo pi, String tag);

    // 상세 게시글 조회
    Board selectBoard(int boardNo);

    // 게시글 추가
    int insertBoard(Board board);

    // 게시글 조회수 증가
//    void increaseViewCount(int boardNo);
    
    // 게시글 글쓴이 이름 가져오기
	String getMemberNickname(int memberNo);
	
	//게시글 댓글 리스트
	ArrayList<Comment> selectCommentList(int boardNo, PageInfo pi);
    
    // 게시글에 댓글 추가
    int insertComment(InsertCommentDTO insertCommentDTO);
    
    // 댓글 삭제
    int deleteComment(int commentNo);

    
    //===================================================================
    
    
    // 게시글 개수 조회
	int getBoardCount(Map<String, Object> map);

	ArrayList<BoardListDTO> getBoardList(PageInfo pi, Map<String, Object> map);

	ArrayList<CommentListDTO> getCommentList(int boardNo);

	String getExBoardThumbnail(int boardNo);

	int updateBoard(Board board);

	int deleteBoard(int boardNo);

	int insertLikeBoard(Map<String, Object> map);

	int isLikedBoard(Map<String, Object> map);

	int insertReport(Report report);

	int insertScrapBoard(Map<String, Object> map);

	int isScrapBoard(Map<String, Object> map);

	int getScrapBoardCount(Integer boardNo);

	int getLikeBoardCount(Integer boardNo);

	
	
}	