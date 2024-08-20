package com.kh.gorang.common.eventPublisher;

import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;

import com.kh.gorang.common.event.QnaCreatedEvent;
import com.kh.gorang.member.model.dto.QnaDtoForNotify;
import com.kh.gorang.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class QnaEventPublisher {
	/*
	 * qna 이벤트 발행은 레시피 qna, 상품 qna 에서 모두 사용되면서
	 * 질의/응답 여부에 따라 복잡해지기 때문에 따로 분리하였음
	 */
	private final ApplicationEventPublisher eventPublisher;
	
	public void publishQnaEvent(QnaDtoForNotify qnaDto, Member writer, Member questionWriter) {
		int writerNo = writer.getMemberNo();
		// 빌더 패턴
	    QnaCreatedEvent.QnaCreatedEventBuilder eventBuilder = QnaCreatedEvent.builder()
	        .qna(qnaDto);
	    
	    // qna 타입 구분 상품(1) / 레시피(2)
	    if( qnaDto.getQnaType() == 1 ) eventBuilder.productSellerNo(writerNo);
	    else eventBuilder.recipeWriterNo(writerNo);
	    
	    // 질문글이라면
	    if (questionWriter != null) {
	        eventBuilder.questionWriterNo(questionWriter.getMemberNo());
	    }
	    
	    eventPublisher.publishEvent(eventBuilder.build());
	}
}
