package com.kh.gorang.notification.repository;

import java.util.ArrayList;

import com.kh.gorang.notification.model.vo.NotifyDto;

public interface NotificationRepository {
	int insertNotification(NotifyDto notificationData);

	ArrayList<NotifyDto> selectNotificationsByMemberNo(int memberNo);

	int deleteNotificationByNotifyNo(int notifyNo);
}
