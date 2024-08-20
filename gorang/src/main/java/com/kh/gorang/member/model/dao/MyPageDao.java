package com.kh.gorang.member.model.dao;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.gorang.board.model.vo.Board;
import com.kh.gorang.common.model.vo.PageInfo;
import com.kh.gorang.member.model.dto.MyPageReviewDTO;
import com.kh.gorang.member.model.dto.RefrigeratorDtoForNotify;
import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.member.model.vo.MyPageBoardCommentDTO;
import com.kh.gorang.member.model.vo.MyPageLikeBoardDTO;
import com.kh.gorang.member.model.vo.MyPageLikeRecipeDTO;
import com.kh.gorang.member.model.vo.MyPageScrapBoardDTO;
import com.kh.gorang.member.model.vo.MyPageScrapProductDTO;
import com.kh.gorang.member.model.vo.MyPageScrapRecipeDTO;
import com.kh.gorang.member.model.vo.ProductQnaDTO;
import com.kh.gorang.member.model.vo.RecipeQnaDTO;
import com.kh.gorang.member.model.vo.RefrigeratorInsertDTO;
import com.kh.gorang.member.model.vo.Review;
import com.kh.gorang.recipe.model.dto.RecipeListDto;
import com.kh.gorang.recipe.model.vo.Recipe;
import com.kh.gorang.shopping.model.vo.Product;


@Repository
public class MyPageDao {

