package com.kh.gorang.board.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.gorang.board.model.dao.BoardDao;
import com.kh.gorang.board.model.vo.Board;
import com.kh.gorang.board.model.vo.Comment;
import com.kh.gorang.common.vo.PageInfo;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Autowired
    private BoardDao boardDao;

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
        return boardDao.selectBoard(sqlSession, boardNo);
    }

    @Override
    public int insertBoard(Board board) {
        return boardDao.insertBoard(sqlSession, board);
    }

    @Override
    public void increaseViewCount(int boardNo) {
        boardDao.increaseViewCount(sqlSession, boardNo);
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

    @Override
    public int insertComment(Comment comment) {
        return boardDao.insertComment(sqlSession, comment);
    }

    @Override
    public int deleteComment(int commentNo) {
        return boardDao.deleteComment(sqlSession, commentNo);
    }
}
