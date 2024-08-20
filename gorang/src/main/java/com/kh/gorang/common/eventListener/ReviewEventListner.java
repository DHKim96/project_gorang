package com.kh.gorang.common.eventListener;

import org.springframework.stereotype.Component;
import org.springframework.transaction.event.TransactionPhase;
import org.springframework.transaction.event.TransactionalEventListener;

import com.kh.gorang.common.event.ReviewCreatedEvent;
import com.kh.gorang.member.model.dto.QnaDtoForNotify;
import com.kh.gorang.member.model.dto.ReviewDtoForNotify;
import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.member.service.MemberService;
import com.kh.gorang.notification.service.NotificationService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequiredArgsConstructor
public class ReviewEventListner {
	private final NotificationService notificationService;
	private final MemberService memberService;
	
	// URL 경로
	private static final String PRODUCT_DETAIL_URL = "/detail.po?pno=";
	private static final String RECIPE_DETAIL_URL = "/detailForm.re?recipeNo=";
	
	@TransactionalEventListener(phase = TransactionPhase.AFTER_COMMIT)
	private void handleReviewCreated(ReviewCreatedEvent event) {
		log.info("Starting handleReviewCreated for event: {}", event);
		
		// review 객체 가져오기
		ReviewDtoForNotify review = event.getReview();
		
		int type = review.getType(); // 상품리뷰(1) 레시피리뷰(2)
		// 수신인 번호 추출
		int writerNo =  type == 1 ? event.getProductSellerNo() : event.getRecipeWriterNo();
		
		// 수신인 정보 추출
		Member writer = memberService.getMemberByNo(writerNo);
		
		// 알림 내용 작성
		String content = createNotificationContent(review, type);
		
		// url 생성
		String url = (type == 1) ? PRODUCT_DETAIL_URL + review.getRefProductNo() : RECIPE_DETAIL_URL + review.getRefRecipeNo();
	
		// 알림 전송
		notificationService.send(writer, 4, content, url);
		
		log.info("Finished handleReviewCreated for event: {}", event);
	}
	
	// 알림 내용 작성하는 메소드
	private String createNotificationContent(ReviewDtoForNotify review, int type) {
	    StringBuilder content = new StringBuilder();

	    content.append(review.getWriterNickname()).append("님이 ");
	    
	    if ( type == 1 ) content.append("\"").append(review.getProductName()).append("\" 상품에 대한 리뷰를 작성하였습니다.");
	    else content.append("\"").append(review.getRecipeTitle()).append("\" 레시피에 대한 리뷰를 작성하였습니다.");

	    return content.toString();
	}
}
