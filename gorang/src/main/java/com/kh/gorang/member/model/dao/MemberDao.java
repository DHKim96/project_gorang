package com.kh.gorang.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.gorang.member.model.dto.LikeDtoForNotify;
import com.kh.gorang.member.model.dto.QnaDtoForNotify;
import com.kh.gorang.member.model.dto.ReviewDtoForNotify;
import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.member.model.vo.ProductCart;
import com.kh.gorang.member.model.vo.QnA;
import com.kh.gorang.notification.model.vo.NotifyDto;

@Repository
public class MemberDao {
	public Member loginMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.loginMember", m);
	}
	
	public int idCheck(SqlSessionTemplate sqlSession, String checkId) {
		return sqlSession.selectOne("memberMapper.idCheck", checkId);
	}
	
	public int nameCheck(SqlSessionTemplate sqlSession, String checkName) {
		return sqlSession.selectOne("memberMapper.nameCheck", checkName);
	}
	
	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertMember", m);
	}

	public Member selectMemberByEmail(SqlSessionTemplate sqlSession, String email) {
		return sqlSession.selectOne("memberMapper.selectMemberByEmail", email);
	}
	
//	=============================== 장바구니 관련 =================================================
	
	public int insertProductCart(SqlSessionTemplate sqlSession, ProductCart p) {
		return sqlSession.insert("memberMapper.insertProductCart", p);
	}

	public ProductCart selectProductCart(SqlSessionTemplate sqlSession, ProductCart productCart) {
		return sqlSession.selectOne("memberMapper.selectProductCart", productCart);
	}

	public int updateProductCart(SqlSessionTemplate sqlSession, ProductCart productCart) {
		return sqlSession.update("memberMapper.updateProductCart", productCart);
	}

	public ArrayList<ProductCart> selectProductCartList(SqlSessionTemplate sqlSession, Member m) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectProductCartList", m);
	}

	public int deleteProductCart(SqlSessionTemplate sqlSession, List<ProductCart> p) {
		return sqlSession.delete("memberMapper.deleteProductCart", p);
	}

	public int deleteProductCart(SqlSessionTemplate sqlSession, int memberNo, List<Integer> pdOptNos) {
		
		 Map<String, Object> params = new HashMap<>();
		    params.put("memberNo", memberNo);
		    params.put("pdOptNos", pdOptNos);
		    
		return sqlSession.delete("memberMapper.deleteProductCart", params);
	}

	public int phoneCheck(SqlSessionTemplate sqlSession, String phone) {
		return sqlSession.selectOne("memberMapper.phoneCheck", phone);
	}

	public Member getMemberByNo(SqlSessionTemplate sqlSession, int boardWriterNo) {
		return sqlSession.selectOne("memberMapper.getMemberByNo", boardWriterNo);
	}
	
	// ======================================== 알림 관련 코드 ===================================

	public LikeDtoForNotify getLikeForNotify(SqlSessionTemplate sqlSession, int memberNo, int writingNo, int type) {
		Map<String, Integer> params = new HashMap<>();
		params.put("type", type);
		params.put("memberNo", memberNo);
		params.put("writingNo", writingNo);
		// 타입이 1이면 게시글 좋아요 반환, 타입이 2이면 레시피 좋아요 반환
		return sqlSession.selectOne("memberMapper.getLikeForNotify", params);
	}

	public QnaDtoForNotify getQnaDtoForNotify(SqlSessionTemplate sqlSession, int qnaNo, int qnaType) {
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("qnaNo", qnaNo);
		params.put("qnaType", qnaType);
		return sqlSession.selectOne("memberMapper.getQnaDtoForNotify", params);
	}

	public Member getQnaWriter(SqlSessionTemplate sqlSession, int refQnaNo) {
		return sqlSession.selectOne("memberMapper.getQnaWriter", refQnaNo);
	}

	public ReviewDtoForNotify getReviewDtoForNotify(SqlSessionTemplate sqlSession, int reviewNo, int type) {
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("reviewNo", reviewNo);
		params.put("type", type);
		
		return sqlSession.selectOne("memberMapper.getReviewDtoForNotify", params);
	}

}