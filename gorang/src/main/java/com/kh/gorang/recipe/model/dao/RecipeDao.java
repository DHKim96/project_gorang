package com.kh.gorang.recipe.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.gorang.common.model.vo.Media;
import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.member.model.vo.QnA;
import com.kh.gorang.member.model.vo.Review;
import com.kh.gorang.recipe.model.vo.CookOrder;
import com.kh.gorang.recipe.model.vo.CookTip;
import com.kh.gorang.recipe.model.vo.Division;
import com.kh.gorang.recipe.model.vo.IngredientsInfo;
import com.kh.gorang.recipe.model.vo.Recipe;
import com.kh.gorang.recipe.model.vo.RecipeInsertDTO;
import com.kh.gorang.shopping.model.vo.Product;

@Repository
public class RecipeDao {
	
	//레시피 추가	
	public Recipe insertRecipe(SqlSessionTemplate sqlSession, Recipe rcp) { 
		return (Recipe)sqlSession.selectOne("recipeMapper.insertRecipe",rcp);
	}
	
	//재료 정보 분류 추가 및 분류 번호 찾기
	public Division insertDivision(SqlSessionTemplate sqlSession, Division div,int rcpNo) {
		div.setRecipeNo(rcpNo);
		return (Division)sqlSession.selectOne("recipeMapper.insertDivision",div);
	}
	//재료 정보 추가
	public int insertIngredientsInfo(SqlSessionTemplate sqlSession, IngredientsInfo ingre, int divNo) {
		ingre.setDivNo(divNo);
		System.out.println("Dao null확인:"+ingre+",  num:" + divNo);
		return sqlSession.insert("recipeMapper.insertIngredientsInfo",ingre);
	}
	//레시피 순서 추가 및 레시피번호 찾기
	public CookOrder insertCookOrder(SqlSessionTemplate sqlSession, CookOrder cookOrder, int rcpNo) {
		cookOrder.setRecipeNo(rcpNo);
		return (CookOrder)sqlSession.selectOne("recipeMapper.insertCookOrder",cookOrder);
	}
	//팁 추가
	public int insertCookTip(SqlSessionTemplate sqlSession, CookTip cTip, int cookOrderNum) {
		cTip.setCookOrdNo(cookOrderNum);
		return sqlSession.insert("recipeMapper.insertCookTip",cTip);
	}
	
	//완성 사진들 추가
	public int insertRecipeMedia(SqlSessionTemplate sqlSession,Media md, int rcpNo) {
		md.setRecipeNo(rcpNo);
		return sqlSession.insert("mediaMapper.insertRecipeMedia",md);
	}
	
	//레시피 찾기
	public Recipe selectRecipe(SqlSessionTemplate sqlSession, int rcpNo) {
		return sqlSession.selectOne("recipeMapper.selectRecipe",rcpNo);
	}
	
	//레시피 분류 찾기
	public List<Division> selectDivList(SqlSessionTemplate sqlSession, int rcpNo) {	
		return sqlSession.selectList("recipeMapper.selectDivList", rcpNo);
	}
	//레시피 재료 속성(분류) 찾기
	public List<IngredientsInfo> selectIngredientsInfoList(SqlSessionTemplate sqlSession, int divNo) {
		return sqlSession.selectList("recipeMapper.selectIngredientsInfoList", divNo);
	}

	
	//레시피 조리순서 찾기
	public List<CookOrder> selectCookOrderList(SqlSessionTemplate sqlSession, int rcpNo) {
		return sqlSession.selectList("recipeMapper.selectCookOrderList", rcpNo);
	}
	
	
	//레시피 완성사진 찾기
	public List<Media> selectCompleteFoodPhoto(SqlSessionTemplate sqlSession, int rcpNo) {
		return sqlSession.selectList("mediaMapper.selectCompleteFoodPhoto", rcpNo);
	}
	
	//레시피 팁 찾기
	public List<CookTip> selectCookTipList(SqlSessionTemplate sqlSession, int cookOrdNo) {
		System.out.println("cookOrdNo:"+cookOrdNo);
		return sqlSession.selectList("recipeMapper.selectCookTipList", cookOrdNo);
	}	
	
	
	


	
	
	
	
	//분류 길이(개수)
	public int selectfindDivLen(SqlSessionTemplate sqlSession, int recipeNo) {
		return sqlSession.selectOne("recipeMapper.selectfindDivLen",recipeNo);
	}
	//재료 길이(개수)
	public int selectfindIngreLen(SqlSessionTemplate sqlSession,int divNo) {
		return sqlSession.selectOne("recipeMapper.selectfindIngreLen",divNo);
	}

	//조리순서 길이
	public int selectfindCoLen(SqlSessionTemplate sqlSession, int recipeNo) {
		return sqlSession.selectOne("recipeMapper.selectfindCoLen",recipeNo);
	}
	//팁 길이
	public int selectfindCtLen(SqlSessionTemplate sqlSession, CookOrder co) {
		return sqlSession.selectOne("recipeMapper.selectfindCtLen",co);
	}
	//요리 완성사진 길이
	public int selectfindmdLen(SqlSessionTemplate sqlSession, int recipeNo) {
		return sqlSession.selectOne("mediaMapper.selectfindmdLen",recipeNo);
	}
	
