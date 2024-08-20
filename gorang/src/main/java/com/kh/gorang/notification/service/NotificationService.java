package com.kh.gorang.notification.service;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.notification.model.vo.NotifyDto;
import com.kh.gorang.notification.repository.EmitterRepository;
import com.kh.gorang.notification.repository.NotificationRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class NotificationService{
	// SSE 연결 지속 시간 설정
	private static final Long DEFAULT_TIMEOUT = 60L * 1000 * 60;
	
	private final EmitterRepository emitterRepository;
	private final NotificationRepository notificationRepository;
	
	// ============== subscribe 관련 메소드 ===============
	public SseEmitter subscribe(String memberId, String lastEventId, HttpServletResponse response) { 
		// Controller에서 가져온 사용자의 id(memberNo)와 Last-Event-Id값(마지막 이벤트 식별자)을 파라미터로 받음
		
		// makeTimeIncludeId()로 SseEmitter 식별 목적의 고유 아이디 생성
		String emitterId = makeTimeIncludeId(memberId);
		
		// SseEmitter 객체 생성 및 저장
		SseEmitter emitter = emitterRepository.save(emitterId, new SseEmitter(DEFAULT_TIMEOUT));
		log.info("Emitter saved with id: {}", emitterId);
		
		response.setHeader("X-Accel-Buffering", "no"); // NGINX PROXY 에서의 필요설정 불필요한 버퍼링방지
		
		// onCompletion()(SseEmitter 완료 시) 메서드 사용해 SseEmitter 삭제
		emitter.onCompletion(() -> {
			emitterRepository.deleteById(emitterId);
			 log.info("Emitter completed and removed with id: {}", emitterId);
		});
		
		//onTimeout()(SseEmitter 지속 시간동안 이벤트 미전송 시) 
		emitter.onTimeout(() -> { 
			emitterRepository.deleteById(emitterId);
			log.info("Emitter timed out and removed with id: {}", emitterId);
		});
		
		// 503 에러 방지 목적의 더미 이벤트 전송
		String eventId = makeTimeIncludeId(memberId);
		sendNotification(emitter, eventId, emitterId, createDummyNotification(memberId));
		
		// 클라이언트가 미수신한 Event 목록이 존재할 경우 전송하여 Event 유실 예방
		if(hasLostData(lastEventId)) {
			sendLostData(lastEventId, memberId, emitterId, emitter);
		}
		
		return emitter;
	}
	
	private void sendNotification(SseEmitter emitter, String eventId, String emitterId, Object data) {
		try {
			emitter.send(SseEmitter.event()
							.id(eventId)
							.name("sse")
							.data(data, MediaType.APPLICATION_JSON)
							);
			log.info("Notification sent successfully to emitter: {}", emitterId); // 성공 시 로그
		} catch (IOException e) {
			log.error("Failed to send notification to emitter: {}", emitterId, e); // 예외 로그
			emitterRepository.deleteById(emitterId);
		}
	}
	
	private NotifyDto createDummyNotification(String memberId) {
		return NotifyDto.builder()
				.refMemberNo(Integer.parseInt(memberId))
				.notifyType(-1) // 더미 데이터임을 나타내는 특수 값
				.content("EventStream Created.")
				.notifyUrl(null)
				.isRead(false)
				.build();
	}
	
	private boolean hasLostData(String lastEventId) {
		return !(lastEventId == null);
	}
	
	private void sendLostData(String lastEventId, String memberId, String emitterId, SseEmitter emitter) {
		Map<String, Object> eventCaches = emitterRepository.findAllEventCacheStartWithByMemberId(memberId);
		eventCaches.entrySet().stream()
			.filter(entry -> lastEventId.compareTo(entry.getKey()) < 0)
			.forEach(entry -> sendNotification(emitter, entry.getKey(), emitterId, entry.getValue()));
	}
	
	
	
	// ============================ send 관련 메소드 ==========================
	@Transactional(rollbackFor = {Exception.class})
	public void send(Member receiver, int notificationType, String content, String url) {
		 // 메소드 호출 로그 추가
	    log.info("send method called for receiver: {}", receiver.getMemberEmail());
		
		// NotifyDto 객체 생성
		NotifyDto notification = NotifyDto.builder()
									.refMemberNo(receiver.getMemberNo())
									.notifyType(notificationType)
									.content(content)
									.notifyUrl(url)
									.isRead(false)
									.build();
		// insert 실시
		int result = notificationRepository.insertNotification(notification);
		// insert 성공 시 이하 작업 수행
		if ( result > 0 ) {
			String receiverId = String.valueOf(receiver.getMemberNo());
			String eventId = makeTimeIncludeId(receiverId);
			Map<String, SseEmitter> emitters = emitterRepository.findAllEmitterStartWithByMemberId(receiverId);
			log.info("Found emitters: {}", emitters.size()); // Emitter 수 확인 로그 추가
			
			emitters.forEach(
					(key, emitter) -> {
						emitterRepository.saveEventCache(key, notification);
						sendNotification(emitter, eventId, key, notification);
					}
			);
		}
	}
	
	
	// ======================= 공용 메소드 ===================
	private String makeTimeIncludeId(String email) {
		return email + "_" + System.currentTimeMillis();
	}
	
}
