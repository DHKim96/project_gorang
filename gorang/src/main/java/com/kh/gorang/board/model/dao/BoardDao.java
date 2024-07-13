package com.kh.gorang.board.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.gorang.board.model.dto.BoardListDTO;
import com.kh.gorang.board.model.dto.CommentListDTO;
import com.kh.gorang.board.model.dto.InsertCommentDTO;
import com.kh.gorang.board.model.vo.Board;
import com.kh.gorang.board.model.vo.Comment;
import com.kh.gorang.board.model.vo.Report;
import com.kh.gorang.common.model.vo.PageInfo;


@Repository
public class BoardDao{
	
	public int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.selectListCount");
	}
	
	public ArrayList<Board> selectList(SqlSessionTemplate sqlSession, PageInfo pi){
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.selectList", null, rowBounds);
	}
	
	public ArrayList<Board> selectListByViewCount(SqlSessionTemplate sqlSession, PageInfo pi) {
        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
        return (ArrayList)sqlSession.selectList("boardMapper.selectListByViewCount", null, rowBounds);
    }
    
    public ArrayList<Board> selectListByLatest(SqlSessionTemplate sqlSession, PageInfo pi) {
        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
        return (ArrayList)sqlSession.selectList("boardMapper.selectListByLatest", null, rowBounds);
    }
    
    public ArrayList<Board> selectListByTag(SqlSessionTemplate sqlSession, PageInfo pi, String tag){
        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
        return (ArrayList)sqlSession.selectList("boardMapper.selectListByTag", tag, rowBounds);
    }
    
    public Board selectBoard(SqlSessionTemplate sqlSession, int boardNo) {
	    return sqlSession.selectOne("boardMapper.selectBoard", boardNo);
	}

	public int insertBoard(SqlSessionTemplate sqlSession, Board board) {
		return sqlSession.insert("boardMapper.insertBoard",board);
	}
	
	public int increaseViewCount(SqlSessionTemplate sqlSession, int boardNo) {
        return sqlSession.update("boardMapper.increaseViewCount", boardNo);
    }
	public String getMemberNickname(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("boardMapper.getMemberNickname", memberNo);
	}
	
	public ArrayList<Comment> selectCommentList(SqlSessionTemplate sqlSession, int boardNo, PageInfo pi) {
        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
        return (ArrayList) sqlSession.selectList("commentMapper.selectCommentList", boardNo, rowBounds);
    }

    public int insertComment(SqlSessionTemplate sqlSession, InsertCommentDTO InsertCommentDTO) {
        return sqlSession.insert("commentMapper.insertComment", InsertCommentDTO);
    }

    public int deleteComment(SqlSessionTemplate sqlSession, int commentNo) {
        return sqlSession.delete("commentMapper.deleteComment", commentNo);
    }

// =====================================================================================================
	public int getBoardCount(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("boardMapper.selectBoardCount", map);
	}

	public ArrayList<BoardListDTO> getBoardList(SqlSessionTemplate sqlSession, PageInfo pi, Map<String, Object> map) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectBoardList", map, rowBounds);
	}

	// 댓글 조회
	public ArrayList<CommentListDTO> getCommentList(SqlSessionTemplate sqlSession, int boardNo) {
		return (ArrayList)sqlSession.selectList("commentMapper.selectCommentList", boardNo);
	}

	
	public int insertReReply(SqlSessionTemplate sqlSession, InsertCommentDTO insertCommentDTO) {
		return sqlSession.insert("commentMapper.insertReReply", insertCommentDTO);
	}

	
	public String getExBoardThumbnail(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.selectOne("boardMapper.selectExBoardThumbnail", boardNo);
	}

	public int updateBoard(SqlSessionTemplate sqlSession, Board board) {
		return sqlSession.update("boardMapper.updateBoard", board);
		
	}

	public int deleteBoard(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.update("boardMapper.deleteBoard", boardNo);
	}

	public int checkLikeBoard(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("boardMapper.selectLikeBoard", map);
	}

	public int insertLikeBoard(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.insert("boardMapper.insertLikeBoard", map);
	}

	public int isLikedBoard(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("boardMapper.selectLikedBoard", map);
	}

	public int insertReport(SqlSessionTemplate sqlSession, Report report) {
		return sqlSession.insert("boardMapper.insertReport", report);
	}

	public int existScrapBoard(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("boardMapper.existScrapBoard", map);
	}

	public int insertScrapBoard(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.insert("boardMapper.insertScrapBoard", map);
	}

	public int deleteScrapBoard(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.delete("boardMapper.deleteScrapBoard", map);
	}

	public int isScrapBoard(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("boardMapper.selectScrapBoard", map);
	}

	public int getScrapBoardCount(SqlSessionTemplate sqlSession, Integer boardNo) {
		return sqlSession.selectOne("boardMapper.getScrapBoardCount", boardNo);
	}

	public int existLikeBoard(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("boardMapper.existLikeBoard",map);
	}

	public int deleteLikeBoard(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.delete("boardMapper.deleteLikeBoard", map);
	}

	public int getLikeBoardCount(SqlSessionTemplate sqlSession, Integer boardNo) {
		return sqlSession.selectOne("boardMapper.getLikeBoardCount", boardNo);
	}
	
}
