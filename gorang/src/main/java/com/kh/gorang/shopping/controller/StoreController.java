package com.kh.gorang.shopping.controller;

import static com.kh.gorang.common.template.SaveFileController.saveFile;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.kh.gorang.common.model.vo.PageInfo;
import com.kh.gorang.common.template.Pagination;
import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.member.model.vo.ProductCart;
import com.kh.gorang.member.model.vo.QnA;
import com.kh.gorang.member.model.vo.Review;
import com.kh.gorang.member.service.MemberService;
import com.kh.gorang.shopping.model.dto.ScrapBoardDTO;
import com.kh.gorang.shopping.model.vo.Order;
import com.kh.gorang.shopping.model.vo.OrderPdopt;
import com.kh.gorang.shopping.model.vo.Product;
import com.kh.gorang.shopping.model.vo.ProductDetailOption;
import com.kh.gorang.shopping.service.OrderService;
import com.kh.gorang.shopping.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class StoreController {
	
	
	private final ProductService productService;
	private final OrderService orderService;
	private final MemberService memberService;
	
	// 상품 설명에 들어가는 이미지 저장하는 메서드
	@PostMapping("detaildesc")
	@ResponseBody
	public String uploadDetailDesc(List<MultipartFile> fileList, HttpSession session) {
		
		List<String> changeNameList = new ArrayList<String>();
		for(MultipartFile mf : fileList) {
			String changeName = saveFile(mf,session,"/product/productdescimg/");
			changeNameList.add("/product/productdescimg/"+changeName);
		}
		return new Gson().toJson(changeNameList);
	}

	// 쇼핑 메인화면
	@RequestMapping("main.po")
	public String storeMain(Model model) {
		// 가장 많이 팔린 상품 4개 조회
		ArrayList<Product> bestSellerList = productService.selectBestSellerList(); 
		
		// 최근에 입고된 상품 4개 조회
		ArrayList<Product> recentProductList = productService.selectRecentProductList();
		
		model.addAttribute("bestSellerList", bestSellerList);
		model.addAttribute("recentProductList", recentProductList);
		
		return "shopping/shoppingMain";
	}
	
	@RequestMapping("list.po")
	public String storeList(
				@RequestParam(defaultValue="1") int cpage,
				@RequestParam(defaultValue="all") String category,
				@RequestParam(defaultValue="new") String sort,
				@RequestParam(defaultValue="") String content,
				Model model) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("category",category);
		map.put("sort", sort);
		map.put("content",content);
		
		// category와 sort를 가지고 상품들 조회
		int productCount = productService.selectProductCount(map);
		
		PageInfo pi = Pagination.getPageInfo(productCount, cpage, 10, 20);
		
		ArrayList<Product> list = productService.selectResultProductList(pi, map);
		
		model.addAttribute("list",list);
		model.addAttribute("pi",pi);
		model.addAttribute("category",category);
		model.addAttribute("sort",sort);
		model.addAttribute("content", content);
		
		return "shopping/productList";
	}
	
	// 상품 상세 페이지 리턴하는 컨트롤러
	@RequestMapping("detail.po")
	public String productDetailForm(@RequestParam String pno, HttpSession session, Model model) {
	    int productNo = Integer.parseInt(pno); 
	    
	    // 로그인 유저 정보 확인
	    Member loginUser = (Member) session.getAttribute("loginUser");
	    if (loginUser != null) {
	        int memberNo = loginUser.getMemberNo();
	        ScrapBoardDTO scrapBoardDTO = new ScrapBoardDTO(productNo, memberNo);
	        int existScrapProduct = productService.existScrapProduct(scrapBoardDTO);
	        model.addAttribute("existScrapProduct", existScrapProduct);
	    } else {
	        // 비로그인 상태일 때 처리
	        model.addAttribute("existScrapProduct", 0);
	    }
	    
	    Product p = productService.selectProductByProductNo(productNo);
	    
	    if (p == null) {
	        model.addAttribute("alertMsg", "조회 실패");
	        return "redirect:/list.po";
	    } else {
	        model.addAttribute("p", p);
	        return "shopping/productDetailForm";
	    }
	}
	
	// ajax 로 product 객체 가져오는 메소드
	@ResponseBody
	@GetMapping(value = "ajaxDetail.po", produces = "application/json; charset=utf-8")
	public String ajaxSelectProduct(@RequestParam("pno") String pno) {
		int productNo = Integer.parseInt(pno);
		Product p = productService.selectProductByProductNo(productNo);
		return new Gson().toJson(p);
	}
	
	
	// ajax 로 상품 옵션 가져오는 메소드
	@ResponseBody
	@GetMapping(value = "ajaxOpt.po", produces = "application/json; charset=utf-8")
	public String ajaxSelectProductOpts(@RequestParam("pno") String pno) {
		int productNo = Integer.parseInt(pno);
		ArrayList<ProductDetailOption> opts = productService.selectProductOptsByPno(productNo);
		return new Gson().toJson(opts);
	}
	
