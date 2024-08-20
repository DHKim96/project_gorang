package com.kh.gorang.recipe.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.gorang.common.event.LikeCreatedEvent;
import com.kh.gorang.common.eventPublisher.QnaEventPublisher;
import com.kh.gorang.common.eventPublisher.ReviewEventPublisher;
import com.kh.gorang.common.model.vo.Media;
import com.kh.gorang.member.model.dao.MemberDao;
import com.kh.gorang.member.model.dto.LikeDtoForNotify;
import com.kh.gorang.member.model.dto.QnaDtoForNotify;
import com.kh.gorang.member.model.dto.ReviewDtoForNotify;
import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.member.model.vo.QnA;
import com.kh.gorang.member.model.vo.Review;
import com.kh.gorang.recipe.model.dao.RecipeDao;
import com.kh.gorang.recipe.model.vo.CookOrder;
import com.kh.gorang.recipe.model.vo.CookTip;
import com.kh.gorang.recipe.model.vo.Division;
import com.kh.gorang.recipe.model.vo.IngredientsInfo;
import com.kh.gorang.recipe.model.vo.Recipe;
import com.kh.gorang.recipe.model.vo.RecipeInsertDTO;
import com.kh.gorang.shopping.model.vo.Product;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class RecipeServiceImpl implements RecipeService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private RecipeDao recipeDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private ApplicationEventPublisher eventPublisher; // 이벤트 발행을 위한 객체
	
	@Autowired
	private QnaEventPublisher qnaEventPublisher; // qna 이벤트 발행 위한 객체(상품에서도 사용되기에 따로 분리)

	@Autowired
	private ReviewEventPublisher reviewEventPublisher; // review 이벤트 발행
	
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public Recipe insertRecipe(Recipe rcp) {
		return recipeDao.insertRecipe(sqlSession,rcp);
	}

	@Override
	@Transactional(rollbackFor = {Exception.class})
	public int insertRecipeInsertDTO(Recipe rcp, RecipeInsertDTO recipeInsertDTO ,HttpSession session) {
		int finalResult = 1; // 최종 반환 값 초기화
		Recipe result1 = recipeDao.insertRecipe(sqlSession,rcp);
		int rcpNo = result1.getRecipeNo();
		//재료정보
		for(Division division : recipeInsertDTO.getRcpDivList()) {	
			int divNum =recipeDao.insertDivision(sqlSession, division, rcpNo).getDivNo();
			for(IngredientsInfo ingre :division.getIngredientsInfoList()) {
				int result2 = recipeDao.insertIngredientsInfo(sqlSession, ingre, divNum);
				if (result2 <= 0) {
                    finalResult = 0; // 삽입 실패 시 -1로 설정
                }
			}
		}
		//조리순서
		for(CookOrder cookOrder : recipeInsertDTO.getCookOrderList()) {	
			int cookOrderNum =recipeDao.insertCookOrder(sqlSession, cookOrder, rcpNo).getCookOrdNo();
			for(CookTip cTip : cookOrder.getCookTipList()) {
				int result2 = recipeDao.insertCookTip(sqlSession, cTip, cookOrderNum);
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
	@Transactional(readOnly = true)
	@Override
	public Recipe selectRecipe(int recipeNo) {
		return recipeDao.selectRecipe(sqlSession,recipeNo);
	}
	
	//레시피 분류(재료 정보) 찾기
	@Transactional(readOnly = true)
	@Override
	public List<Division> selectDivList(int recipeNo) {
		 List<Division> divList =  recipeDao.selectDivList(sqlSession,recipeNo);
		 for(Division div : divList) {
			 div.setIngredientsInfoList(recipeDao.selectIngredientsInfoList(sqlSession,div.getDivNo()));
		 }
		
		return divList;
	}
	
	//레시피 조리순서(팁) 찾기
	@Transactional(readOnly = true)
	@Override
	public List<CookOrder> selectCookOrderList(int recipeNo) {
		 List<CookOrder> cookOrderList =  recipeDao.selectCookOrderList(sqlSession,recipeNo);
		 for(CookOrder ord : cookOrderList) {
			 ord.setCookTipList(recipeDao.selectCookTipList(sqlSession,ord.getCookOrdNo()));
		 } 
		return cookOrderList;
	}
	
	//레시피 완성사진 찾기
	@Transactional(readOnly = true)
	@Override
	public List<Media> selectCompleteFoodPhotoList(int recipeNo) {
		return recipeDao.selectCompleteFoodPhoto(sqlSession,recipeNo);
	}
	
	
	//레시피 수정
	@Override
	@Transactional(rollbackFor = {Exception.class})
	public int updateRecipeInsertDTO(Recipe rcp, RecipeInsertDTO recipeInsertDTO, HttpSession session) {
		int finalResult = 1; // 최종 반환 값 초기화
		int rcpNo = rcp.getRecipeNo();
		finalResult  = recipeDao.updateRecipe(sqlSession,rcp);  //레시피 수정
		
		for(Division division : recipeInsertDTO.getRcpDivList()) {	
			int divNum =recipeDao.insertDivision(sqlSession, division, rcpNo).getDivNo();
			for(IngredientsInfo ingre :division.getIngredientsInfoList()) {
				int result2 = recipeDao.insertIngredientsInfo(sqlSession, ingre, divNum);
				if (result2 <= 0) {
                    finalResult = 0; // 삽입 실패 시 -1로 설정
                }
			}
		}
		//조리순서
		for(CookOrder cookOrder : recipeInsertDTO.getCookOrderList()) {	
			int cookOrderNum =recipeDao.insertCookOrder(sqlSession, cookOrder, rcpNo).getCookOrdNo();
			for(CookTip cTip : cookOrder.getCookTipList()) {
				int result2 = recipeDao.insertCookTip(sqlSession, cTip, cookOrderNum);
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
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int deleteIngre(IngredientsInfo ingredientsInfo) {
		return recipeDao.deleteIngre(sqlSession,ingredientsInfo);
	}
	
	//분류 삭제
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int deleteDivision(Division division) {
		return recipeDao.deleteDivision(sqlSession,division);
	}
	
	//팁 삭제
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int deleteCookTip(CookTip cookTip) {
		return recipeDao.deleteCookTip(sqlSession,cookTip);
	}
	
	//조리 순서 삭제
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int deleteCookOrder(CookOrder cookOrder) {
		return recipeDao.deleteCookOrder(sqlSession,cookOrder);
	}
	
	//조리 완성 삭제
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int deleteCompletePhoto(Media media) {
		return recipeDao.deleteCompletePhoto(sqlSession,media);
	}

	// 레시피 글 전체 삭제
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int deleteAllRecipe(Recipe rcp, HttpSession session) {
		int finalResult = 1; // 최종 반환 값 초기화
		int rcpNo = rcp.getRecipeNo();
		RecipeInsertDTO recipeInsertDTO = new RecipeInsertDTO();
		recipeInsertDTO.setRcpDivList(recipeDao.selectDivList(sqlSession, rcpNo));
		for (Division division : recipeInsertDTO.getRcpDivList()) {
			division.setIngredientsInfoList(recipeDao.selectIngredientsInfoList(sqlSession, division.getDivNo()));
		}
		for (Division division : recipeInsertDTO.getRcpDivList()) {
			for (IngredientsInfo ingre : division.getIngredientsInfoList()) {
				finalResult *= recipeDao.deleteIngre(sqlSession, ingre);
			}
			finalResult *= recipeDao.deleteDivision(sqlSession, division);
		}
		recipeInsertDTO.setCookOrderList(recipeDao.selectCookOrderList(sqlSession, rcpNo));
		for (CookOrder cookOrder : recipeInsertDTO.getCookOrderList()) {
			cookOrder.setCookTipList(recipeDao.selectCookTipList(sqlSession, cookOrder.getCookOrdNo()));
		}
		for (CookOrder cookOrder : recipeInsertDTO.getCookOrderList()) {
			for (CookTip cookTip : cookOrder.getCookTipList()) {
				finalResult *= recipeDao.deleteCookTip(sqlSession, cookTip);
			}
			finalResult *= recipeDao.deleteCookOrder(sqlSession, cookOrder);
		}		
		recipeInsertDTO.setCompleteFoodPhoto(recipeDao.selectCompleteFoodPhoto(sqlSession, rcpNo));
		for (Media media : recipeInsertDTO.getCompleteFoodPhoto()) {
			finalResult *= recipeDao.deleteCompletePhoto(sqlSession, media);
		}
		finalResult *= recipeDao.deleteRecipe(sqlSession, rcpNo);

		return finalResult;
	}

	//레시피 회원 찾기
	@Transactional(readOnly = true)
	@Override
	public Member selectRecipeMember(int recipeNo) {
		return recipeDao.selectRecipeMember(sqlSession,recipeNo);
	}

	//레시피 리뷰 작성
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int insertReview(Review review) {
		int result = recipeDao.insertReview(sqlSession,review);
		if ( result > 0 ) {
			// 알림용 리뷰 객체 생성
			ReviewDtoForNotify reviewDto = memberDao.getReviewDtoForNotify(sqlSession, review.getReviewNo(), 2);
			Member recipeWriter = recipeDao.selectRecipeMember(sqlSession, review.getRefRecipeNo());
			// 이벤트 발행 메소드 실시
			reviewEventPublisher.publishReviewEvent(reviewDto, recipeWriter);
		}
		return result;
	}
	
	//레시피 리뷰 찾기
	@Transactional(readOnly = true)
	@Override
	public List<Review> selectRecipeReviewList(int recipeNo) {
		return recipeDao.selectRecipeReviewList(sqlSession,recipeNo);
	}
	
	//레시피 QnA 찾기
	@Transactional(readOnly = true)
	@Override
	public List<QnA> selectRecipeQnaList(int recipeNo) {
		return recipeDao.selectRecipeQnaList(sqlSession,recipeNo);
	}
	
	//레시피 QnA 추가
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int insertQnA(QnA qna) {
		int result = recipeDao.insertQnA(sqlSession,qna);
		// insert 성공 시 qna 작성 이벤트 발행
		if ( result > 0 ) {
			QnaDtoForNotify qnaDto = memberDao.getQnaDtoForNotify(sqlSession, qna.getQnaNo(), 2);
			Member recipeWriter = recipeDao.selectRecipeMember(sqlSession, qna.getRefRecipeNo());
			// 답변글이 작성되면 질문글 작성자에게 알림을 전송해야하므로 질문글 작성자의 정보 전달
			// refQnaNo가 있을 경우에는 답변글을 의미
			Member questionWriter = qna.getRefQnaNo() == 0 ? null : memberDao.getQnaWriter(sqlSession, qna.getRefQnaNo());
			// 이벤트 발행 메소드 실행
	        qnaEventPublisher.publishQnaEvent(qnaDto, recipeWriter, questionWriter);
			}
		return result;
	}
	
	//레시피 리뷰 작성 개수 찾기
	@Transactional(readOnly = true)
	@Override
	public int selectRecipeReviewCount(int recipeNo) {
		return recipeDao.selectRecipeReviewCount(sqlSession,recipeNo);
	}
	
	
	//레시피 QnA 개수 찾기
	@Transactional(readOnly = true)
	@Override
	public int selectRecipeQnaCount(int recipeNo) {			
		return recipeDao.selectRecipeQnaCount(sqlSession,recipeNo);
	}

	
	//레시피 관련 상품 조회 ( 태그가 아닌 재료를 기준으로 비교 )
	@Transactional(readOnly = true)
	@Override
	public List<Product> selectProductList(List<Division> divList, int recipeNo) {
	ArrayList<Product> productList = new ArrayList<Product>();	
		for(Division div : divList) {
				for(IngredientsInfo ingre:div.getIngredientsInfoList()) { //division 안에 있는 ingre추출(재료 이름)
					if(productList.size()<5) {
						Product product =  recipeDao.selectProductList(sqlSession,ingre.getIngreName());
						if(product != null) {					
							productList.add(product);
						}
					}
					else return productList;
				}
		}
		if(productList.size()<5) { //만약 관련 상품  5개를 못찾았을 시
			for(int i=productList.size(); i<5; i++) {
				Product product = recipeDao.selectProductListRandom(sqlSession); //랜덤아무거나 넣기
				// 중복 확인 => 중복 상품이름이 나오면 다른걸로 다시 찾기
				boolean isCheck = false;
				for (Product productCheck : productList) {
					if (productCheck.getProductName().equals(product.getProductName())) {
						isCheck = true;
						break;
					}
				}				
				// 중복되지 않은 경우에만 추가
				if (!isCheck) {
					productList.add(product);
				}
			}					 
		}
		return productList;
	}
	
	//조회수 늘리기
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int addRecipeView(int recipeNo) {
		 return recipeDao.addRecipeView(sqlSession,recipeNo);
		
	}

	
	//스크랩 조회
	@Transactional(readOnly = true)
	@Override
	public int selectRecipeScrap(int recipeNo, int memberNo) {
		return recipeDao.selectRecipeScrap(sqlSession,recipeNo,memberNo);
	}
	
	//좋아요 조회
	@Transactional(readOnly = true)
	@Override
	public int selectRecipeLike(int recipeNo, int memberNo) {
		return recipeDao.selectRecipeLike(sqlSession,recipeNo,memberNo);
	}

	//회원 스크랩 상태
	@Transactional(readOnly = true)
	@Override
	public int selectCheckRecipeScrap(Map<String, Object> map) {
		return recipeDao.selectCheckRecipeScrap(sqlSession,map);
	}

	//회원 좋아요 상태
	@Transactional(readOnly = true)
	@Override
	public int selectCheckRecipeLike(Map<String, Object> map) {
		return recipeDao.selectCheckRecipeLike(sqlSession,map);
	}
	
	//레시피 스크랩 등록
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int addRecipeScrap(Map<String, Object> map) {
		
		return recipeDao.addRecipeScrap(sqlSession,map);
	}
	
	//레시피 스크랩 취소
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int deleteRecipeScrap(Map<String, Object> map) {
		
		return recipeDao.deleteRecipeScrap(sqlSession,map);
	}
	
	//레시피 좋아요 등록
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int addRecipeLike(Map<String, Integer> map) {
		int result = recipeDao.addRecipeLike(sqlSession,map);
		// insert 성공 시 좋아요 알림 이벤트 발행
		if ( result > 0 ) {
			int memberNo = map.get("memberNo");
			int recipeNo = map.get("recipeNo");
			LikeDtoForNotify like = memberDao.getLikeForNotify(sqlSession, memberNo, recipeNo, 2);
			Member recipeWriter = recipeDao.selectRecipeMember(sqlSession, recipeNo);
			eventPublisher.publishEvent(LikeCreatedEvent.builder()
											.like(like)
											.recipeWriterNo(recipeWriter.getMemberNo())
											.likeType(2)
											.build()
											);
		}
		return result;
	}
	
	//레시피 좋아요 취소
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int deleteRecipeLike(Map<String, Object> map) {
		return recipeDao.deleteRecipeLike(sqlSession,map);
	}
	
}
