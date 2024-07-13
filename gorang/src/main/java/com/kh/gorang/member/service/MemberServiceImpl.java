package com.kh.gorang.member.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.gorang.member.model.dao.MemberDao;
import com.kh.gorang.member.model.dto.NotifyDto;
import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.member.model.vo.ProductCart;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private SqlSessionTemplate sqlSession; // 기존의 myBaits SqlSession객체 대체
	
	@Autowired
	private MemberDao memberDao;
	
	@Transactional(readOnly = true)
	@Override
	public Member loginMember(Member m) {
		// SqlSessionTemplate bean등록 후 @Autowired했음
		// 스프링이 사용 후 자동으로 반납시켜주기 때문에 clse메소드로 자원반납 할 필요가 없음
		//한줄로 기술이 가능
			
		return memberDao.loginMember(sqlSession, m);
	}
	
	@Transactional(readOnly = true)
	@Override
	public int idCheck(String checkId) {
		return memberDao.idCheck(sqlSession, checkId);
	}
	
	@Transactional(readOnly = true)
	@Override
	public int nameCheck(String checkName) {
		return memberDao.nameCheck(sqlSession, checkName);
	}
	
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int insertMember(Member m) {
		return memberDao.insertMember(sqlSession, m);
	}
	
	@Transactional(readOnly = true)
	@Override
	public Member selectMemberByEmail(String email) {
		return memberDao.selectMemberByEmail(sqlSession, email);
	}
	
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int insertProductCart(List<ProductCart> pdCarts) {
		int result = 1;
		// 1. 받아온 장바구니 리스트를 반목문을 통해 쪼갬
		for(ProductCart productCart : pdCarts) {
		// 2. 쪼갠 장바구니 객체를 유저가 기존 장바구니에 저장돼 있는지 조회 통해 저장 여부 확인
			ProductCart productCartRes = memberDao.selectProductCart(sqlSession, productCart);
		// 3. 만약 조회 결과가 없다면 insert, 조회 결과가 있다면 update(선택한 수량을 더해줌)
			if(productCartRes == null) {
				result *= memberDao.insertProductCart(sqlSession, productCart);
			} else {
				result *= memberDao.updateProductCart(sqlSession, productCart);
			}
		}
		return result;
	}
	
	// 로그인한 유저가 담은 장바구니 목록 가져오기 위한 메소드
	@Transactional(readOnly = true)
	@Override
	public ArrayList<ProductCart> selectProductCartList(Member m) {
		return memberDao.selectProductCartList(sqlSession, m);
	}

	// 장바구니 삭제
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int deleteProductCart(int memberNo, List<Integer> optListForDelete) {
		return memberDao.deleteProductCart(sqlSession, memberNo, optListForDelete);
	}
	
	// 핸드폰 중복 체크
	@Transactional(readOnly = true)
	@Override
	public int phoneCheck(String phone) {
		return memberDao.phoneCheck(sqlSession, phone);
	}
	
	// 알림 객체 저장하는 메소드
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int insertNotification(NotifyDto notificationData) {
		return memberDao.insertNotification(sqlSession, notificationData);
	}
	
	// 알림 객체 리스트 반환하는 메소드
	@Transactional(readOnly = true)
	@Override
	public ArrayList<NotifyDto> selectNotificationsByMemberNo(int memberNo) {
		return memberDao.selectNotificationsByMemberNo(sqlSession, memberNo);
	}
	

	
}