//	===================================== 리뷰 관련 컨트롤러 ============================================
	
	// ajax로 상품 리뷰 가져오는 메소드
	@ResponseBody
	@GetMapping(value = "ajaxReview.po")
	public Map<String, Object> ajaxSelectProductReviews(@RequestParam("pno") String pno, @RequestParam(value="cpage", defaultValue= "1") String cpage) {
		int cp = Integer.parseInt(cpage);
		
		int productNo = Integer.parseInt(pno);
		
		// 해당 상품에 대한 리뷰 총 갯수
		int reviewsCount = productService.selectReviewsCount(productNo);
		
		PageInfo pi = Pagination.getPageInfo(reviewsCount, cp, 10, 5);
		
		ArrayList<Review> reviews = productService.selectProductReviewsByPno(productNo, pi);
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("reviews", reviews);
		result.put("pi", pi);
		
		return result;
	}
	
	
	@RequestMapping("insertReview.po")
	public String insertProductReview(@RequestParam int refMemberNo, @RequestParam int refProductNo,
								   @RequestParam int refPdoptNo, @RequestParam int rating, @RequestParam MultipartFile reviewPhotoUpfile,
								   @RequestParam String reviewContent, HttpSession session) {
		Review re = new Review();
		
		if(!reviewPhotoUpfile.getOriginalFilename().equals("")) {
			String changeFileName = saveFile(reviewPhotoUpfile, session, "/review/product-review/");
			re.setReviewPhoto(changeFileName);
		}
		
		re.setRefMemberNo(refMemberNo);
		re.setRefProductNo(refProductNo);
		re.setRefPdOptNo(refPdoptNo);
		re.setRating(rating);
		re.setReviewContent(reviewContent);
		
		int result = productService.insertProductReview(re);
		
		String str = "redirect:/detail.po?pno=" + refProductNo;
		
		if(result > 0) {
			session.setAttribute("alertMsg", "후기 등록 성공.");
			return str;
		} else {
			session.setAttribute("alertMsg", "후기 등록 실패");
			return str;
		}
	}
	
	//======================================= qna 관련 컨트롤러 ==========================================
	
	//ajax로 상품 문의 가져오는 메소드
	@ResponseBody
	@GetMapping(value = "ajaxQnA.po")
	public Map<String, Object> ajaxSelectProductQnAs(@RequestParam("pno") String pno, @RequestParam(value="cpage", defaultValue= "1") String cpage) {
		int cp = Integer.parseInt(cpage);
		
		int productNo = Integer.parseInt(pno);
		
		int qnasCount = productService.selectQnasCount(productNo);
		
		PageInfo pi = Pagination.getPageInfo(qnasCount, cp, 10, 10);
		
		ArrayList<QnA> qnas = productService.selectProductQnAsByPno(productNo, pi);
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("qnas", qnas);
		result.put("pi", pi);
		
		return result;
	}
	
	
	@ResponseBody
    @PostMapping("/insertQna.po")
    public int insertQna( @RequestParam("writerNo") int writerNo, @RequestParam("refProductNo") int refProductNo,
				            @RequestParam("refPdoptNo") int refPdoptNo,@RequestParam("qnaContent") String qnaContent,
				            @RequestParam("refQnaNo") int refQnaNo, @RequestParam(value = "qnaPhotoUpfile", required = false) MultipartFile qnaPhotoUpfile,
				            HttpSession session) {      
        
        QnA qna = new QnA();
        
        if (qnaPhotoUpfile != null && !qnaPhotoUpfile.getOriginalFilename().isEmpty()) {
            String changeFileName = saveFile(qnaPhotoUpfile, session, "/qna/product-qna/");
            qna.setQnaPhoto(changeFileName);
        }

        qna.setWriterNo(writerNo);
        qna.setRefProductNo(refProductNo);
        qna.setRefPdoptNo(refPdoptNo);
        qna.setRefQnaNo(refQnaNo);
        qna.setQnaContent(qnaContent);
                        
        return productService.insertProductQna(qna); 
    }
	
	// ================================== 장바구니 관련 컨트롤러 =========================================
	
	// 로그인한 유저가 장바구니에 담은 목록을 addAttribute 해서 view 에 넘겨주기
	@RequestMapping("cart.po")
	public String productCartForm(Model model, HttpSession session) {
	 	Member m =  (Member)session.getAttribute("loginUser");
	 	
	 	ArrayList<ProductCart> carts = memberService.selectProductCartList(m);
	 	// 조회 결과 받아온 장바구니 품목들을 pdForCart 속성을 중심으로 묶음
	 	Map<Product, List<ProductCart>> groupedCarts = new HashMap<>();
	 	
	 	for(ProductCart cart : carts) {
	 		//pdForCart값 추출
	 		Product product = cart.getPdForCart();
	 		//pdForCart 값을 key로 갖는 쌍의 존재 여부를 분기
	 		//해당하는 키 값이 없다면 해당 키 값의 쌍을 생성한 후에 cart 변수 넣어주기
	 		if(!groupedCarts.containsKey(product)) {
	 			groupedCarts.put(product, new ArrayList<>());
	 		}
	 		//해당하는 키값이 있다면 cart 변수 바로 add
	 		groupedCarts.get(product).add(cart);
	 	}
	 	// 묶은 결과를 model.addAttribute 해서 jsp 로 넘김
	 	model.addAttribute("groupedCarts", groupedCarts);
	 	
		return "shopping/shoppingCartForm";
	}
	
	
	// 장바구니 저장하기 위한 메소드
	@ResponseBody
	@PostMapping(value = "ajaxInsertCart.po", produces = "application/json; charset=utf-8")
	public String ajaxInsertCart(@RequestBody List<ProductCart> pdCarts, HttpSession session) {		
		Member m = (Member) session.getAttribute("loginUser");
		
		int memberNo = m.getMemberNo();
	    // 각 ProductCart 객체에 memberNo를 설정
	    for (ProductCart cart : pdCarts) {
	        cart.setMemberNo(memberNo);
	    }
	    return new Gson().toJson(memberService.insertProductCart(pdCarts) > 0 ? "success" : "fail");
	}
	
	@ResponseBody
	@PostMapping(value = "ajaxDeleteCart.po")
	public String ajaxDeleteCart(@RequestBody List<Integer> optListForDelete, HttpSession session) {
		
		Member m = (Member)session.getAttribute("loginUser");
		
		int memberNo = m.getMemberNo();
		
		return memberService.deleteProductCart(memberNo, optListForDelete) > 0 ? "success" : "fail";
	}
	
	
	
	// ========================================== 주문 관련 컨트롤러 ========================================
	
	@RequestMapping("order.po")
	public String productOrderForm(String selectedOptList,  Model m) {
		System.out.println(selectedOptList);
		
		Gson gson = new Gson();
		// Gson 으로 JSON.stringfy() 한 것을 다시 객체 형태로 변환하기(Gson.fromJson() 사용 / 정석은 dto 사용)
		
		// 1. JSON 형태를 List 로 변경하기
		Type type = new TypeToken<List<ProductDetailOption>>(){}.getType();
		// 2. Type 객체를 넣기
		List<ProductDetailOption> opts = gson.fromJson(selectedOptList, type);
		
		// Product 객체를 key 값으로 갖는 Map 형태로 재구축
		Map<Product, List<ProductDetailOption>> groupedOpts = new HashMap<>();
		
		for(ProductDetailOption pdopt : opts) {
			Product p = pdopt.getPdForOpt();
			//p 값을 쌍으로 가진 데이터의 존재 여부 확인
			if(!groupedOpts.containsKey(p)) {
				// 없다면 새로운 쌍 생성
				groupedOpts.put(p, new ArrayList<>());
			};
			// 키 값이 있다면 value값 넣기
			groupedOpts.get(p).add(pdopt);
		}
		
		m.addAttribute("groupedOpts", groupedOpts);
		    
	    return "shopping/shoppingOrderForm";
	}

	
	// 주문 데이터 처리하는 컨트롤러
	@PostMapping(value = "insertOrder.po")
	public String insertProductOrder(@RequestParam("orderDataJson") String orderDataJson, HttpSession session) {
	
		// Gson을 사용하여 JSON 데이터를 처리
	    Gson gson = new Gson();
	    
	    // Map 으로 파싱
	    Type orderDataType = new TypeToken<Map<String, Object>>(){}.getType();
	    Map<String, Object> orderData = gson.fromJson(orderDataJson, orderDataType);
	    
	    //orderInfo 를 Order.class 형식으로 파싱
	    //orderInfo 추출
	    Order orderInfo = gson.fromJson(gson.toJson(orderData.get("orderInfo")), Order.class);
	    
	    // 로그인 유저 정보
	 	Member m = (Member)session.getAttribute("loginUser");
	 	orderInfo.setMemberNo(m.getMemberNo());
	    
	    //orderOpts 추출
	   Type orderOptsType = new TypeToken<List<OrderPdopt>>(){}.getType();
	   List<OrderPdopt> orderOpts = gson.fromJson(gson.toJson(orderData.get("orderOpts")), orderOptsType);
	    
	    int result = orderService.insertOrder(orderInfo, orderOpts);
	    
	    if(result == 0) {
	    	session.setAttribute("alertMsg", "주문 실패하였습니다.");
	    } else {
	    	session.setAttribute("alertMsg", "주문 성공하였습니다.");
	    }
	    
		return "redirect:/list.po";
	}
	
	//상품 스크랩
	@PostMapping("scrap.po")
	@ResponseBody
	public String scrapProduct(
			ScrapBoardDTO scrapBoardDTO) {
		
		int scrapProductResult = productService.insertScrapProduct(scrapBoardDTO);
		
		if(scrapProductResult == 1) {
			return "cancle_scrap";
		} else if (scrapProductResult == 2) {
			return "do_scrap";
		} else {
			return "undone";
		}
	}
}
