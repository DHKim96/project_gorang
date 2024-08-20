package com.kh.gorang.member.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@ToString
@Builder
public class RefrigeratorDtoForNotify {
	private int refriNo;
	private int refMemberNo;
	// 식재료명
	private String name;
	private Date refConsumptionDate;
	private Date refInputDate;
}
