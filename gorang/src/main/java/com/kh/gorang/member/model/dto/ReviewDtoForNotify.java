package com.kh.gorang.member.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Getter
@Builder
public class ReviewDtoForNotify {
	private String content;
	// 상품(1), 레시피(2) 구분
	private int type;
	private int refProductNo;
	private String productName;
	private int refRecipeNo;
	private String recipeTitle;
	// 작성자 닉네임
	private String writerNickname;
}