	// 팔로잉 수 조회
	public int getFollowingCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("myPageMapper.selectFollowingCount", memberNo);
	}

	// 팔로워 수 조회
	public int getFollowerCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("myPageMapper.selectFollowerCount", memberNo);
	}

	// 게시글 스크랩 수 조회
	public int getBoardScrapCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("myPageMapper.selectBoardScrapCount", memberNo);
	}

	// 상품 스크랩 수 조회
	public int getProductScrapCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("myPageMapper.selectProductScrapCount", memberNo);
	}

	// 레시피 스크랩 수 조회
	public int getRecipeScrapCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("myPageMapper.selectRecipeScrapCount", memberNo);
		
	}

	// 게시글 좋아요 수 조회
	public int getTotalBoardLikeCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("myPageMapper.selectTotalBoardLikeCount", memberNo);
	}

	// 레시피 좋아요 수 조회
	public int getTotalRecipeLikeCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("myPageMapper.selectTotalRecipeLikeCount", memberNo);
	}

	// 조회수가 많은 순으로 정렬된 레시피 리스트 조회
	public ArrayList<Recipe> getMostViewRecipeList(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("myPageMapper.selectMostViewRecipeList", memberNo);
	}

	// 조회수가 많은 순으로 정렬된 게시글 리스트 조회
	public ArrayList<Board> getMostViewBoardList(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("myPageMapper.selectMostViewBoardList", memberNo);
	}

	// 스크랩한 레시피들 조회수가 많은 순으로 정렬된 리스트 조회
	public ArrayList<Recipe> getMostViewScrapedRecipeList(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("myPageMapper.selectMostViewScrapedRecipeList",memberNo);
	}

	// 스크랩한 게시글들 조회수가 많은 순으로 정렬된 리스트로 조회
	public ArrayList<Board> getMostViewScrapedBoardList(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("myPageMapper.selectMostViewScrapedBoardList", memberNo);
	}

	// 스크랩한 상품들 조회수가 많은 순으로 정렬된 리스트로 조회
	public ArrayList<Product> getMostViewScrapedProductList(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("myPageMapper.selectMostViewScrapedProductList", memberNo);
	}

	// 좋아요 누른 레시피 조회
	public ArrayList<Recipe> getLikedRecipeList(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("myPageMapper.selectLikedRecipeList", memberNo);
	}

	// 좋아요 누른 게시글 조회
	public ArrayList<Board> getLikedBoardList(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("myPageMapper.selectLikedBoardList", memberNo);
	}

	// 레시피 조회
	public ArrayList<Recipe> getRecipeList(SqlSessionTemplate sqlSession, PageInfo pi, Map<String, Object> map) {
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("myPageMapper.selectRecipeList", map, rowBounds);
	}

	// 나의 레시피 개수 조회
	public int getMyRecipeCount(SqlSessionTemplate sqlSession, int memberNo) {

		return sqlSession.selectOne("myPageMapper.selectMyRecipeCount", memberNo);
	}

	// 레시피 리뷰 개수 조회
	public int getRecipeReviewCount(SqlSessionTemplate sqlSession, int recipeNo) {
		return sqlSession.selectOne("myPageMapper.selectRecipeReviewCount", recipeNo);
	}

	// 레시피 좋아요 개수 조회
	public int getRecipeLikeCount(SqlSessionTemplate sqlSession, int recipeNo) {
		return sqlSession.selectOne("myPageMapper.selectRecipeLikeCount", recipeNo);
	}

	// 레시피 삭제 
	public int removeRecipe(SqlSessionTemplate sqlSession, int recipeNo) {
		return sqlSession.update("myPageMapper.removeRecipe", recipeNo);
	}

	// 게시글 개수 조회 
	public int getBoardCount(SqlSessionTemplate sqlSession, Map<String,Object> map) {
		return sqlSession.selectOne("myPageMapper.selectBoardCount", map);
	}

	// 게시글 조회 
	public ArrayList<Board> getBoardList(SqlSessionTemplate sqlSession, PageInfo pi, Map<String, Object> map) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("myPageMapper.selectRecentBoardList", map, rowBounds);
	}

	// 게시글의 달린 코멘트 개수 조회 
	public int getBoardCommentCount(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.selectOne("myPageMapper.selectBoardCommentCount", boardNo);
	}

	// 게시글의 좋아요 개수 조회 
	public int getBoardLikeCount(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.selectOne("myPageMapper.selectBoardLikeCount", boardNo);
		
	}

	// 게시글 삭제 
	public int removeBoard(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.update("myPageMapper.removeBoard", boardNo);
	}

	// 댓글 개수 조회 
	public int getCommentCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("myPageMapper.selectCommentCount", memberNo);
	}

	// 댓글 조회 
	public ArrayList<MyPageBoardCommentDTO> getBoardCommentList(SqlSessionTemplate sqlSession, PageInfo commentPI,
			int memberNo) {
		int offset = (commentPI.getCurrentPage() - 1) * commentPI.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, commentPI.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("myPageMapper.selectCommentList", memberNo, rowBounds);
	}

	// 리뷰 개수 조회 
	public int getReviewCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("myPageMapper.selectReviewCount", memberNo);
	}

	// 리뷰 조회 
	public ArrayList<MyPageReviewDTO> getReviewList(SqlSessionTemplate sqlSession, PageInfo reviewPI, int memberNo) {
		
		int offset = (reviewPI.getCurrentPage() - 1) * reviewPI.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, reviewPI.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("myPageMapper.selectReviewList", memberNo, rowBounds);
	}

	// 스크랩한 레시피 조회 
	public ArrayList<MyPageScrapRecipeDTO> getScrapRecipeList(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("myPageMapper.selectScrapRecipeList", memberNo);
	}

	// 스크랩한 레시피 삭제 
	public int deleteScrapRecipe(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.update("myPageMapper.deleteScrapRecipe", map);
	}

	// 스크랩한 게시글 조회 
	public ArrayList<MyPageScrapBoardDTO> getScrapBoardList(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("myPageMapper.selectScrapBoard", memberNo);
	}

	// 스크랩 게시글 삭제 
	public int deleteScrapBoard(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.delete("myPageMapper.deleteScrapBoard", map);
	}
	
	// 스크랩 상품 조회
	public ArrayList<MyPageScrapProductDTO> getScrapProduct(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("myPageMapper.selectScrapProduct", memberNo);
	}
	
	// 스크랩 상품 삭제
	public int deleteScrapProduct(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.delete("myPageMapper.deleteScrapProduct", map);
	}

	// 좋아요 레시피 조회
	public ArrayList<MyPageLikeRecipeDTO> getLikeRecipeList(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("myPageMapper.selectLikeRecipe", memberNo);
	}

	// 좋아요 레시피 삭제
	public int deleteLikeRecipe(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.update("myPageMapper.deleteLikeRecipe", map);
	}

	// 좋아요 게시글 조회
	public ArrayList<MyPageLikeBoardDTO> getLikeBoardList(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("myPageMapper.selectLikeBoard",memberNo);
	}

	// 좋아요 게시글 삭제
	public int deleteLikeBoard(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.update("myPageMapper.deleteLikeBoard", map);
	}

	// 회원 닉네임 중복체크
	public int checkMemberNickname(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("myPageMapper.selectMemberNicknameCount",map);
	}

	// 회원 전화번호 중복체크
	public int checkMemberPhone(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("myPageMapper.selectMemberPhoneCount", map);
	}

	// 회원 정보 업데이트
	public int updateMemberInfo(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.update("myPageMapper.updateMemberInfo", member);
	}

	// 회원 조회
	public Member selectMember(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("myPageMapper.selectMember",memberNo);
	}

	// 회원 탈퇴
	public int deleteMember(SqlSessionTemplate sqlSession, int loginUserNo) {
		return sqlSession.update("myPageMapper.deleteMember", loginUserNo);
	}

	// 상품 qna 개수 조회
	public int getProductQnaCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("myPageMapper.selectProductQnaCount", memberNo);
	}
	
	// 상품 qna 조회
	public ArrayList<ProductQnaDTO> getProductQnaList(SqlSessionTemplate sqlSession, int memberNo, PageInfo productQnaPi) {
		
		int offset = (productQnaPi.getCurrentPage() - 1) * productQnaPi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, productQnaPi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("myPageMapper.selectProductQnaList", memberNo, rowBounds);
	}

	// 레시피 qna 개수 조회
	public int getRecipeQnaCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("myPageMapper.selectRecipeQnaCount", memberNo);	
	}

	// 레시피 qna 조회
	public ArrayList<RecipeQnaDTO> getRecipeQnaList(SqlSessionTemplate sqlSession, int memberNo, PageInfo recipeQnaPi) {
		
		int offset = (recipeQnaPi.getCurrentPage() - 1) * recipeQnaPi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, recipeQnaPi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("myPageMapper.selectRecipeQnaList", memberNo, rowBounds);
	}

	public int insertRefrigerator(SqlSessionTemplate sqlSession, RefrigeratorInsertDTO refriIngre) {
		return sqlSession.insert("myPageMapper.insertRefrigerator", refriIngre);
	}

	public List<RefrigeratorInsertDTO> selectListRefrigeratorsByMemberNo(SqlSessionTemplate sqlSession, int memberNo, PageInfo refriPi) {
		int limit = refriPi.getBoardLimit();
		int offset = (refriPi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("myPageMapper.selectListRefrigeratorsByMemberNo", memberNo, rowBounds);
	}

	public int selectRefriCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("myPageMapper.selectRefriCount", memberNo);
	}
	
	//식재료로 레시피 조회
	public List<RecipeListDto> selectRecipeListByRefri(SqlSessionTemplate sqlSession, List<String> ingresArray) {
		return sqlSession.selectList("myPageMapper.selectRecipeListByRefri", ingresArray);
	}

	public int deleteRefrigerator(SqlSessionTemplate sqlSession, ArrayList<RefrigeratorInsertDTO> refriListforDelete) {
		return sqlSession.delete("myPageMapper.deleteRefrigerator", refriListforDelete);
	}

	public ArrayList<RecipeListDto> selectRecipeListByRecipeNo(SqlSessionTemplate sqlSession, Integer[] recipeNoArray) {
		return (ArrayList)sqlSession.selectList("myPageMapper.selectRecipeListByRecipeNo", recipeNoArray);
	}
	


	public int decreaseScrapProduct(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.update("myPageMapper.decreaseScrapProduct",map);
	}

	public int deleteQna(SqlSessionTemplate sqlSession, Integer qnaNo) {
		return sqlSession.delete("myPageMapper.deleteQna", qnaNo);
	}

	public List<RefrigeratorDtoForNotify> findExpiringRefriIngre(SqlSessionTemplate sqlSession, LocalDate alertDate) {
		return sqlSession.selectList("myPageMapper.findExpiringRefriIngre", alertDate);
	}

}
