package com.kh.gorang.recipe.service;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.gorang.common.model.vo.PageInfo;
import com.kh.gorang.recipe.model.dao.OdgRecipeDao;
import com.kh.gorang.recipe.model.dto.RecipeListDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OdgRecipeServiceImpl implements OdgRecipeService{

	private final OdgRecipeDao odgRecipeDao;
	private final SqlSessionTemplate sqlSession;
	
	@Transactional(readOnly = true)
	@Override
	public ArrayList<RecipeListDto> getRecipeList(PageInfo pi, Map<String, Object> map) {
		return odgRecipeDao.getRecipeList(sqlSession, pi, map);
	}

	// 레시피 개수 조회
	@Transactional(readOnly = true)
	@Override
	public int getRecipeCount(Map<String, Object> map) {
		return odgRecipeDao.getRecipeCount(sqlSession, map);
	}
	

}
