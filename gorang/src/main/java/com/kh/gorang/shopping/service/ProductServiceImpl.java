package com.kh.gorang.shopping.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.gorang.common.eventPublisher.QnaEventPublisher;
import com.kh.gorang.common.model.vo.PageInfo;
import com.kh.gorang.member.model.dao.MemberDao;
import com.kh.gorang.member.model.dto.QnaDtoForNotify;
import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.member.model.vo.QnA;
import com.kh.gorang.member.model.vo.Review;
import com.kh.gorang.shopping.model.dao.ProductDao;
import com.kh.gorang.shopping.model.dto.ScrapBoardDTO;
import com.kh.gorang.shopping.model.vo.Product;
import com.kh.gorang.shopping.model.vo.ProductDetailOption;
import com.kh.gorang.shopping.model.vo.ProductInsertDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService{

	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Autowired
	ProductDao productDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private QnaEventPublisher qnaEventPublisher; // qna 이벤트 발행 위한 객체(상품에서도 사용되기에 따로 분리)
	
	
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int insertProduct(ProductInsertDTO product) {

		List<ProductDetailOption> detailOptions = product.getOptions();
		List<Integer> optionNoList = new ArrayList<Integer>();		
		
		int productNo = productDao.insertProduct(sqlSession, product);
		
		for(ProductDetailOption detailOption : detailOptions) {
			int optionNo = productDao.insertDetailOptions(sqlSession, detailOption);
			optionNoList.add(optionNo);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productNo",productNo);
		map.put("optionNoList",optionNoList);
		
		return productDao.insertOptions(sqlSession, map);
	}

	
	@Transactional(readOnly = true)
	@Override
	public ArrayList<Product> selectBestSellerList() {
		return productDao.selectBestSellerList(sqlSession);
	}
	
	@Transactional(readOnly = true)
	@Override
	public ArrayList<Product> selectRecentProductList() {
		return productDao.selectRecentProductList(sqlSession);
	}

	@Transactional(readOnly = true)
	@Override
	public int selectProductCount(Map<String, String> map) {
		return productDao.selectProductCount(sqlSession, map);
	}
	
	@Transactional(readOnly = true)
	@Override
	public ArrayList<Product> selectResultProductList(PageInfo pi, Map<String, String> map) {
		return productDao.selectResultProductList(sqlSession, pi, map);
	}
	
	@Transactional(readOnly = true)
	@Override
	public Product selectProductByProductNo(int productNo) {
		
		Product product = null;
		int increaseProductViews = productDao.increaseProductViews(sqlSession, productNo);
		
		if(increaseProductViews > 0) {
			product = productDao.selectProductByProductNo(sqlSession, productNo);
		}
		
		return product;
	}
	
	@Transactional(readOnly = true)
	@Override
	public ArrayList<QnA> selectProductQnAsByPno(int productNo, PageInfo pi) {
		return productDao.selectProductQnAsByPno(sqlSession, productNo, pi);
	}
	
	@Transactional(readOnly = true)
	public int selectAllProductQuantity() {
		return productDao.selectAllProductQuanity(sqlSession);
	}
	
	@Transactional(readOnly = true)
	@Override
	public ArrayList<ProductDetailOption> selectProductOptsByPno(int productNo) {
        return productDao.selectProductOptsByPno(sqlSession, productNo);
    }
	
	@Transactional(readOnly = true)
	@Override
	public int selectSaleProductQuantity() {
		return 0;
	}

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int insertProductQna(QnA q) {
		int result = productDao.insertProductQna(sqlSession, q);
		if(result > 0) {
			// 답글 달린 문의글 번호로 해당 문의글 작성자 번호 조회
			QnaDtoForNotify qnaDto = memberDao.getQnaDtoForNotify(sqlSession, q.getQnaNo(), 1);
			// 현재 상품글 작성자는 무조건 admin이기 때문에
			Member productWriter = memberDao.getMemberByNo(sqlSession, 1);
			// 답변글이 작성되면 질문글 작성자에게 알림을 전송해야하므로 질문글 작성자의 정보 전달
			// refQnaNo가 있을 경우에는 답변글을 의미
			Member questionWriter = q.getRefQnaNo() == 0 ? null : memberDao.getQnaWriter(sqlSession, q.getRefQnaNo());
			// 이벤트 발행 메소드 실행
	        qnaEventPublisher.publishQnaEvent(qnaDto, productWriter, questionWriter);
		}
		return result;
	}

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int insertProductReview(Review re) {
		return productDao.insertProductReview(sqlSession, re);
	}

	@Transactional(readOnly = true)
	@Override
	public int selectReviewsCount(int productNo) {
		return productDao.selectReviewCount(sqlSession, productNo);
	}

	@Transactional(readOnly = true)
	@Override
	public ArrayList<Review> selectProductReviewsByPno(int productNo, PageInfo pi) {
		return productDao.selectProductReviewsByPno(sqlSession, productNo, pi);
	}
	
	@Transactional(readOnly = true)
	@Override
	public int selectQnasCount(int productNo) {
		return productDao.selectQnasCount(sqlSession, productNo);
	}

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int insertScrapProduct(ScrapBoardDTO scrapBoardDTO) {
		
		// return 2: scrapProduct 테이블에 추가 -> product테이블의 scrap_count + 1
		// return 1: scrapProduct 테이블에서 삭제 -> product 테이블의 scrap_count - 1
		// return 0: 걍 에러
		
		int existScrapProduct = productDao.existScrapProduct(sqlSession, scrapBoardDTO);
		
		if(existScrapProduct == 0) {
			int insertScrapProduct = productDao.insertScrapProduct(sqlSession, scrapBoardDTO);
			
			if(insertScrapProduct > 0) {
				
				int increaseScrapCount = productDao.increaseScrapCount(sqlSession, scrapBoardDTO);
				
				if(increaseScrapCount > 0) {
					return 2;
				}
				
			}
		} else {
			int deleteScrapProduct = ProductDao.deleteScrapProduct(sqlSession, scrapBoardDTO);
			
			if(deleteScrapProduct > 0) {
				
				int decreaseScrapCount = productDao.decreaseScrapCount(sqlSession, scrapBoardDTO);
				
				if(decreaseScrapCount > 0) {
					return 1;
				}
				
			}
		}
		
		return 0;
	}


	@Override
	public int existScrapProduct(ScrapBoardDTO scrapBoardDTO) {
		return productDao.existScrapProduct(sqlSession, scrapBoardDTO);
	}
}
