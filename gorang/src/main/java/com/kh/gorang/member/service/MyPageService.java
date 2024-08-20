package com.kh.gorang.member.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.kh.gorang.board.model.vo.Board;
import com.kh.gorang.common.model.vo.PageInfo;
import com.kh.gorang.member.model.dto.MyPageReviewDTO;
import com.kh.gorang.member.model.dto.RefrigeratorDtoForNotify;
import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.member.model.vo.MyPageBoardCommentDTO;
import com.kh.gorang.member.model.vo.MyPageBoardDTO;
import com.kh.gorang.member.model.vo.MyPageLikeBoardDTO;
import com.kh.gorang.member.model.vo.MyPageLikeRecipeDTO;
import com.kh.gorang.member.model.vo.MyPageRecipeDTO;
import com.kh.gorang.member.model.vo.MyPageScrapBoardDTO;
import com.kh.gorang.member.model.vo.MyPageScrapProductDTO;
import com.kh.gorang.member.model.vo.MyPageScrapRecipeDTO;
import com.kh.gorang.member.model.vo.ProductQnaDTO;
import com.kh.gorang.member.model.vo.RecipeQnaDTO;
import com.kh.gorang.member.model.vo.RefrigeratorInsertDTO;
import com.kh.gorang.recipe.model.dto.RecipeListDto;
import com.kh.gorang.recipe.model.vo.Recipe;

public interface MyPageService {

	// 팔로잉 수 조회
	int getFollowingCount(int memberNo);

	// 팔로워 수 조회
	int getFollowerCount(int memberNo);

	// 총 스크랩 수 조회
	int getTotalScrapCount(int memberNo);

	// 총 좋아요 수 조회
	int getTotalLikeCount(int memberNo);

	// 조회수가 많은 순으로 정렬된 레시피
	ArrayList<Recipe> getMostViewRecipeList(int memberNo);

	// 조회수가 많은 순으로 정렬된 게시글
	ArrayList<Board> getMostViewBoardList(int memberNo);

	// 스크랩 내용물들 조회
	ArrayList<Object> getScrapList(int memberNo);

	// 좋아요 내용물들 조회
	ArrayList<Object> getLikeContentList(int memberNo);

	// 최신순으로 정렬된 레시피 조회
	ArrayList<MyPageRecipeDTO> getRecipeList(PageInfo pi, Map<String, Object> map);
	
	// 나의 레시피 개수 조회
	int getMyRecipeCount(int memberNo);

	// 레시피 삭제
	int removeRecipe(int recipeNo);

	// 게시글 개수 조회 
	int getBoardCount(Map<String,Object> map);

	// 게시글 조회 
	ArrayList<MyPageBoardDTO> getBoardList(PageInfo pi, Map<String, Object> map);

	// 게시글 삭제 
	int removeBoard(int boardNo);

	//댓글 개수 조회 
	int getCommentCount(int memberNo);

	//댓글 리스트 조회 
	ArrayList<MyPageBoardCommentDTO> getBoardCommentList(PageInfo commentPI, int memberNo);

	// 리뷰 개수 조회 
	int getReviewCount(int memberNo);

	// 리뷰 리스트 조회 
	ArrayList<MyPageReviewDTO> getReviewList(PageInfo reviewPI, int memberNo);

	// 스크랩한 레시피 조회 
	ArrayList<MyPageScrapRecipeDTO> getScrapRecipeList(int memberNo);

	// 스크랩 레시피 삭제 
	int deleteScrapRecipe(Map<String, Object> map);

	// 스크랩 게시글 조회 
	ArrayList<MyPageScrapBoardDTO> getScrapBoardList(int memberNo);

	// 스크랩 게시글 삭
	int deleteScrapBoard(Map<String, Object> map);

	// 스크랩 상품 조회 
	ArrayList<MyPageScrapProductDTO> getScrapProduct(int memberNo);
	
	// 스크랩 상품 삭제 
	int deleteScrapProduct(Map<String, Object> map);

	// 좋아요 레시피 조회
	ArrayList<MyPageLikeRecipeDTO> getLikeRecipeList(int memberNo);

	// 좋아요 레시피 삭제
	int deleteLikeRecipe(Map<String, Object> map);

	// 좋아요 게시글 조회
	ArrayList<MyPageLikeBoardDTO> getLikeBoardList(int memberNo);

	// 좋아요 게시글 삭제
	int deleteLikeBoard(Map<String, Object> map);

	// 회원 닉네임 체크
	int checkMemberNickname(Map<String, Object> map);

	// 회원 전화번호 체크
	int checkMemberPhone(Map<String, Object> map);

	// 회원 정보 업데이트
	Member updateMemberInfo(Member member);
	
	// 회원 탈퇴
	int deleteMember(int loginUserNo);

	// 상품 qna 개수 조회
	int getProductQnaCount(int memberNo);
	
	// 상품 qna List 조회
	ArrayList<ProductQnaDTO> getProductQnaList(int memberNo, PageInfo productQnaPi);
	
	// 레시피 qna 개수 조회
	int getRecipeQnaCount(int memberNo);
	
	// 레시피 qna 조회
	ArrayList<RecipeQnaDTO> getRecipeQnaList(int memberNo, PageInfo recipeQnaPi);
	
	// 냉장고 식재료 저장
	int insertRefrigerator(int memberNo, List<RefrigeratorInsertDTO> refriIngres);

	List<RefrigeratorInsertDTO> selectListRefrigeratorsByMemberNo(int memberNo, PageInfo refriPi);
	
	// 냉장고 식재료 갯수 조회
	int selectRefriCount(int userNo);
	
	// 냉장고 식재료를 바탕으로 레시피 조회
	List<RecipeListDto> selectRecipeListByRefri(List<String> ingresArray);
	
	// 냉장고 식재료 삭제
	int deleteRefrigerator(int memberNo, String refriNums);
	
	// 스케쥴러 통해 소비기한 임박한 식재료 알림 전송
	void checkExpiringRefriIngre();
	
	// 소비기한 3일 이내의 냉장고 식재료들을 찾는 메소드
	List<RefrigeratorDtoForNotify> findExpiringRefriIngre(LocalDate alertDate);
	
	// 레시피 리스트 조회
	ArrayList<RecipeListDto> selectRecipeListByRecipeNo(String recipeNums);

	// 레시피 임시저장 개수
	int selectSaveCount(int memberNo);

	int deleteQna(List<Integer> checkedQnaNoList);
	


	

}
