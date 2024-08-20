package com.kh.gorang.common.event;

import com.kh.gorang.member.model.dto.ReviewDtoForNotify;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Builder
public class ReviewCreatedEvent {
	private ReviewDtoForNotify review;
	private int productSellerNo;
	private int recipeWriterNo;
}
