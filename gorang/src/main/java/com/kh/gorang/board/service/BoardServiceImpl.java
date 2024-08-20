package com.kh.gorang.board.service;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.gorang.board.model.dao.BoardDao;
import com.kh.gorang.board.model.dto.BoardListDTO;
import com.kh.gorang.board.model.dto.CommentDtoForNotify;
import com.kh.gorang.board.model.dto.CommentListDTO;
import com.kh.gorang.board.model.dto.InsertCommentDTO;
import com.kh.gorang.board.model.vo.Board;
import com.kh.gorang.board.model.vo.Comment;
import com.kh.gorang.board.model.vo.Report;
import com.kh.gorang.common.event.CommentCreatedEvent;
import com.kh.gorang.common.event.LikeCreatedEvent;
import com.kh.gorang.common.model.vo.PageInfo;
import com.kh.gorang.member.model.dao.MemberDao;
import com.kh.gorang.member.model.dto.LikeDtoForNotify;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class BoardServiceImpl implements BoardService {

    private final SqlSessionTemplate sqlSession;
    private final BoardDao boardDao;
    private final MemberDao memberDao;
    private final ApplicationEventPublisher eventPublisher; // 이벤트 발행을 위한 객체

    @Override
    public int selectListCount() {
        return boardDao.selectListCount(sqlSession);
    }

    @Override
    public ArrayList<Board> selectList(PageInfo pi) {
        return boardDao.selectList(sqlSession, pi);
    }

    @Override
    public Board selectBoard(int boardNo) {
    	
    	Board selectboardResult = null;
    	int increaseViewCount = boardDao.increaseViewCount(sqlSession, boardNo);
    	
    	if(increaseViewCount > 0) {
    		selectboardResult = boardDao.selectBoard(sqlSession, boardNo);
    	}
    	
        return selectboardResult;
    }

    @Override
    public int insertBoard(Board board) {
        return boardDao.insertBoard(sqlSession, board);
    }

    @Override
    public ArrayList<Board> selectListByLatest(PageInfo pi) {
        return boardDao.selectListByLatest(sqlSession, pi);
    }

    @Override
    public ArrayList<Board> selectListByViewCount(PageInfo pi) {
        return boardDao.selectListByViewCount(sqlSession, pi);
    }

    @Override
    public ArrayList<Board> selectListByTag(PageInfo pi, String tag) {
        return boardDao.selectListByTag(sqlSession, pi, tag);
    }
   
    @Override
    public String getMemberNickname(int memberNo) {
        return boardDao.getMemberNickname(sqlSession, memberNo);
    }
    @Override
    public ArrayList<Comment> selectCommentList(int boardNo, PageInfo pi) {
        return boardDao.selectCommentList(sqlSession, boardNo, pi);
    }
    
    @Transactional(rollbackFor = {Exception.class})
    @Override
    public int insertComment(InsertCommentDTO insertCommentDTO) {
    	int result = 0;
    	if(insertCommentDTO.getRefCommentNo() == 0) { // 그냥 원댓글 전용
    		result = boardDao.insertComment(sqlSession, insertCommentDTO);
    	} else { // 대댓글 insert 전용
    		result = boardDao.insertReReply(sqlSession, insertCommentDTO);
    	}
    	if (result > 0) {
    		// 댓글 작성 이벤트 발행
    		CommentDtoForNotify comment = boardDao.selelctComment(sqlSession, insertCommentDTO.getCommentNo());
    		int boardWriterNo = boardDao.selectBoardWriterNo(sqlSession, insertCommentDTO.getBoardNo());
    		eventPublisher.publishEvent(new CommentCreatedEvent(comment, boardWriterNo));
    	}
    	return result;
    }

    @Override
    public int deleteComment(int commentNo) {
        return boardDao.deleteComment(sqlSession, commentNo);
    }

	@Override
	public int getBoardCount(Map<String, Object> map) {
		return boardDao.getBoardCount(sqlSession, map);
	}

	@Override
	public ArrayList<BoardListDTO> getBoardList(PageInfo pi, Map<String, Object> map) {
		return boardDao.getBoardList(sqlSession, pi, map);
	}

	// 댓글 리스트 조회
	@Override
	public ArrayList<CommentListDTO> getCommentList(int boardNo) {
		return boardDao.getCommentList(sqlSession, boardNo);
	}

	@Override
	public String getExBoardThumbnail(int boardNo) {
		return boardDao.getExBoardThumbnail(sqlSession, boardNo);
	}

	@Override
	public int updateBoard(Board board) {
		return boardDao.updateBoard(sqlSession, board);
	}

	@Override
	public int deleteBoard(int boardNo) {
		return boardDao.deleteBoard(sqlSession, boardNo);
	}

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int insertLikeBoard(Map<String, Integer> map) {

		//like_board에 memberNo와 boardNo를 갖고 있는 컬럼이 있는지 확인 후
		// 없다면 Insert, 있다면 삭제해주자.;
		// return이 0이면 실패
		// return이 1이면 좋아요 취소
		// return이 2이면 좋아요 
		int existLikeBoard = boardDao.existLikeBoard(sqlSession, map);
		
		if(existLikeBoard == 0) {
			// like_board에 insert
			int insertLikeBoard = boardDao.insertLikeBoard(sqlSession, map);
			
			if(insertLikeBoard > 0) {
				// 댓글 작성 이벤트 발행
				int memberNo = map.get("memberNo");
				int boardNo = map.get("boardNo");
						
				LikeDtoForNotify like = memberDao.getLikeForNotify(sqlSession, memberNo, boardNo, 1);
	    		int boardWriterNo = boardDao.selectBoardWriterNo(sqlSession, boardNo);
	    		eventPublisher.publishEvent(LikeCreatedEvent.builder()
	    									.like(like)
	    									.boardWriterNo(boardWriterNo)
	    									.likeType(1)
	    									.build()
	    									);
				return 2;
			}
		} else {
			// like_board에 값 삭제
			int deleteLikeBoard = boardDao.deleteLikeBoard(sqlSession, map);
			
			if(deleteLikeBoard > 0) {
				return 1;
			}
		}
		
		return 0;
	}
	
	@Override
	public int insertScrapBoard(Map<String, Object> map) {
		
		// 스크랩에 있는지 확인 후
		// 있으면 삭제하고 return 1, 없으면 넣어주고 return 2, 실패시 return 0
		
		int existScrapBoard = boardDao.existScrapBoard(sqlSession, map);
		
		if(existScrapBoard == 0) {
			// scrap_board에 insert
			int insertScrapBoard = boardDao.insertScrapBoard(sqlSession, map);
			
			if(insertScrapBoard > 0) {
				return 2;
			}
			
		} else {
			// scrap_board에 값 삭제
			int deleteScrapBoard = boardDao.deleteScrapBoard(sqlSession, map);
			
			if(deleteScrapBoard > 0) {
							
				return 1;
			}
		}
		
		return 0;
	}

	@Override
	public int isLikedBoard(Map<String, Object> map) {
		return boardDao.isLikedBoard(sqlSession, map);
	}

	@Override
	public int insertReport(Report report) {
		return boardDao.insertReport(sqlSession, report);
	}

	@Override
	public int isScrapBoard(Map<String, Object> map) {
		return boardDao.isScrapBoard(sqlSession, map);
	}

	@Override
	public int getScrapBoardCount(Integer boardNo) {
		return boardDao.getScrapBoardCount(sqlSession, boardNo);
	}

	@Override
	public int getLikeBoardCount(Integer boardNo) {
		return boardDao.getLikeBoardCount(sqlSession, boardNo);
	}

	

}
