package com.kh.gorang.manager.service;

import java.util.ArrayList;

import com.kh.gorang.board.model.vo.Board;
import com.kh.gorang.board.model.vo.BoardSearchDTO;
import com.kh.gorang.member.model.vo.Member;

public interface ManagerService {

	// ajax 상품 검색
	ArrayList<BoardSearchDTO> ajaxSearchBoard(String searchBoardTitle);

	// ajax 회원 검색
	ArrayList<Member> ajaxSearchMember(String searchMember);

}
