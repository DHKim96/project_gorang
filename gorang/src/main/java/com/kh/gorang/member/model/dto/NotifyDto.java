package com.kh.gorang.member.model.dto;

import java.sql.Date;

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
public class NotifyDto {
	private int no;
	private boolean isRead;
	private int notifyType;
	private String content;
	private Date createAt;
	private String notifyUrl;
	private int refMemberNo;
}
