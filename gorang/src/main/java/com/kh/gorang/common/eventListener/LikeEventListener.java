package com.kh.gorang.common.eventListener;

import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;
import org.springframework.transaction.event.TransactionPhase;
import org.springframework.transaction.event.TransactionalEventListener;

import com.kh.gorang.common.event.LikeCreatedEvent;
import com.kh.gorang.member.model.dto.LikeDtoForNotify;
import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.member.service.MemberService;
import com.kh.gorang.notification.service.NotificationService;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class LikeEventListener {
	private final NotificationService notificationService;
	private final MemberService memberService; // 회원 정보를 조회할 수 있는 서비스
	
	// URL 경로
	private static final String BOARD_DETAIL_URL = "/detail.bo?boardNo=";
	private static final String RECIPE_DETAIL_URL = "/detailForm.re?recipeNo=";
	
	// 트랜잭션 커밋 후 이벤트 발행 실행되도록 보장
	@TransactionalEventListener(phase = TransactionPhase.AFTER_COMMIT)
	private void handleLikeCreated(LikeCreatedEvent event) {
		// typeOfLike가 1이면 게시글 좋아요, 2이면 레시피 좋아요
		int typeOfLike = event.getLikeType();
		
		// =============================== 작성자 no 추출 ===========================
		int writerNo = ( typeOfLike == 1 ) ? event.getBoardWriterNo() : event.getRecipeWriterNo();
		
		// 좋아요 누른 유저의 닉네임
		LikeDtoForNotify like = event.getLike();
		
		// 작성자에게 알림 전송
		Member writer = memberService.getMemberByNo(writerNo);
		
		// ================================== 알림 내용 생성 =========================
		String content = like.getMemberName() + "님이 작성글에 좋아요 표시를 했습니다.";
		
		// =================================== url 생성 =========================
		String url = ( typeOfLike == 1 ) ? BOARD_DETAIL_URL + like.getBoardNo() : RECIPE_DETAIL_URL + like.getRecipeNo(); 
		
		notificationService.send(writer, 1, content, url);
	}
}
