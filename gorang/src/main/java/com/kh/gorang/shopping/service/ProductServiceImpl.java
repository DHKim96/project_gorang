package com.kh.gorang.shopping.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.gorang.common.model.vo.PageInfo;
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


	@Override
	public ArrayList<Product> selectBestSellerList() {
		return productDao.selectBestSellerList(sqlSession);
	}

	@Override
	public ArrayList<Product> selectRecentProductList() {
		return productDao.selectRecentProductList(sqlSession);
	}


	@Override
	public int selectProductCount(Map<String, String> map) {
		return productDao.selectProductCount(sqlSession, map);
	}

	@Override
	public ArrayList<Product> selectResultProductList(PageInfo pi, Map<String, String> map) {
		return productDao.selectResultProductList(sqlSession, pi, map);
	}

	@Override
	public Product selectProductByProductNo(int productNo) {
		
		Product product = null;
		int increaseProductViews = productDao.increaseProductViews(sqlSession, productNo);
		
		if(increaseProductViews > 0) {
			product = productDao.selectProductByProductNo(sqlSession, productNo);
		}
		
		return product;
	}

	@Override
	public ArrayList<QnA> selectProductQnAsByPno(int productNo, PageInfo pi) {
		return productDao.selectProductQnAsByPno(sqlSession, productNo, pi);
	}


	public int selectAllProductQuantity() {
		return productDao.selectAllProductQuanity(sqlSession);
	}

	@Override
	public ArrayList<ProductDetailOption> selectProductOptsByPno(int productNo) {
        return productDao.selectProductOptsByPno(sqlSession, productNo);
    }

	@Override
	public int selectSaleProductQuantity() {
		return 0;
	}

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int insertProductQna(QnA q) {
		int result = productDao.insertProductQna(sqlSession, q);
		int memberNo = 0;
		if(result > 0 && q.getRefQnaNo() != 0) {
			// 답글 달린 문의글 번호로 해당 문의글 작성자 번호 조회
			memberNo = productDao.selectMemberNoByRefQnaNo(sqlSession, q.getRefQnaNo());
		}
		return memberNo;
	}


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


	@Override
	public int insertScrapProduct(ScrapBoardDTO scrapBoardDTO) {
		
		// return 2: scrapProduct 테이블에 추가 -> product테이블의 scrap_count + 1
		// return 1: scrapProduct 테이블에서 삭제 -> product 테이블의 scrap_count - 1
		// return 0: 걍 에러
		
		int existScrapProduct = productDao.existScrapProduct(sqlSession, scrapBoardDTO);
		
		log.info("existScrapProduct={}", existScrapProduct);
		
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
		
		int result = productDao.existScrapProduct(sqlSession, scrapBoardDTO);
		log.info("scrapBoardDTO={}", scrapBoardDTO);
		log.info("result={}", result);
		
		return result;
	}


}
