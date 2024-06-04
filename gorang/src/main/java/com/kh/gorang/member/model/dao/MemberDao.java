package com.kh.gorang.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.gorang.member.model.vo.Member;

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
	
}