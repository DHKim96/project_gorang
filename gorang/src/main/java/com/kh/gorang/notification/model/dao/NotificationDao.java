package com.kh.gorang.notification.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.gorang.notification.model.vo.NotifyDto;

@Repository
public class NotificationDao {
	public int insertNotification(SqlSessionTemplate sqlSession, NotifyDto notificationData) {
		return sqlSession.insert("notifyMapper.insertNotification", notificationData);
	}

	public ArrayList<NotifyDto> selectNotificationsByMemberNo(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("notifyMapper.selectNotificationsByMemberNo", memberNo);
	}

	public int deleteNotificationByNotifyNo(SqlSessionTemplate sqlSession, int notifyNo) {
		return sqlSession.delete("notifyMapper.deleteNotificationByNotifyNo", notifyNo);
	}

	public int updateNotificationIsReadTrueByNotifyNo(SqlSessionTemplate sqlSession, int notifyNo) {
		return sqlSession.update("notifyMapper.updateNotificationIsReadTrueByNotifyNo", notifyNo);
	}
}
