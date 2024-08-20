package com.kh.gorang.recipe.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.kh.gorang.recipe.model.vo.Recipe;
import com.kh.gorang.recipe.model.vo.RecipeInsertDTO;
import com.kh.gorang.shopping.model.vo.Product;
import com.kh.gorang.common.model.vo.Media;
import com.kh.gorang.member.model.dto.QnaDtoForNotify;
import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.member.model.vo.QnA;
import com.kh.gorang.member.model.vo.Review;
import com.kh.gorang.recipe.model.vo.CookOrder;
import com.kh.gorang.recipe.model.vo.CookTip;
import com.kh.gorang.recipe.model.vo.Division;
import com.kh.gorang.recipe.model.vo.IngredientsInfo;

public interface RecipeService {
	Recipe insertRecipe(Recipe rcp);

	int insertRecipeInsertDTO(Recipe rcp, RecipeInsertDTO recipeInsertDTO ,HttpSession session);

	Recipe selectRecipe(int recipeNo);

	List<Division> selectDivList(int recipeNo);

	List<CookOrder> selectCookOrderList(int recipeNo);

	List<Media> selectCompleteFoodPhotoList(int recipeNo);

	int updateRecipeInsertDTO(Recipe rcp, RecipeInsertDTO recipeInsertDTO, HttpSession session);

	int deleteIngre(IngredientsInfo ingredientsInfo);

	int deleteDivision(Division division);

	int deleteCookTip(CookTip cookTip);

	int deleteCookOrder(CookOrder cookOrder);

	int deleteCompletePhoto(Media media);

	int deleteAllRecipe(Recipe rcp,  HttpSession session);

	Member selectRecipeMember(int recipeNo);

	int insertReview(Review review);

	List<Review> selectRecipeReviewList(int recipeNo);

	List<QnA> selectRecipeQnaList(int recipeNo);

	int insertQnA(QnA qna);

	int selectRecipeReviewCount(int recipeNo);


	int selectRecipeQnaCount(int recipeNo);

	List<Product> selectProductList(List<Division> divList, int recipeNo);

	int addRecipeView(int recipeNo);

	int selectRecipeScrap(int recipeNo, int memberNo);

	int selectRecipeLike(int recipeNo, int memberNo);

	int selectCheckRecipeScrap(Map<String, Object> map);

	int selectCheckRecipeLike(Map<String, Object> map);

	int addRecipeScrap(Map<String, Object> map);

	int deleteRecipeScrap(Map<String, Object> map);

	int addRecipeLike(Map<String, Integer> map);

	int deleteRecipeLike(Map<String, Object> map);

//	int findDivLen(Recipe rcp, HttpSession session);
//
//	int findIngreLen(RecipeInsertDTO recipeInsertDTO, HttpSession session);
//
//	int findCoLen(Recipe rcp, HttpSession session);
//
//	int findCtLen(RecipeInsertDTO recipeInsertDTO, HttpSession session);
//
//	int findCpLen(RecipeInsertDTO recipeInsertDTO, HttpSession session);
}