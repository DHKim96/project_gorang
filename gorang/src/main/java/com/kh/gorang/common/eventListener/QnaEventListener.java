package com.kh.gorang.common.eventListener;

import org.springframework.stereotype.Component;
import org.springframework.transaction.event.TransactionPhase;
import org.springframework.transaction.event.TransactionalEventListener;

import com.kh.gorang.common.event.QnaCreatedEvent;
import com.kh.gorang.member.model.dto.QnaDtoForNotify;
import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.member.service.MemberService;
import com.kh.gorang.notification.service.NotificationService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequiredArgsConstructor
public class QnaEventListener {
	
	private final NotificationService notificationService;
	
	private final MemberService memberService;
	
	// URL 경로
	private static final String PRODUCT_DETAIL_URL = "/detail.po?pno=";
	private static final String RECIPE_DETAIL_URL = "/detailForm.re?recipeNo=";
	
	
	// 트랜잭션 커밋 후 이벤트 발행 실행되도록 보장
	@TransactionalEventListener(phase = TransactionPhase.AFTER_COMMIT)
	private void handleQnaCreated(QnaCreatedEvent event) {
		log.info("Starting handleQnaCreated for event: {}", event);
		// qna 객체 가져오기
		QnaDtoForNotify qna = event.getQna();
		
		// 질의응답이 상품인지(1) 레시피인지(2) 구분
		int typeOfQna = qna.getQnaType();
		// 질문글인지(1) 답변글인지(2) 구분
		int questionOrAnswer = qna.getQuestionOrAnswer();
		
		// 수신자 정보 구분하기
		int writerNo = (questionOrAnswer == 1) ?  // 질문글인지 답변글인지 구분
	               (typeOfQna == 1 ? event.getProductSellerNo() : event.getRecipeWriterNo()) : // 질문글일시 레시피 작성자/상품 작성자 구분
	               event.getQuestionWriterNo(); // 답변글일시 질문글 작성자
		
		// ===================== 알림 수신인 정보 가져오기 =====================
		Member writer = memberService.getMemberByNo(writerNo);
		log.info("handleQnaCreated method receiver: {}", writer.getMemberEmail());
		
		// ====================== 알림의 내용 작성하기 =======================
		String content = createNotificationContent(qna, typeOfQna, questionOrAnswer);
		
		// ============================== url 작성 =====================
		String url = (typeOfQna == 1) ? PRODUCT_DETAIL_URL + qna.getRefProductNo() : RECIPE_DETAIL_URL + qna.getRefRecipeNo();
		
		// =============================== 알림 전송 ====================
		notificationService.send(writer, 3, content.toString(), url);
		log.info("Finished handleQnaCreated for event: {}", event);
	}
	
	// 알림 내용 작성하는 메소드
	private String createNotificationContent(QnaDtoForNotify qna, int typeOfQna, int questionOrAnswer) {
	    StringBuilder content = new StringBuilder();

	    content.append(qna.getWriterNickname()).append("님이 ");

	    if (questionOrAnswer == 1) {
	        if (typeOfQna == 1) {
	            content.append("\"").append(qna.getProductName()).append("\" 상품에 대한 질문을 작성하였습니다.");
	        } else {
	            content.append("\"").append(qna.getRecipeTitle()).append("\" 레시피에 대한 질문을 작성하였습니다.");
	        }
	    } else {
	        if (typeOfQna == 1) {
	            content.append("\"").append(qna.getProductName()).append("\" 상품에 대한 질문글에 답변이 달렸습니다.");
	        } else {
	            content.append("\"").append(qna.getRecipeTitle()).append("\" 레시피에 대한 질문글에 답변이 달렸습니다.");
	        }
	    }

	    return content.toString();
	}
}
