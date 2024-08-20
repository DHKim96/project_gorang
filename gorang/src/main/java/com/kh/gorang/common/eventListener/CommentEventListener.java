package com.kh.gorang.common.eventListener;

import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;
import org.springframework.transaction.event.TransactionPhase;
import org.springframework.transaction.event.TransactionalEventListener;

import com.kh.gorang.board.model.dto.CommentDtoForNotify;
import com.kh.gorang.common.event.CommentCreatedEvent;
import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.member.service.MemberService;
import com.kh.gorang.notification.service.NotificationService;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class CommentEventListener {
	
	private final NotificationService notificationService;
	private final MemberService memberService; // 회원 정보를 조회할 수 있는 서비스
	
	// URL 경로
	private static final String BOARD_DETAIL_URL = "/detail.bo?boardNo=";
	
	// 트랜잭션 커밋 후 이벤트 발행 실행되도록 보장
	@TransactionalEventListener(phase = TransactionPhase.AFTER_COMMIT)
	public void handleCommentCreated(CommentCreatedEvent event) {
		int boardWriterNo = event.getBoardWriterNo();
		CommentDtoForNotify comment = event.getComment();
		
		// 게시글 작성자에게 알림 전송
		Member boardWriter = memberService.getMemberByNo(boardWriterNo); //작성자 정보 조회 
		String content = "게시글에 새로운 댓글이 달렸습니다\n" + "\"" + comment.getContent() + "\"";
        String url = BOARD_DETAIL_URL + comment.getBoardNo();
        
        notificationService.send(boardWriter, 2, content, url);
	}
}
