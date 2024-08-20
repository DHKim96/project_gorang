package com.kh.gorang.notification.model.vo;

import java.sql.Date;

import com.kh.gorang.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
@Builder
public class NotifyDto {
	private int no;
	private boolean isRead;
	private int notifyType; // 좋아요(1)/댓글(2)/문의(3)/후기(4)/소비기한(5)
	private String content;
	private Date createAt;
	private String notifyUrl;
	private int refMemberNo;
	private String refMemberEmail;
}
