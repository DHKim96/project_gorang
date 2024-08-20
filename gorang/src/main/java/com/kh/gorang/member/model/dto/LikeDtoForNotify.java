package com.kh.gorang.member.model.dto;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor

public class LikeDtoForNotify {
	private String memberName;
	private int boardNo;
	private int recipeNo;
}