	//Ingre삭제
	public int deleteIngre(SqlSessionTemplate sqlSession, IngredientsInfo ingredientsInfo) {	
		System.out.println("Dao updateDivision null확인:"+ingredientsInfo);
		return sqlSession.update("recipeMapper.deleteIngre",ingredientsInfo );
	}
	//Division삭제
	public int deleteDivision(SqlSessionTemplate sqlSession, Division division) {
		System.out.println("Dao updateDivision null확인:"+division);
		return sqlSession.update("recipeMapper.deleteDivision",division );
	}
	//CookTip삭제
	public int deleteCookTip(SqlSessionTemplate sqlSession, CookTip cookTip) {
		System.out.println("Dao updateDivision null확인:"+cookTip);
		return sqlSession.update("recipeMapper.deleteCookTip",cookTip );
	}
	//CookOrder삭제
	public int deleteCookOrder(SqlSessionTemplate sqlSession, CookOrder cookOrder) {
		System.out.println("Dao updateDivision null확인:"+cookOrder);
		return sqlSession.update("recipeMapper.deleteCookOrder",cookOrder );
		
	}
	//레시피 완성 사진 삭제
	public int deleteCompletePhoto(SqlSessionTemplate sqlSession, Media media) {	
		System.out.println("Dao updateDivision null확인:"+media);
		return sqlSession.delete("mediaMapper.deleteCompletePhoto",media );
	}
	//레시피 삭제
	public int deleteRecipe(SqlSessionTemplate sqlSession, int rcpNo) {
		return sqlSession.delete("recipeMapper.deleteRecipe",rcpNo );
		
	}

	
	
	//레시피 수정
	public int updateRecipe(SqlSessionTemplate sqlSession, Recipe rcp) {
		return sqlSession.update("recipeMapper.updateRecipe",rcp);
	}
	//레시피 분류 수정
	public int updateDivision(SqlSessionTemplate sqlSession, Division division) {
		System.out.println("Dao updateDivision null확인:"+division);
		return sqlSession.update("recipeMapper.updateDivision",division);
	}
	//레시피 재료 수정
	public int updateIngredients(SqlSessionTemplate sqlSession, IngredientsInfo ingre) {
		System.out.println("Dao updateDivision null확인:"+ingre);
		return sqlSession.update("recipeMapper.updateIngredients",ingre);
		
	}
	//레시피 조리 순서 수정
	public int updateCookOrder(SqlSessionTemplate sqlSession, CookOrder co) {
		System.out.println("Dao updateDivision null확인:"+co);
		return sqlSession.update("recipeMapper.updateCookOrder",co);
		
	}
	//레시피 팁 수정
	public int updateCooktip(SqlSessionTemplate sqlSession, CookTip ct) {
		System.out.println("Dao updateDivision null확인:"+ct);
		return sqlSession.update("recipeMapper.updateCooktip", ct);
	}

	//레시피 완성사진 수정
	public int updateRecipeMedia(SqlSessionTemplate sqlSession, Media md) {
		System.out.println("Dao updateDivision null확인:"+md);
		return sqlSession.update("mediaMapper.updateRecipeMedia", md);
	}

	public Member selectRecipeMember(SqlSessionTemplate sqlSession, int recipeNo) {
	
		return sqlSession.selectOne("recipeMapper.selectRecipeMember",recipeNo);
	}
	
	
	//레시피 후기 작성
	public int insertReview(SqlSessionTemplate sqlSession, Review review) {
		return sqlSession.insert("recipeMapper.insertReview",review);
	}

	public List<Review> selectRecipeReviewList(SqlSessionTemplate sqlSession, int recipeNo) {
		return sqlSession.selectList("recipeMapper.selectRecipeReviewList",recipeNo);
	}

	public List<QnA> selectRecipeQnaList(SqlSessionTemplate sqlSession, int recipeNo) {
		return sqlSession.selectList("recipeMapper.selectRecipeQnaList",recipeNo);
	}

	public int insertQnA(SqlSessionTemplate sqlSession, QnA qna) {
		return sqlSession.insert("recipeMapper.insertQnA",qna);	

	
	}

	public int selectRecipeReviewCount(SqlSessionTemplate sqlSession, int recipeNo) {
		return sqlSession.selectOne("recipeMapper.selectRecipeReviewCount",recipeNo);
	}

	public int selectRecipeQnaCount(SqlSessionTemplate sqlSession, int recipeNo) {
		return sqlSession.selectOne("recipeMapper.selectRecipeQnaCount",recipeNo);
	}

	public Product selectProductList(SqlSessionTemplate sqlSession, String ingreName) {
		return sqlSession.selectOne("recipeMapper.selectProductList",ingreName);
	}
	
	public Product selectProductListRandom(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("recipeMapper.selectProductListRandom");
	}

	public int addRecipeView(SqlSessionTemplate sqlSession, int recipeNo) {
		return sqlSession.update("recipeMapper.addRecipeView",recipeNo);
	}

	public int selectRecipeScrap(SqlSessionTemplate sqlSession, int recipeNo, int memberNo) {
		return sqlSession.selectOne("recipeMapper.selectRecipeScrap", recipeNo);
	}

	public int selectRecipeLike(SqlSessionTemplate sqlSession, int recipeNo, int memberNo) {
		return sqlSession.selectOne("recipeMapper.selectRecipeLike", recipeNo);
	}

	public int selectCheckRecipeLike(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("recipeMapper.selectCheckRecipeLike", map);
	}

	public int selectCheckRecipeScrap(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("recipeMapper.selectCheckRecipeScrap", map);
	}

	public int addRecipeScrap(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.insert("recipeMapper.addRecipeScrap", map);
	}

	public int deleteRecipeScrap(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.delete("recipeMapper.deleteRecipeScrap",map);
	}

	public int addRecipeLike(SqlSessionTemplate sqlSession, Map<String, Integer> map) {
		return sqlSession.insert("recipeMapper.addRecipeLike", map);
	}

	public int deleteRecipeLike(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.delete("recipeMapper.deleteRecipeLike",map);
	}




	

	
	
	

	

	
	



	



	


}
