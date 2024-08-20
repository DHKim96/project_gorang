package com.kh.gorang.notification.repository;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.kh.gorang.notification.model.dao.NotificationDao;
import com.kh.gorang.notification.model.vo.NotifyDto;

@Repository
public class NotificationRepositoryImpl implements NotificationRepository{
	@Autowired
	private SqlSessionTemplate sqlSession; // 기존의 myBaits SqlSession객체 대체
	
	@Autowired
	private NotificationDao notificationDao;
	
	// 알림 객체 저장하는 메소드
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int insertNotification(NotifyDto notificationData) {
		return notificationDao.insertNotification(sqlSession, notificationData);
	}
	
	// 알림 객체 리스트 반환하는 메소드
	@Transactional(readOnly = true)
	@Override
	public ArrayList<NotifyDto> selectNotificationsByMemberNo(int memberNo) {
		return notificationDao.selectNotificationsByMemberNo(sqlSession, memberNo);
	}
	
	// 알림 삭제하는 메소드
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int deleteNotificationByNotifyNo(int notifyNo) {
		return notificationDao.deleteNotificationByNotifyNo(sqlSession, notifyNo);
	}
	
	// 알림 isRead = true 로 수정하는 메소드
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public int updateNotificationIsReadTrueByNotifyNo(int notifyNo) {
		return notificationDao.updateNotificationIsReadTrueByNotifyNo(sqlSession, notifyNo);
	}
}
