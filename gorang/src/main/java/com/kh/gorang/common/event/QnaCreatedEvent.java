package com.kh.gorang.common.event;

import com.kh.gorang.member.model.dto.QnaDtoForNotify;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Builder
public class QnaCreatedEvent {
	private QnaDtoForNotify qna;
	private int productSellerNo;
	private int recipeWriterNo;
	// 답변글일 경우 질문글 작성자
	private int questionWriterNo;
}
