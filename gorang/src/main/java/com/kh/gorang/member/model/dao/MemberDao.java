package com.kh.gorang.member.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.member.model.vo.ProductCart;

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
}