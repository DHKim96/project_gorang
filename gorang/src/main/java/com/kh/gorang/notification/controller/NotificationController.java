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
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/notifications")
@RequiredArgsConstructor
public class NotificationController {
	
	private final NotificationService notificationService;
	private final NotificationRepository notificationRepository;

	@GetMapping(value = "/subscribe/{id}", produces = "text/event-stream")
	public SseEmitter subscribe(@PathVariable int id,
								@RequestHeader(value = "Last-Event-ID", required = false, defaultValue = " ") String lastEventId,
								HttpServletResponse response) {
		
		System.out.println("id : " + id);
		return notificationService.subscribe(String.valueOf(id), lastEventId, response);
	}
	
	@ResponseBody
	@RequestMapping(value="/getAlarmsByAjax.me", produces = "application/json; charset=utf8") 
	public ArrayList<NotifyDto> getAlarmsByAjax(int memberNo) {
		return notificationRepository.selectNotificationsByMemberNo(memberNo);
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteNotificationByAjax", produces = "application/json; charset=utf8")
	public ArrayList<NotifyDto> deleteNotificationByAjax(int notifyNo, int memberNo) {
		log.info("[알림 삭제 메소드] 알림 번호 : {}", notifyNo);
		log.info("[알림 삭제 메소드] 유저 번호 : {}", memberNo);
		int result = notificationRepository.deleteNotificationByNotifyNo(notifyNo);
		return result > 0 ? notificationRepository.selectNotificationsByMemberNo(memberNo) : null;
	}
}
