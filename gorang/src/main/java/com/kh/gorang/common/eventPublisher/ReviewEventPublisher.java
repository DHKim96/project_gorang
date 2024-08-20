package com.kh.gorang.common.eventPublisher;

import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;

import com.kh.gorang.common.event.ReviewCreatedEvent;
import com.kh.gorang.member.model.dto.ReviewDtoForNotify;
import com.kh.gorang.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewEventPublisher {
	private final ApplicationEventPublisher eventPublisher;
	
	public void publishReviewEvent(ReviewDtoForNotify review, Member writer) {
		int writerNo = writer.getMemberNo();
		
		// 이벤트 객체 생성
		ReviewCreatedEvent.ReviewCreatedEventBuilder eventBuilder = ReviewCreatedEvent.builder()
																	.review(review);
		
		// 타입에 따라 분류 상품리뷰(1) / 레시피리뷰(2)
		if ( review.getType() == 1 ) eventBuilder.productSellerNo(writerNo);
		else eventBuilder.recipeWriterNo(writerNo);
		
		// 이벤트 발행
		eventPublisher.publishEvent(eventBuilder.build());
	}
}
