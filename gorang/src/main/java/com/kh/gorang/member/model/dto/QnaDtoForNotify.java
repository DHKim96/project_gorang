package com.kh.gorang.member.model.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class QnaDtoForNotify {
	private String qnaContent;
	// 상품(1), 레시피(2) 구분
	private int qnaType;
	private int refProductNo;
	private String productName;
	private int refRecipeNo;
	private String recipeTitle;
	// 질문(1), 답변(2) 구분
	private int QuestionOrAnswer;
	// 작성자 닉네임
	private String writerNickname;
}
