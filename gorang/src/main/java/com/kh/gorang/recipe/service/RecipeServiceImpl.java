package com.kh.gorang.recipe.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.gorang.recipe.model.dao.RecipeDao;
import com.kh.gorang.recipe.model.vo.CookOrder;
import com.kh.gorang.recipe.model.vo.CookTip;
import com.kh.gorang.recipe.model.vo.Division;
import com.kh.gorang.recipe.model.vo.IngredientsInfo;
import com.kh.gorang.recipe.model.vo.Recipe;
import com.kh.gorang.recipe.model.vo.RecipeInsertDTO;

@Service
public class RecipeServiceImpl implements RecipeService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private RecipeDao recipeDao;
	
	
	@Override
	public Recipe insertRecipe(Recipe rcp) {
		return recipeDao.insertRecipe(sqlSession,rcp);
	}

	@Override
	@Transactional
	public int insertRecipeInsertDTO(Recipe rcp, RecipeInsertDTO recipeInsertDTO) {
		int finalResult = 1; // 최종 반환 값 초기화
		Recipe result1 = recipeDao.insertRecipe(sqlSession,rcp);
		System.out.println(result1);
		int rcpNo = result1.getRecipeNo();
		System.out.println("rcpNo:"+ rcpNo);
		//재료정보
		for(Division division : recipeInsertDTO.getRcpDivList()) {	
			int divNum =recipeDao.insertDivision(sqlSession, division, rcpNo).getDivNo();
			for(IngredientsInfo ingre :division.getIngredientsInfoList()) {
				System.out.println("서비스 null확인:"+ingre);
				int result2 = recipeDao.insertIngredientsInfo(sqlSession, ingre, divNum);
				System.out.println("result2:"+result2);
				if (result2 <= 0) {
                    finalResult = 0; // 삽입 실패 시 -1로 설정
                }
			}
		}
		//조리순서
		for(CookOrder cookOrder : recipeInsertDTO.getCookOrderList()) {	
			int cookOrderNum =recipeDao.insertCookOrder(sqlSession, cookOrder, rcpNo).getCookOrdNo();
			for(CookTip cTip : cookOrder.getCookTipList()) {
				System.out.println("서비스 null확인:"+cTip);
				int result2 = recipeDao.insertCookTip(sqlSession, cTip, cookOrderNum);
				System.out.println("result2:"+result2);
				if (result2 <= 0) {
                    finalResult = 0; // 삽입 실패 시 -1로 설정
                }
			}		
		}

		return finalResult;
	}

	
}
