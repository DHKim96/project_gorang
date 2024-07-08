package com.kh.gorang.member.model.vo;

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
	private int notifyType;
	private String notifyContent;
	private Date notifyCreateAt;
	private String notifyUrl;
	private int notifyMemberNo;
}
