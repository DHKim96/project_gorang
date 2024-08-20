package com.kh.gorang.notification.repository;

import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Repository
public interface EmitterRepository {
	// emitter 저장
	SseEmitter save(String emitterId, SseEmitter emitter);
	// 이벤트 저장
	void saveEventCache(String eventCacheId, Object event);
	// 해당 회원과 관련된 모든 이벤트 탐색
	Map<String, SseEmitter> findAllEmitterStartWithByMemberId(String memberId);
	Map<String, Object> findAllEventCacheStartWithByMemberId(String memberId);
	// emitter 삭제
	void deleteById(String id);
	// 해당 회원과 관련된 모든 emitter 삭제
	void deleteAllEmitterStartWithMemberId(String memberId);
	// 해당 회원과 관련된 모든 이벤트 삭제
	void deleteAllEventCacheStartWithMemberId(String memberId);
}
