package com.kh.gorang.member.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.gorang.board.model.dao.BoardDao;
import com.kh.gorang.board.model.vo.Board;
import com.kh.gorang.common.model.vo.PageInfo;
import com.kh.gorang.member.model.dao.MyPageDao;
import com.kh.gorang.member.model.dto.MyPageReviewDTO;
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
import com.kh.gorang.shopping.model.vo.Product;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MyPageServiceImpl implements MyPageService{
	
	@Autowired
    private MyPageDao myPageDao;
	
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 팔로잉 수 구하기
	@Override
	public int getFollowingCount(int memberNo) {
		return myPageDao.getFollowingCount(sqlSession, memberNo);
	}

	// 팔로워 수 조회
	@Override
	public int getFollowerCount(int memberNo) {
		return myPageDao.getFollowerCount(sqlSession, memberNo);
	}

	// 총 스크랩 수 조회
	@Override
	public int getTotalScrapCount(int memberNo) {

		// 게시글 스크랩 수 구하기
		int boardScrapCount = myPageDao.getBoardScrapCount(sqlSession, memberNo);
		
		// 상품 스크랩 수 구하기
		int productScrapCount = myPageDao.getProductScrapCount(sqlSession, memberNo);
		
		// 레시피 스크랩 수 구하기
		int recipeScrapCount = myPageDao.getRecipeScrapCount(sqlSession, memberNo);
		
				
		return boardScrapCount + productScrapCount + recipeScrapCount;
	}

	// 총 좋아요 수 조회
	@Override
	public int getTotalLikeCount(int memberNo) {
		
		// 게시글 좋아요 수 조회
		int boardLikeCount = myPageDao.getTotalBoardLikeCount(sqlSession, memberNo);
		
		// 레시피 좋아요 수 조회
		int recipeLikeCount = myPageDao.getTotalRecipeLikeCount(sqlSession, memberNo);
		
		return boardLikeCount + recipeLikeCount;
	}

	// 조회수가 많은 순으로 정렬된 레시피 조회 3개
	@Override
	public ArrayList<Recipe> getMostViewRecipeList(int memberNo) {
		
		return myPageDao.getMostViewRecipeList(sqlSession, memberNo);
	}

	// 조회수가 많은 순으로 정렬된 게시글 조회
	@Override
	public ArrayList<Board> getMostViewBoardList(int memberNo) {
			
		return myPageDao.getMostViewBoardList(sqlSession, memberNo);
	}

	// 스크랩한 내용물들 조회
	@Override
	public ArrayList<Object> getScrapList(int memberNo) {

		ArrayList<Object> allScrapList = new ArrayList<Object>();
		
		ArrayList<Recipe> scrapRecipeList = myPageDao.getMostViewScrapedRecipeList(sqlSession, memberNo);
		for(Recipe r : scrapRecipeList) {
			allScrapList.add(r);
		}
		
		ArrayList<Board> scrapBoardList = myPageDao.getMostViewScrapedBoardList(sqlSession, memberNo);
		for(Board b : scrapBoardList) {
			allScrapList.add(b);
		}
		
		ArrayList<Product> scrapProductList = myPageDao.getMostViewScrapedProductList(sqlSession, memberNo);
		for(Product p : scrapProductList) {
			allScrapList.add(p);
		}
		
		Collections.shuffle(allScrapList);
		
		return allScrapList;
		
	}

	// 좋아요 누른 내용물들 조회
	@Override
	public ArrayList<Object> getLikeContentList(int memberNo) {
		
		ArrayList<Object> allLikeList = new ArrayList<Object>();
		
		ArrayList<Recipe> likeRecipeList = myPageDao.getLikedRecipeList(sqlSession, memberNo);
		for(Recipe r : likeRecipeList) {
			allLikeList.add(r);
		}
		
		ArrayList<Board> likeBoardList = myPageDao.getLikedBoardList(sqlSession, memberNo);
		for(Board b : likeBoardList) {
			allLikeList.add(b);
		}
		
		Collections.shuffle(allLikeList);	
		
		return allLikeList;
		
	}

	// 나의 레시피 개수 조회
	@Override
	public int getMyRecipeCount(int memberNo) {
		return myPageDao.getMyRecipeCount(sqlSession, memberNo);
	}

	//레시피 조회
	@Override
	public ArrayList<MyPageRecipeDTO> getRecipeList(PageInfo pi, Map<String, Object> map) {
		
		ArrayList<MyPageRecipeDTO> result = new ArrayList<MyPageRecipeDTO>();
		
		ArrayList<Recipe> recipeList = myPageDao.getRecipeList(sqlSession, pi ,map);
		
		for(Recipe recipe : recipeList) {
			int recipeReviewCount = myPageDao.getRecipeReviewCount(sqlSession, recipe.getRecipeNo());
			int recipeLikeCount = myPageDao.getRecipeLikeCount(sqlSession, recipe.getRecipeNo());
			MyPageRecipeDTO myPageRecipeDTO = new MyPageRecipeDTO(recipe, recipeReviewCount, recipeLikeCount);
			result.add(myPageRecipeDTO);
		}
		
		return result;
	}

	// 레시피 삭제 
	@Override
	public int removeRecipe(int recipeNo) {
		return myPageDao.removeRecipe(sqlSession, recipeNo);
	}

	// 나의 게시글 개수 조회 
	@Override
	public int getBoardCount(Map<String,Object> map) {
		return myPageDao.getBoardCount(sqlSession, map);
	}

	// 게시글 조회 
	@Override
	public ArrayList<MyPageBoardDTO> getBoardList(PageInfo pi, Map<String, Object> map) {
		
		ArrayList<MyPageBoardDTO> result = new ArrayList<>();
		
		ArrayList<Board> boardList = myPageDao.getBoardList(sqlSession, pi, map);
		
		for(Board board : boardList) {
			int boardCommentCount = myPageDao.getBoardCommentCount(sqlSession, board.getBoardNo());
			int boardLikeCount = myPageDao.getBoardLikeCount(sqlSession, board.getBoardNo());
			MyPageBoardDTO boardInfo = new MyPageBoardDTO(board, boardCommentCount, boardLikeCount);
			result.add(boardInfo);
		}
		
		return result;
	}

	//게시글 삭제
	@Override
	public int removeBoard(int boardNo) {
		return myPageDao.removeBoard(sqlSession, boardNo);
	}

	// 댓글 개수 조회 
	@Override
	public int getCommentCount(int memberNo) {
		return myPageDao.getCommentCount(sqlSession, memberNo);
	}

	// 댓글 조회 
	@Override
	public ArrayList<MyPageBoardCommentDTO> getBoardCommentList(PageInfo commentPI, int memberNo) {
		return myPageDao.getBoardCommentList(sqlSession, commentPI, memberNo);
	}

	// 리뷰개수조회 
	@Override
	public int getReviewCount(int memberNo) {
		return myPageDao.getReviewCount(sqlSession, memberNo);
	}

	//리뷰 리스트 조회 
	@Override
	public ArrayList<MyPageReviewDTO> getReviewList(PageInfo reviewPI, int memberNo) {
		return myPageDao.getReviewList(sqlSession, reviewPI, memberNo);
	}

	//스크랩 리스트 조회 
	@Override
	public ArrayList<MyPageScrapRecipeDTO> getScrapRecipeList(int memberNo) {
		return myPageDao.getScrapRecipeList(sqlSession, memberNo);
	}

	// 스크랩 레시피 삭제 
	@Override
	public int deleteScrapRecipe(Map<String, Object> map) {
		return myPageDao.deleteScrapRecipe(sqlSession, map);
	}

	// 스크랩 게시글 조회 
	@Override
	public ArrayList<MyPageScrapBoardDTO> getScrapBoardList(int memberNo) {
		return myPageDao.getScrapBoardList(sqlSession, memberNo);
	}

	// 스크랩 게시글 삭제 
	@Override
	public int deleteScrapBoard(Map<String, Object> map) {
		return myPageDao.deleteScrapBoard(sqlSession, map);
	}

	// 스크랩 상품 조회
	@Override
	public ArrayList<MyPageScrapProductDTO> getScrapProduct(int memberNo) {
		return myPageDao.getScrapProduct(sqlSession, memberNo);
	}
	
	// 스크랩 상품 삭제
	@Override
	public int deleteScrapProduct(Map<String, Object> map) {
		
		int deleteScrapProductResult =  myPageDao.deleteScrapProduct(sqlSession, map);
		int decreaseScrapProduct = 0;
		
		if (deleteScrapProductResult > 0) {
			decreaseScrapProduct = myPageDao.decreaseScrapProduct(sqlSession, map);
			
			if(decreaseScrapProduct > 0 ) {
				return deleteScrapProductResult * decreaseScrapProduct;
			}
		}
		
		return 0;
	}

	// 좋아요 레시피 조회
	@Override
	public ArrayList<MyPageLikeRecipeDTO> getLikeRecipeList(int memberNo) {
		return myPageDao.getLikeRecipeList(sqlSession, memberNo);
	}

	// 좋아요 레시피 삭제
	@Override
	public int deleteLikeRecipe(Map<String, Object> map) {
		return myPageDao.deleteLikeRecipe(sqlSession, map);
	}

	// 좋아요 게시글 조회
	@Override
	public ArrayList<MyPageLikeBoardDTO> getLikeBoardList(int memberNo) {
		return myPageDao.getLikeBoardList(sqlSession, memberNo);
	}

	// 좋아요 게시글 삭제
	@Override
	public int deleteLikeBoard(Map<String, Object> map) {
		return myPageDao.deleteLikeBoard(sqlSession, map);
	}

	// 회원 닉네임 중복체크
	@Override
	public int checkMemberNickname(Map<String, Object> map) {
		return myPageDao.checkMemberNickname(sqlSession, map);
	}

	// 회원 전화번호 중복체크
	@Override
	public int checkMemberPhone(Map<String, Object> map) {
		return myPageDao.checkMemberPhone(sqlSession, map);
	}

	// 회원 정보 업데이트
	@Override
	public Member updateMemberInfo(Member member) {
		
		int result = myPageDao.updateMemberInfo(sqlSession, member);
		
		if(result > 0) {
			return myPageDao.selectMember(sqlSession, member.getMemberNo());
		}
		
		return null;
	}

	// 회원 탈퇴
	@Override
	public int deleteMember(int loginUserNo) {
		return myPageDao.deleteMember(sqlSession, loginUserNo);
	}
	
	// 상품 qna 개수 조회
	@Override
	public int getProductQnaCount(int memberNo) {
		return myPageDao.getProductQnaCount(sqlSession, memberNo);
	}
	
	// 상품qna 조회
	@Override
	public ArrayList<ProductQnaDTO> getProductQnaList(int memberNo, PageInfo productQnaPi) {	
		
		return myPageDao.getProductQnaList(sqlSession, memberNo, productQnaPi);
	}
	
	// 레시피 qna 개수 조회
	@Override
	public int getRecipeQnaCount(int memberNo) {
		return myPageDao.getRecipeQnaCount(sqlSession, memberNo);
	}

	// 레시피 qna 조회
	@Override
	public ArrayList<RecipeQnaDTO> getRecipeQnaList(int memberNo, PageInfo recipeQnaPi) {
		return myPageDao.getRecipeQnaList(sqlSession,memberNo, recipeQnaPi);
	}

	// 냉장고 식재료 저장
	@Transactional(rollbackFor = {Exception.class})
	@Override
	 public int insertRefrigerator(int memberNo, List<RefrigeratorInsertDTO> refriIngres) {
        int result = 1;
        
        for (RefrigeratorInsertDTO refriIngre : refriIngres) {
            refriIngre.setRefMemberNo(memberNo);
            result *= myPageDao.insertRefrigerator(sqlSession, refriIngre);
        }
        return result;
    }
	
	// 냉장고 식재료 리스트 조회
	@Transactional(readOnly = true)
	@Override
	public List<RefrigeratorInsertDTO> selectListRefrigeratorsByMemberNo(int memberNo, PageInfo refriPi) {
		return myPageDao.selectListRefrigeratorsByMemberNo(sqlSession, memberNo, refriPi);
	}
	
	// 냉장고 식재료 갯수 조회
	@Transactional(readOnly = true)
	@Override
	public int selectRefriCount(int memberNo) {
		return myPageDao.selectRefriCount(sqlSession, memberNo);
	}
	
	// 냉장고 식재료로 레시피 조회
	@Transactional(readOnly = true)
	@Override
	public List<RecipeListDto> selectRecipeListByRefri(List<String> ingresArray) {
				
		return myPageDao.selectRecipeListByRefri(sqlSession, ingresArray);
	}
	
	// 냉장고 식재료 삭제
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int deleteRefrigerator(int memberNo, String refriNums) {
		// 정규식 사용해서 대괄호 제거 후 쉼표 기준으로 숫자 분리하기
		String[] refriNumsArray = refriNums.replaceAll("\\[|\\]", "").split(",");	
		
		ArrayList<RefrigeratorInsertDTO> refriListforDelete = new ArrayList<>();
		
		for(String refriNum : refriNumsArray) {
			RefrigeratorInsertDTO refri = new RefrigeratorInsertDTO();
			refri.setRefNo(Integer.parseInt(refriNum));
			refri.setRefMemberNo(memberNo);
			refriListforDelete.add(refri);
		}
		
		return myPageDao.deleteRefrigerator(sqlSession, refriListforDelete);
	}
	
	@Transactional(readOnly = true)
	@Override
	public ArrayList<RecipeListDto> selectRecipeListByRecipeNo(String recipeNums) {
		
		// 숫자 하나만 들어오는 경우 처리
		 String[] recipeNoStrArray;
		    if (recipeNums.matches("^\\d+$")) { // 숫자 하나만 들어오는 경우
		        recipeNoStrArray = new String[] { recipeNums };
		    } else {
		        recipeNoStrArray = recipeNums.replaceAll("\\[|\\]", "").split(",");
		    }

	    Integer[] recipeNoArray = new Integer[recipeNoStrArray.length];
	    for (int i = 0; i < recipeNoStrArray.length; i++) {
	        recipeNoArray[i] = Integer.parseInt(recipeNoStrArray[i].trim());
	    }
		
		return myPageDao.selectRecipeListByRecipeNo(sqlSession, recipeNoArray);
	}

	@Override
	public int selectSaveCount(int memberNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Transactional
	@Override
	public int deleteQna(List<Integer> checkedQnaNoList) {
		
		int result = 0;
		
		for(Integer qnaNo : checkedQnaNoList) {
			result = myPageDao.deleteQna(sqlSession,qnaNo);
		}
		
		return result;
	}


	
}
