package com.kh.gorang.recipe.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.gorang.common.model.vo.Media;
import com.kh.gorang.common.template.SaveFileController;
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
	public int insertRecipeInsertDTO(Recipe rcp, RecipeInsertDTO recipeInsertDTO ,HttpSession session) {
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
		//레시피완성 사진
		for (Media md : recipeInsertDTO.getCompleteFoodPhoto()) {
	        if (!md.getOriginName().equals("")) {
	        	md.setChangeName(md.getOriginName());
	        	md.setMediaType(1);
	        	md.setMediaKind(1);
	        	md.setFilePath("/resources/uploadfile/recipe/recipefinal");
	        	int result2 = recipeDao.insertRecipeMedia(sqlSession,md,rcpNo);
	        	if (result2 <= 0) {
                    finalResult = 0; // 삽입 실패 시 -1로 설정
                }        	
	        }
	    }

		return finalResult;
	}

	//레시피 찾기
	@Override
	public Recipe selectRecipe(int recipeNo) {
		return recipeDao.selectRecipe(sqlSession,recipeNo);
	}
	
	//레시피 분류(재료 정보) 찾기
	@Override
	public List<Division> selectDivList(int recipeNo) {
		 List<Division> divList =  recipeDao.selectDivList(sqlSession,recipeNo);
		 for(Division div : divList) {
			 div.setIngredientsInfoList(recipeDao.selectIngredientsInfoList(sqlSession,div.getDivNo()));
		 }
		return divList;
	}
	
	//레시피 조리순서(팁) 찾기
	@Override
	public List<CookOrder> selectCookOrderList(int recipeNo) {
		 List<CookOrder> cookOrderList =  recipeDao.selectCookOrderList(sqlSession,recipeNo);
		 for(CookOrder ord : cookOrderList) {
			 ord.setCookTipList(recipeDao.selectCookTipList(sqlSession,ord.getCookOrdNo()));
		 } 
		return cookOrderList;
	}
	
	//레시피 완성사진 찾기
	@Override
	public List<Media> selectCompleteFoodPhotoList(int recipeNo) {
		return recipeDao.selectCompleteFoodPhoto(sqlSession,recipeNo);
	}
	
	
	//레시피 수정
	@Override
	@Transactional
	public int updateRecipeInsertDTO(Recipe rcp, RecipeInsertDTO recipeInsertDTO, HttpSession session) {
		int finalResult = 1; // 최종 반환 값 초기화
		int rcpNo = rcp.getRecipeNo();
		finalResult  = recipeDao.updateRecipe(sqlSession,rcp);  //레시피 수정
		
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
		//레시피완성 사진
		for (Media md : recipeInsertDTO.getCompleteFoodPhoto()) {
	        if (!md.getOriginName().equals("")) {
	        	md.setChangeName(md.getOriginName());
	        	md.setMediaType(1);
	        	md.setMediaKind(1);
	        	md.setFilePath("/resources/uploadfile/recipe/recipefinal");
	        	int result2 = recipeDao.insertRecipeMedia(sqlSession,md,rcpNo);
	        	if (result2 <= 0) {
                    finalResult = 0; // 삽입 실패 시 -1로 설정
                }        	
	        }
	    }

		return finalResult;
		
	}
	
	//재료 삭제
	@Override
	public int deleteIngre(IngredientsInfo ingredientsInfo) {
		return recipeDao.deleteIngre(sqlSession,ingredientsInfo);
	}
	//분류 삭제
	@Override
	public int deleteDivision(Division division) {
		return recipeDao.deleteDivision(sqlSession,division);
	}
	//팁 삭제
	@Override
	public int deleteCookTip(CookTip cookTip) {
		return recipeDao.deleteCookTip(sqlSession,cookTip);
	}
	//조리 순서 삭제
	@Override
	public int deleteCookOrder(CookOrder cookOrder) {
		return recipeDao.deleteCookOrder(sqlSession,cookOrder);
	}
	//조리 완성 삭제
	@Override
	public int deleteCompletePhoto(Media media) {
		return recipeDao.deleteCompletePhoto(sqlSession,media);
	}

	//레시피 글 전체 삭제
	@Override
	public int deleteAllRecipe(Recipe rcp, HttpSession session) {
		int finalResult = 1; // 최종 반환 값 초기화
		int rcpNo=rcp.getRecipeNo();
		RecipeInsertDTO recipeInsertDTO = new RecipeInsertDTO();
		recipeInsertDTO.setRcpDivList(recipeDao.selectDivList(sqlSession,rcpNo));
		for(Division division : recipeInsertDTO.getRcpDivList()) {
			division.setIngredientsInfoList(recipeDao.selectIngredientsInfoList(sqlSession, division.getDivNo()));
		}
	
		for(Division division : recipeInsertDTO.getRcpDivList()) {
			for(IngredientsInfo ingre : division.getIngredientsInfoList()) {
				finalResult *=recipeDao.deleteIngre(sqlSession, ingre);
				System.out.println("finalResult deleteIngre :" + finalResult);
			}
			finalResult *= recipeDao.deleteDivision(sqlSession, division);
			System.out.println("finalResult deleteDivision :" + finalResult);
		}
		
		recipeInsertDTO.setCookOrderList(recipeDao.selectCookOrderList(sqlSession, rcpNo));	
		for(CookOrder cookOrder : recipeInsertDTO.getCookOrderList()) {
			cookOrder.setCookTipList(recipeDao.selectCookTipList(sqlSession, cookOrder.getCookOrdNo()));
			System.out.println("finalResult selectCookTipList :" + finalResult);
		}
		
		for(CookOrder cookOrder : recipeInsertDTO.getCookOrderList()) {
			System.out.println(cookOrder);
			for(CookTip cookTip : cookOrder.getCookTipList()) {
				System.out.println(cookTip);
				finalResult *=recipeDao.deleteCookTip(sqlSession, cookTip);
				System.out.println("finalResult deleteCookTip :" + finalResult);
			}
			finalResult *=recipeDao.deleteCookOrder(sqlSession, cookOrder);
			System.out.println("finalResult deleteCookOrder :" + finalResult);
		}
		recipeInsertDTO.setCompleteFoodPhoto(recipeDao.selectCompleteFoodPhoto(sqlSession, rcpNo));
		for(Media media :recipeInsertDTO.getCompleteFoodPhoto()) {
			finalResult *=recipeDao.deleteCompletePhoto(sqlSession,media);
			System.out.println("finalResult deleteCompletePhoto :" + finalResult);
		}
		finalResult *=recipeDao.deleteRecipe(sqlSession, rcpNo);
		System.out.println("finalResult deleteRecipe :" + finalResult);
		return finalResult;
	}


	
	






	

	
}
