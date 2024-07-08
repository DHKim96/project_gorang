package com.kh.gorang.member.service;

import java.util.ArrayList;
import java.util.List;

import com.google.gson.JsonElement;
import com.kh.gorang.member.model.dto.NotifyDto;
import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.member.model.vo.ProductCart;

public interface MemberService {
	//로그인서비스
	Member loginMember(Member m);
	
	//id check를 위한 서비스
	int idCheck(String checkId);
	
	// nickname check
	int nameCheck(String checkName);
	
	//회원가입
	int insertMember(Member m);

	Member selectMemberByEmail(String email);
	
	// 장바구니 저장
	int insertProductCart(List<ProductCart> pdCarts);
	
	// 장바구니 목록 불러오기 
	ArrayList<ProductCart> selectProductCartList(Member m);
	
	// 장바구니 삭제
	int deleteProductCart(int memberNo, List<Integer> optListForDelete);
	
	// 핸드폰 번호 중복 체크
	int phoneCheck(String phone);

	int insertNotification(NotifyDto notificationData);

	ArrayList<NotifyDto> selectNotificationsByMemberNo(int memberNo);

	
}
