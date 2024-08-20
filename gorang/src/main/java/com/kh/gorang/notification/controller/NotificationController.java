package com.kh.gorang.notification.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.kh.gorang.notification.model.vo.NotifyDto;
import com.kh.gorang.notification.repository.NotificationRepository;
import com.kh.gorang.notification.service.NotificationService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/notifications")
@RequiredArgsConstructor
public class NotificationController {
	
	private final NotificationService notificationService;
	private final NotificationRepository notificationRepository;
	
	/**
	 * SSE 연결하는 메소드
	 * @param id
	 * @param lastEventId
	 * @param response
	 * @return
	 */
	@GetMapping(value = "/subscribe/{id}", produces = "text/event-stream")
	public SseEmitter subscribe(@PathVariable int id,
								@RequestHeader(value = "Last-Event-ID", required = false) String lastEventId,
								HttpServletResponse response) {
		if (lastEventId == null || lastEventId.trim().isEmpty()) {
	        lastEventId = null; // 유실 데이터 존재 인식하여 중복 전송하는 것 방지 목적
	    }
		return notificationService.subscribe(String.valueOf(id), lastEventId, response);
	}
	
	/**
	 * 유저가 읽지 않은 모든 알림을 가져오는 메소드
	 * @param memberNo
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/getAlarmsByAjax.me", produces = "application/json; charset=utf8") 
	public ArrayList<NotifyDto> getAlarmsByAjax(int memberNo) {
		return notificationRepository.selectNotificationsByMemberNo(memberNo);
	}
	
	/**
	 * 알림을 삭제하는 메소드
	 * @param notifyNo
	 * @param memberNo
	 * @return 삭제 후 남은 알림들을 반환
	 */
	@ResponseBody
	@RequestMapping(value="/deleteNotificationByAjax", produces = "application/json; charset=utf8")
	public ArrayList<NotifyDto> deleteNotificationByAjax(int notifyNo, int memberNo) {
		int result = notificationRepository.deleteNotificationByNotifyNo(notifyNo);
		return result > 0 ? notificationRepository.selectNotificationsByMemberNo(memberNo) : null;
	}
	
	/**
	 * 알림 isRead = true 로 수정하는 메소드
	 * @param notifyNo
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/updateNotificationIsReadTrueByAjax", produces = "application/json; charset=utf8")
	public int updateNotificationIsReadTrueByAjax(int notifyNo) {
		return notificationRepository.updateNotificationIsReadTrueByNotifyNo(notifyNo);
	}
	
	
}