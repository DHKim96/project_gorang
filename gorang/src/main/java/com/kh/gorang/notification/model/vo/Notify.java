package com.kh.gorang.notification.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class Notify {
	private int notifyNo;
	private boolean notifyIsRead;
	private int notifyType; // 좋아요(1)/댓글(2)/문의(3)/후기(4)/소비기한(5)
	private String notifyContent;
	private Date notifyCreateAt;
	private String notifyUrl;
	private int notifyMemberNo;
}
